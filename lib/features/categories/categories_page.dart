import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/categories/categories_manager.dart';
import 'package:tasawaaq/features/categories/categories_response.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';
import 'package:tasawaaq/features/product_list/product_list_manager.dart';
import 'package:tasawaaq/features/product_list/product_list_page.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<CategoriesManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriesManager = context.use<CategoriesManager>();

    return Observer<CategoriesResponse>(
        onRetryClicked: () {
          categoriesManager.execute();
        },
        manager: categoriesManager,
        stream: categoriesManager.categories$,
        onSuccess: (context, categoriesSnapshot) {
          return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
              itemCount: categoriesSnapshot.data!.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    locator<ProductListManager>()
                        .cateId
                        .sink
                        .add("${categoriesSnapshot.data![index].id}");
                    locator<FilterManager>()
                        .cateIndexSubject
                        .sink
                        .add([categoriesSnapshot.data![index].id!]);
                    locator<ProductListManager>().storeId.sink.add("");
                    Navigator.of(context).pushNamed(
                      AppRouts.ProductsListPage,
                      arguments: ProductsListPageArgs(
                        cateId: "${categoriesSnapshot.data?[index].id}",
                        id: 0,
                        logo: "",
                        name: '${context.translate(AppStrings.Products)}',
                        // name: "${categoriesSnapshot.data![index].name}",
                        storeId: "",
                      ),
                    );
                  },
                  child: Container(
                    height: 155.h,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        // fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: NetworkAppImage(
                                boxFit: BoxFit.fill,
                                imageUrl:
                                    "${categoriesSnapshot.data![index].image}",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  '${categoriesSnapshot.data![index].name}',
                                  style: AppFontStyle.bigHeaderText,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
