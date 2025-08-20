import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/drawer/drawer.dart';
import 'package:tasawaaq/features/offer_details/offer_details_page.dart';
import 'package:tasawaaq/features/offers/offers_manager.dart';
import 'package:tasawaaq/features/offers/offers_response.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<OffersManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final offersManager = context.use<OffersManager>();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MainAppBar(
          hasDrawer: true,
          hasCart: false,
          title: Text('${context.translate(AppStrings.Offers)}'),
        ),
      ),
      body: Observer<OffersResponse>(
          onRetryClicked: () {
            offersManager.execute();
          },
          manager: offersManager,
          stream: offersManager.offer$,
          onSuccess: (context, offersSnapshot) {
            return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                itemCount: offersSnapshot.data?.length ?? 0,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouts.OfferDetailsPage,
                          arguments: OfferDetailsArgs(
                              id: offersSnapshot.data?[index].id));
                    },
                    child: Container(
                      height: 160.h,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: NetworkAppImage(
                            boxFit: BoxFit.fill,
                            imageUrl:
                                "${offersSnapshot.data?[index].offerImage}",
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
