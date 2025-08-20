import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/home/home_response.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';
import 'package:tasawaaq/shared/url_launcher/url_launcher.dart';

class TsawaaqSlider extends StatefulWidget {
  final List<Sliders>? sliderList;
  final int sliderDuration;
  final bool isCard;
  final double sliderHeight;
  final bool isUrl;
  const TsawaaqSlider(
      {Key? key,
      this.sliderDuration = 1,
      this.sliderList,
      this.isCard = true,
      required this.isUrl,
      this.sliderHeight = 280})
      : super(key: key);

  @override
  _TsawaaqSliderState createState() => _TsawaaqSliderState();
}

class _TsawaaqSliderState extends State<TsawaaqSlider> {
  final BehaviorSubject<int> _indicatorSubject = BehaviorSubject<int>.seeded(0);
  Stream<int> get indicatorIndex$ => _indicatorSubject.stream;
  Sink<int> get inIndicatorIndex => _indicatorSubject.sink;
  // List images;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (widget.sliderList != null)
          ? Column(
              children: [
                SizedBox(
                  height: 14,
                ),
                Container(
                  height: widget.sliderHeight,
                  child: CarouselSlider(
                      options: CarouselOptions(
                        // autoPlay: widget.sliderList!.length > 1,
                          autoPlay: widget.sliderList!.length > 1,
                          enlargeCenterPage: false,
                          aspectRatio: 2,
                          padEnds: false,
                          viewportFraction: 1,
                          disableCenter: true,
                          onPageChanged: (index, reason) {
                            inIndicatorIndex.add(index);
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
                    items: widget.sliderList!
                        .map((e) => Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                          elevation: widget.isCard ? 4.0 : 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(
                                widget.isCard ? 8.0 : 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(25)),
                              child: InkWell(
                                onTap: () {
                                  if (widget.isUrl == true) {
                                    launchURL("${e.link}");
                                  }
                                },
                                child: NetworkAppImage(
                                  boxFit: BoxFit.fill,
                                  imageUrl: '${e.image}',
                                ),
                              ),
                            ),
                          )),
                    ))
                        .toList(),),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // color: Colors.red,
                  child: StreamBuilder(
                      initialData: 0,
                      stream: indicatorIndex$,
                      builder: (context, indexSnapshot) {
                        return Container(
                          height: 10,
                          child: Center(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.sliderList!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: indexSnapshot.data == index
                                          ? AppStyle.yellowButton
                                          : Color(0xffA2ADB5),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    height: 5,
                                    width:
                                        indexSnapshot.data == index ? 20 : 10,
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    // padding: EdgeInsets.symmetric(horizontal: 5),
                                  );
                                }),
                          ),
                        );
                      }),
                )
              ],
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    _indicatorSubject.close();
    super.dispose();
  }
}
