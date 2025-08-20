import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/offer_details/offer_details_response.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

///////////////////////////////////////////////////////////////////////////////
/// Custom alert dialog.
/// ///////////////////////////////////////////////////////////////////////////
class QRCodeDialog extends StatelessWidget {
  final VoidCallback? onClickConfirmBtn;
  final OfferDetailsData? offerDetailsData;

  const QRCodeDialog({
    this.onClickConfirmBtn,
    this.offerDetailsData,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    // final prefs = context.use<PrefsService>();

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            // height: MediaQuery.of(context).size.height *.75,
            width: 300.w,
            padding: EdgeInsets.only(
              bottom: 40,
              top: 16,
              left: 16,
              right: 16,
            ),
            margin: EdgeInsets.only(top: 16, bottom: 33),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${offerDetailsData?.title}',
                        style: AppFontStyle.blueTextH2,
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                      width: 60.w,
                      height: 60.w,
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: NetworkAppImage(
                            boxFit: BoxFit.fill,
                            imageUrl: '${offerDetailsData?.brandImage}',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Divider(),
                Container(
                  // height: 60.w,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: SvgPicture.asset(
                          AppAssets.PIN,
                          height: 30.h,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${context.translate(AppStrings.AvailableIn)}',
                                style: AppFontStyle.blueTextH4,
                              ),
                              Text('${offerDetailsData?.address}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                const SizedBox(
                  height: 20,
                ),
                NetworkAppImage(
                  boxFit: BoxFit.fill,
                  height: 175.h,
                  width: 175.h,
                  imageUrl: '${offerDetailsData?.qrImage}',
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Share.share('${offerDetailsData?.qrImage}');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RotatedBox(quarterTurns: 3, child: Icon(Icons.logout)),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        '${context.translate(AppStrings.SHARE)}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 70.w,
            left: 70.w,
            child: Container(
              padding: EdgeInsets.all(
                8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
              ),
              child: SizedBox(
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(color: AppStyle.yellowButton)),
                    backgroundColor: AppStyle.yellowButton,

                    shadowColor: AppStyle.yellowButton,
                    // fixedSize: width == 0
                    //     ? null
                    //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                    // padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('${context.translate(AppStrings.Close)}',
                      style: AppFontStyle.blueTextH2),
                  onPressed: onClickConfirmBtn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
