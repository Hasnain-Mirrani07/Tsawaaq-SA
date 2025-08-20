import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/favorite/add_remove_favorite/manager.dart';
import 'package:tasawaaq/features/home/home_manager.dart';
import 'package:tasawaaq/features/home/home_response.dart';
import 'package:tasawaaq/features/product_details/product_details_page.dart';
import 'package:tasawaaq/shared/fav_guest_dialog/fav_guest_dialog.dart';
import 'package:tasawaaq/shared/product_item/product_item.dart';

class FeaturedProducts extends StatelessWidget {
  final List<Products>? products;
  const FeaturedProducts({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addRemoveFavoriteManager = context.use<AddRemoveFavoriteManager>();
    final homeManager = context.use<HomeManager>();

    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${context.translate(AppStrings.FEATURED_PRODUCTS)}',
                    style: AppFontStyle.blueTextH3,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: 55,
                    height: 1,
                    color: AppStyle.yellowButton,
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRouts.FeaturedProductsPage,
                  );
                },
                child: Text(
                  '${context.translate(AppStrings.VIEW_ALL_H)}',
                  style: AppFontStyle.yellowTextH4,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: products!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed(
                  //   AppRouts.ProductDetails,
                  // );
                  Navigator.of(context).pushNamed(AppRouts.ProductDetails,
                      arguments: ProductDetailsArgs(
                          storeId: products![index].store!.id,
                          productId: products![index].id));
                },
                child: ProductItem(
                  storeName: products![index].store!.name,
                  // itemWidth: 100,
                  name: products![index].name,
                  price:
                      "${products![index].price} ${products![index].currency}",
                  isFavorite: products![index].isLiked == 1 ? true : false,
                  imgUrl: products![index].image,
                  dsc: "${products![index].shortDesc}",
                  itemBorderRadius: 15,
                  itemElevation: 3,
                  onClickFavoriteBtn: () {
    if(context.use<PrefsService>().userObj == null){
      favGuestDialog(context);
    }else{
      addRemoveFavoriteManager.addRemoveFavorite(id: products?[index].id)
          .then((value) {
        if (value == ManagerState.SUCCESS) {
          homeManager.execute();
        }
      });
    }


                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
