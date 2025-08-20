import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_core/services/media_service/media_Service.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class AvatarWidget extends StatefulWidget {
  final imageUrl;
  const AvatarWidget({Key? key, this.imageUrl}) : super(key: key);

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  // padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    child: locator<MediaService>().hasSelectedImage
                        ? Image.file(
                            File(locator<MediaService>().selectedImage.path),
                            fit: BoxFit.fill,
                          )
                        :ApiImage(imageUrl: "${widget.imageUrl}",),
                        // : NetworkAppImage(
                        //     boxFit: BoxFit.fill,
                        //     // height: containerHeight,
                        //     // width: itemWidth,
                        //     imageUrl: "${widget.imageUrl}",
                        //   ),
                    // Image.network(
                    //   "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg",
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                      height: 100,
                      width: 100,
                      child: InkWell(
                          onTap: () async {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                actions: [
                                  CupertinoActionSheetAction(
                                    child: Text(
                                        '${AppLocalizations.of(context)!.translate(AppStrings.Camera)}'),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await locator<MediaService>()
                                          .getImage(fromGallery: false)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: Text(
                                        '${AppLocalizations.of(context)!.translate(AppStrings.Gallery)}'),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await locator<MediaService>()
                                          .getImage(fromGallery: true)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white70,
                            size: 35,
                          ))),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class ApiImage extends StatelessWidget {
  final imageUrl;
  const ApiImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl == ""
        ? SvgPicture.asset(
      '${AppAssets.noun_User}',
      color: AppStyle.blueTextButton,
    ): NetworkAppImage(
      boxFit: BoxFit.fill,
      // height: containerHeight,
      // width: itemWidth,
      imageUrl: "$imageUrl",
    );
  }
}
