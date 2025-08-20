import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';
import 'package:tasawaaq/features/home/home_manager.dart';
import 'package:tasawaaq/features/home/home_response.dart';
import 'package:tasawaaq/features/home/widgets/advertisements_slider.dart';
import 'package:tasawaaq/features/home/widgets/featured_products.dart';
import 'package:tasawaaq/features/home/widgets/mall_stores_widget.dart';
import 'package:tasawaaq/shared/forms_header/forms_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TsawaaqSliderItems>? sliders = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<HomeManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeManager = context.use<HomeManager>();
    final filterManager = context.use<FilterManager>();

    return Observer<HomeResponse>(
        onRetryClicked: () {
          homeManager.execute();
        },
        manager: homeManager,
        stream: homeManager.home$,
        onSuccess: (context, homeSnapshot) {
          if (homeSnapshot.data!.products!.isNotEmpty) {
            filterManager.currency = homeSnapshot.data!.products![0].currency;
          }
          homeManager.homeSocial.clear();
          homeSnapshot.data!.socials!.forEach((element) {
            if (!homeManager.homeSocial.contains(element)) {
              homeManager.homeSocial.add(element);
            }
          });

          return homeSnapshot.data != null
              ? StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Center(
                      child: Container(
                        child: Container(
                          child: ListView(
                            physics: ClampingScrollPhysics(),
                            children: [
                              Stack(
                                children: [
                                  //   Container(
                                  //     height: 280.h,
                                  //     width: double.infinity,
                                  //   ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    bottom: 0,
                                    left: 0,
                                    child: FormsHeader(
                                      centerIcon: Container(),
                                      // bottomPadding: 25,
                                    ),
                                  ),
                                  TsawaaqSlider(
                                    isUrl: true,
                                    sliderList: homeSnapshot.data!.sliders,
                                    sliderHeight: 280.h,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (homeSnapshot.data!.malls!.isNotEmpty)
                                MallsOrStoresWidget(
                                  isStore: false,
                                  sliderList: homeSnapshot.data!.malls,
                                  title:
                                      '${context.translate(AppStrings.MALLS)}',
                                  containerHeight: 160.h,
                                  itemWidth: 150.h,
                                  onSingleItemClickBtn: () {
                                    print("onSingleItemClickBtn");
                                    Navigator.of(context)
                                        .pushNamed(AppRouts.MallDetailsPage);
                                  },
                                  onViewAllClickBtn: () {
                                    Navigator.of(context).pushNamed(
                                      AppRouts.MallsPage,
                                    );
                                  },
                                  // sliderList: [],
                                ),
                              if (homeSnapshot.data!.stores!.isNotEmpty)
                                MallsOrStoresWidget(
                                  isStore: true,
                                  sliderList: homeSnapshot.data!.stores,
                                  title:
                                      '${context.translate(AppStrings.STORES)}',
                                  containerHeight: 140.h,
                                  itemWidth: 190.h,

                                  onSingleItemClickBtn: () {
                                    print("onSingleItemClickBtn");
                                  },
                                  onViewAllClickBtn: () {
                                    print("onViewAllClickBtn");
                                    Navigator.of(context)
                                        .pushNamed(AppRouts.AllStoresPage);
                                  },
                                  // sliderList: [],
                                ),
                              TsawaaqSlider(
                                isUrl: true,
                                sliderList: homeSnapshot.data!.ads,
                                isCard: false,
                                sliderHeight: 230.h,
                              ),
                              if (homeSnapshot.data!.products!.isNotEmpty)
                                FeaturedProducts(
                                  products: homeSnapshot.data!.products,
                                ),
                              SizedBox(
                                height: 45,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }
}

class TsawaaqSliderItems {
  int? id;
  String? name;
  String? image;
  String? urlLink;

  TsawaaqSliderItems({this.id, this.name, this.image, this.urlLink});
}
