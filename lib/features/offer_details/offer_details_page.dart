import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/offer_details/offer_details_manager.dart';
import 'package:tasawaaq/features/offer_details/offer_details_response.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/curved_container/curved_container.dart';
import 'package:tasawaaq/shared/dialog/qrcode_dialog.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class OfferDetailsArgs {
  final id;
  OfferDetailsArgs({
    required this.id,
  });
}

class OfferDetailsPage extends StatefulWidget {
  const OfferDetailsPage({Key? key}) : super(key: key);

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {


  OfferDetailsArgs? args;


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {

      args = ModalRoute.of(context)!.settings.arguments as OfferDetailsArgs;

      if(args != null){
        context.use<OfferDetailsManager>().execute(id: args!.id!);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final OfferDetailsArgs args =
        ModalRoute.of(context)!.settings.arguments as OfferDetailsArgs;
    final offerDetailsManager = context.use<OfferDetailsManager>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MainAppBar(
          hasCart: false,
          title: Text('${context.translate(AppStrings.OfferDetails)}'),
        ),
      ),
      body: Observer<OfferDetailsResponse>(
          onRetryClicked: () {
            offerDetailsManager.execute(id: args.id);
          },
          manager: offerDetailsManager,
          stream: offerDetailsManager.offerDetails$,
          onSuccess: (context, offerDetailsSnapshot) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 240.h,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: NetworkAppImage(
                        boxFit: BoxFit.fill,
                        width: double.infinity,
                        imageUrl: "${offerDetailsSnapshot.data?.offerImage}",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '${offerDetailsSnapshot.data?.title}',
                          style: AppFontStyle.blueTextH2,
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 5),
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
                              imageUrl:
                                  '${offerDetailsSnapshot.data?.brandImage}',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Container(
                    height: 60.w,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                Text(
                                  '${offerDetailsSnapshot.data?.address}',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          '${context.translate(AppStrings.CouponCode)}',
                          style: AppFontStyle.greyTextH3,
                        ),
                        Spacer(),
                        if(offerDetailsSnapshot.data!.offerImage!.isNotEmpty) if(offerDetailsSnapshot.data!.offerImage != null)InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => QRCodeDialog(
                                      offerDetailsData:
                                          offerDetailsSnapshot.data,
                                      onClickConfirmBtn: () {
                                        Navigator.of(context).pop();
                                      },
                                    ));
                          },
                          child: SvgPicture.asset(
                            AppAssets.qrcode_svg,
                            height: 35,
                            matchTextDirection: true,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                    text:
                                        '${offerDetailsSnapshot.data?.codeNo}'))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "${context.translate(AppStrings.CodeCopied)}")));
                            });
                          },
                          child: CurvedContainer(
                            containerColor: Colors.grey[100]!,
                            widget: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '${offerDetailsSnapshot.data?.codeNo}',
                                  style: TextStyle(
                                      color: AppStyle.appBarColor,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.copy,
                                      size: 20,
                                      color: Colors.grey[500],
                                    ),
                                    Text(
                                      '${context.translate(AppStrings.Copy)}',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.grey[100],
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${context.translate(AppStrings.ABOUT_OFFER)}',
                          style: AppFontStyle.blueTextH2,
                        ),
                        Html(
                         data: '${offerDetailsSnapshot.data?.text}',
                          // style: AppFontStyle.greyTextH4,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
