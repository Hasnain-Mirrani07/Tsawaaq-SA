import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/product_details/product_details_manager.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class ProductDetailsSlider extends StatelessWidget {
  final List? sliderItems;
  final double? sliderHeight;

  ProductDetailsSlider({Key? key, this.sliderItems, this.sliderHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailsManager = context.use<ProductDetailsManager>();

    return Container(
      height: sliderHeight,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              // autoPlay: widget.sliderList!.length > 1,
                autoPlay: sliderItems!.length > 1,
                enlargeCenterPage: false,
                aspectRatio: 2,
                padEnds: false,
                viewportFraction: 1,
                disableCenter: true,
                onPageChanged: (index, reason) {
                  // inIndicatorIndex.add(index);
                }),
            // onImageChange: (x, y) {
            //   inIndicatorIndex.add(y);
            //   // print("XXXXXX$y");
            // },
            // boxFit: BoxFit.fill,
            // overlayShadow: true,
            // autoplay: true,
            // animationCurve: Curves.fastOutSlowIn,
            // animationDuration:
            //     Duration(seconds: widget.sliderDuration),
            // showIndicator: false,
            // indicatorBgPadding: 0.0,
            // images: ,
            items:  sliderItems!
                .map((e) => NetworkAppImage(
                width: double.infinity,
                boxFit: BoxFit.fill,
                imageUrl: '$e'))
                .toList(),),
          Positioned(
              bottom: 35,
              right: 15,
              left: 15,
              child: ValueListenableBuilder<int>(
                  valueListenable: productDetailsManager.indicatorNotifier,
                  builder: (context, indicatorSubjectValue, _) {
                    return Container(
                      height: 8,
                      child: Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: sliderItems!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: indicatorSubjectValue == index
                                      ? AppStyle.yellowButton
                                      : Color(0xff707070),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                width: 8,
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                // padding: EdgeInsets.symmetric(horizontal: 5),
                              );
                            }),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
