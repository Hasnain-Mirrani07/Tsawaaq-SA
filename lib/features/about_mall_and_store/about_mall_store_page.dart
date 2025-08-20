import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_mall/about_mall_manager.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_store/about_store_manager.dart';
import 'package:tasawaaq/shared/appbar/appbar_logo.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMallsAndStoreArgs {
  final int? id;
  final String? imageUrl;
  final bool isStore;

  AboutMallsAndStoreArgs({this.id, this.imageUrl, this.isStore = true});
}

class AboutMallsAndStorePage extends StatefulWidget {
  const AboutMallsAndStorePage({Key? key}) : super(key: key);

  @override
  State<AboutMallsAndStorePage> createState() => _AboutMallsAndStorePageState();
}

class _AboutMallsAndStorePageState extends State<AboutMallsAndStorePage> {
  openMapsSheet(context, Coords latLng, String title) async {
    try {
      // final coords = Coords(37.759392, -122.5107336);
      // final title = "Ocean Beach";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: latLng,
                          // coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  AboutMallsAndStoreArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as AboutMallsAndStoreArgs;

      if(args != null){
        if(args!.isStore){
          context.use<AboutStoreManager>().execute(id: args!.id!);
        }else{
          context.use<AboutMallManager>().execute(id: args!.id!);
        }
      }


    });
  }
  @override
  Widget build(BuildContext context) {
    

    final AboutStoreManager aboutStoreManager =
    context.use<AboutStoreManager>();
    final AboutMallManager aboutMallManager = context.use<AboutMallManager>();

    if(args==null){
      args =
      ModalRoute.of(context)!.settings.arguments as AboutMallsAndStoreArgs;
      if(args!.isStore){
        aboutStoreManager.execute(id: args!.id!);
      }else{
        aboutMallManager.execute(id: args!.id!);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: LogoAppBar(imageUrl: args!.imageUrl!),
      ),
      body: Observer<dynamic>(
          onRetryClicked: () {
            args!.isStore
                ? aboutStoreManager.execute(id: args!.id!)
                : aboutMallManager.execute(id: args!.id!);
          },
          // manager: args!.isStore ? aboutStoreManager : aboutMallManager,
          manager: aboutStoreManager,
          stream: args!.isStore
              ? aboutStoreManager.aboutStore$
              : aboutMallManager.aboutMall$,
          onSuccess: (context, aboutSnapshot) {
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
                        width: double.infinity,
                        boxFit: BoxFit.fill,
                        imageUrl: "${aboutSnapshot.data?.image}",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      '${aboutSnapshot.data?.name}',
                      style: AppFontStyle.blueTextH2,
                    ),
                  ),
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
                          child: args!.isStore
                              ? ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                            aboutSnapshot.data?.malls?.length ?? 0,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    AppRouts.AboutMallsAndStorePage,
                                    arguments: AboutMallsAndStoreArgs(
                                      id: aboutSnapshot
                                          .data?.malls?[index].id,
                                      imageUrl: aboutSnapshot
                                          .data?.malls?[index].logo,
                                      isStore: false,
                                    ),
                                  );
                                },
                                child: Container(
                                  // color: Colors.transparent,
                                  margin:
                                  EdgeInsets.symmetric(horizontal: 5),
                                  width: 60.w,
                                  height: 60.w,
                                  child: Card(
                                    // color: Colors.transparent,

                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      child: NetworkAppImage(
                                        boxFit: BoxFit.fill,
                                        imageUrl:
                                        "${aboutSnapshot.data?.malls?[index].logo}",
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                              : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${aboutSnapshot.data!.address}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(height: 1.3),
                            ),
                          ),
                        ),
                        args!.isStore
                            ? aboutSnapshot.data?.malls?.length == 1
                            ? Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              openMapsSheet(
                                  context,
                                  Coords(
                                      aboutSnapshot
                                          .data!.malls![0].lat!,
                                      aboutSnapshot
                                          .data!.malls![0].lng!),
                                  '${aboutSnapshot.data!.malls![0].name!}');
                            },
                            child: SvgPicture.asset(
                              AppAssets.direction_svg,
                              height: 30.h,
                              matchTextDirection: true,
                            ),
                          ),
                        )
                            : const SizedBox(
                          height: 0,
                          width: 0,
                        )
                            : Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              openMapsSheet(
                                  context,
                                  Coords(aboutSnapshot.data!.lat!,
                                      aboutSnapshot.data!.lng!),
                                  '${aboutSnapshot.data!.name!}');
                            },
                            child: SvgPicture.asset(
                              AppAssets.direction_svg,
                              height: 30.h,
                              matchTextDirection: true,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppAssets.GLOBE,
                          height: 20.h,
                          matchTextDirection: true,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {

                              await launchUrl(Uri.parse('${aboutSnapshot.data?.website}'));
                            },
                            child: Text(
                              '${aboutSnapshot.data?.website}',
                              style: AppFontStyle.greyTextH3,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  if(aboutSnapshot.data?.description != "")     Container(
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
                          '${context.translate(AppStrings.ABOUT)} ${aboutSnapshot.data?.name}',
                          style: AppFontStyle.blueTextH2,
                        ),
                        Html(data: "${aboutSnapshot.data?.description}"),

                        // Text(
                        //   '''${}''',
                        //   style: AppFontStyle.greyTextH4,
                        // ),
                        const SizedBox(
                          height: 30,
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