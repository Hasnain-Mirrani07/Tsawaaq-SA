import 'package:flutter/material.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/home/home_response.dart';
import 'package:tasawaaq/features/product_details/product_details_page.dart';
import 'package:tasawaaq/features/search/search_get/search_response.dart';
import 'package:tasawaaq/shared/favorite_item/favorite_item_widget.dart';
import 'package:tasawaaq/app_core/app_core.dart';

class RecentSearchesWidget extends StatelessWidget {
  final List<Products>? recentSearchList;
  final String? title;
  final double dividerHeight;
  final bool isDivider;

  const RecentSearchesWidget({Key? key,this.recentSearchList,this.title,this.dividerHeight = 50,this.isDivider= true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return recentSearchList!.isNotEmpty ? Container(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(isDivider == true)   Divider(
            height: dividerHeight,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text("$title",style: AppFontStyle.blueTextH2,),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              height: 95,
              child:  ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: recentSearchList!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(AppRouts.ProductDetails,
                              arguments: ProductDetailsArgs(
                                  storeId: recentSearchList![index].store!.id,
                                  productId: recentSearchList![index].id));
                        },
                        child: FavoriteItem(
                          name: "${recentSearchList![index].name}",
                          isFavIcon: false,
                          desc: "${recentSearchList![index].price} ${recentSearchList![index].currency}",
                          imgUrl: "${recentSearchList![index].image}",
                        ),
                      ),
                    );
                  })
          ),
          Divider(
            height: 50,
          )

        ],
      ),
    ):Container();
  }
}
