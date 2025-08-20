import 'package:flutter/material.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/mall_details/mall_details_page.dart';
import 'package:tasawaaq/features/malls/malls_manager.dart';
import 'package:tasawaaq/features/malls/malls_response.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';
import 'package:tasawaaq/app_core/app_core.dart';

class MallsPage extends StatefulWidget {
  const MallsPage({Key? key}) : super(key: key);

  @override
  State<MallsPage> createState() => _MallsPageState();
}

class _MallsPageState extends State<MallsPage> {

  @override
  void initState() {
    super.initState();
    locator<MallsManager>().execute();

  }


  @override
  Widget build(BuildContext context) {
    final mallsManager = context.use<MallsManager>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: MainAppBar(
          title: Text('${context.translate(AppStrings.MALLS)}'),
        ),
      ),
      body: Observer<MallsResponse>(
          onRetryClicked: () {
            mallsManager.execute();
          },
          manager: mallsManager,
          stream: mallsManager.malls$,
          onSuccess: (context, mallsSnapshot) {
          return Container(
              padding: EdgeInsets.all(15),
              child: Container(
                child: GridView.builder(
                  // shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: mallsSnapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .8,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouts.MallDetailsPage,
                          arguments: MallDetailsArgs(
                            mallId: mallsSnapshot.data![index].id,
                            mallImg: mallsSnapshot.data![index].logo
                          ),);
                        // Navigator.of(context).pushNamed(AppRouts.,arg);
                      },
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: 0,
                              right: 12,
                              left: 12,
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25.0),
                                      bottomRight: Radius.circular(25.0)),
                                  child: Container(
                                    height: 75,
                                    padding: EdgeInsets.all(8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppStyle.yellowButton,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${mallsSnapshot.data![index].name}",
                                            style: AppFontStyle.blueTextH3,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          Column(
                            children: [
                              Expanded(
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: NetworkAppImage(
                                      boxFit: BoxFit.fill,
                                      width: double.infinity,
                                      imageUrl: "${mallsSnapshot.data![index].logo}",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ));
        }
      ),
    );
  }
}


