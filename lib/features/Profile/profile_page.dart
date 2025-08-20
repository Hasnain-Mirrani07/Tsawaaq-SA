import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/Profile/profile_manager.dart';
import 'package:tasawaaq/features/Profile/profile_response.dart';
import 'package:tasawaaq/features/delete_user_action/delete_user_manager.dart';
import 'package:tasawaaq/features/drawer/drawer.dart';
import 'package:tasawaaq/features/edit_profile/edit_profile_page.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
import 'package:tasawaaq/shared/forms_header/forms_header.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    locator<ProfileManager>().execute();
    // locator<SearchManager>().resetSearchAttributesManager();

    // locator<AllStoresManager>().selectedIndex.value = 0;
  }


  @override
  Widget build(BuildContext context) {



    // final profileManager = context.use<ProfileManager>();
    final profileManager = locator<ProfileManager>();

    final prefs = context.use<PrefsService>();
    return Scaffold(
      drawer: AppDrawer(),
      persistentFooterButtons: [
        SlideInUp(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: CustomButton(
              onClickBtn: () {
                _logOutDialog(context);
              },
              txt: '${context.translate(AppStrings.LOGOUT)}',
              btnWidth: double.infinity,
              btnColor: AppStyle.yellowButton,
            ),
          ),
        )
      ],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0), //
        child: MainAppBar(
          hasRoundedEdge: false,
          hasLeading: false,
          hasDrawer: false,
          hasCart: false,
          hasInfo: false,
          elevation: 0.0,
        ),
      ),
      body: Builder(
        builder: (context) => Observer<ProfileResponse>(
            onRetryClicked: () {
              profileManager.execute();
            },
            manager: profileManager,
            stream: profileManager.profile$,
            onSuccess: (context, profileSnapshot) {
              return Container(
                child: Stack(
                  children: [
                    BounceInDown(
                      child: FormsHeader(
                        hasSkipBtn: false,
                        bottomCenterIconPadding: 0,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        upperCenterIconPadding: 120,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          SlideInRight(
                            duration: Duration(milliseconds: 500),
                            // delay: Duration(seconds: 1),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(50)),
                                        child: profileSnapshot.data!.image == ""
                                            ? SvgPicture.asset(
                                                '${AppAssets.noun_User}',
                                                color: AppStyle.blueTextButton,
                                              )
                                            : NetworkAppImage(
                                                boxFit: BoxFit.fill,
                                                height: 70,
                                                width: 70,
                                                imageUrl:
                                                    // "https://cdn.pixabay.com/photo/2016/11/29/04/19/ocean-1867285__340.jpg",
                                                    "${profileSnapshot.data!.image}",
                                              ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${profileSnapshot.data!.name}",
                                            style: AppFontStyle.blueTextH3,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${profileSnapshot.data!.email}",
                                            style: AppFontStyle.greyTextH4,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${profileSnapshot.data!.phone}",
                                            style: AppFontStyle.greyTextH4,
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          SlideInLeft(
                            duration: Duration(milliseconds: 500),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileItem(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfilePage(
                                      user: profileSnapshot.data!,
                                    )));
                                  },
                                    // Navigator.of(context).pushNamed(
                                    //     AppRouts.EDIT_PROFILE_PAGE,
                                    //     arguments: EditProfileArgs(
                                    //         user: profileSnapshot.data!));

                                  title:
                                      "${context.translate(AppStrings.EDIT_PROFILE)}",
                                  iconName: AppAssets.noun_User,
                                ),
                                ProfileItem(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRouts.MyAddressesPage);
                                  },
                                  title:
                                      "${context.translate(AppStrings.My_Addresses)}",
                                  iconName: AppAssets.Location,
                                ),
                                ProfileItem(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRouts.ChangePasswordPage);
                                  },
                                  title:
                                      "${context.translate(AppStrings.CHANGE_PASSWORD)}",
                                  iconName: AppAssets.PASS_SVG,
                                ),
                                if (prefs.userObj != null)
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) => CupertinoAlertDialog(
                                            title: Text(
                                              '${prefs.appLanguage == "en" ? "delete account" : "مسح الحساب"}',
                                              style: TextStyle(
                                                color: Colors.redAccent.withOpacity(.8),
                                              ),
                                            ),
                                            content: Text(
                                                '${prefs.appLanguage == "en" ? "Are you sure you want to delete the account" : "هل أنت متأكد أنك تريد حذف الحساب"}'),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                child: Text(
                                                  '${prefs.appLanguage == "en" ? "cancel" : "الغاء"}',
                                                  style:  TextStyle(color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: Text(
                                                  '${prefs.appLanguage == "en" ? "yes" : "نعم"}',
                                                  style:  TextStyle(color: Colors.black45),
                                                ),
                                                onPressed: () async {
                                                  await locator<DeleteUserManager>().deleteUser();
                                                },
                                              )
                                            ],
                                          ));
                                    },
                                    child: Text(
                                      '${prefs.appLanguage == "en" ? "delete account" : 'مسح الحساب'}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.redAccent.withOpacity(.9),
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 35,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        top: 15,
                        left: 15,
                        right: 15,
                        child: Center(
                            child: Text(
                          '${context.translate(AppStrings.MY_PROFILE)}',
                          style: AppFontStyle.whiteTextH2,
                        ))),
                    Positioned(
                        top: 0,
                        right: prefs.appLanguage == 'en' ? null : 5,
                        left: prefs.appLanguage == 'en' ? 5 : null,
                        child: IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: SvgPicture.asset(
                            '${AppAssets.DRAWER_ICON}',
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String? title, iconName;
  final GestureTapCallback? onTap;
  const ProfileItem({Key? key, this.title, this.iconName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                '$iconName',
                color: AppStyle.topDarkGrey,
                height: 18,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  "$title",
                  style: AppFontStyle.greyTextH2,
                ),
              ),
              Icon(
                Icons.navigate_next_rounded,
                size: 30,
                color: Colors.black54,
              )
            ],
          ),
        ),
        Divider(
          height: 30,
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}


void _logOutDialog(BuildContext context) {
  final prefs = locator<PrefsService>();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  showDialog(
      context: context,
      builder: (_) {
        return TasawaaqDialog(
          onCloseBtn: (){
            Navigator.of(context).pop();
          },
          titleTextAlign: TextAlign.start,
          contentTextAlign: TextAlign.start,
          confirmBtnTxt: '${context.translate(AppStrings.YES)}',
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          onClickConfirmBtn: (){
            locator<PrefsService>().removeUserObj();
            ///TODO: don't forget to logout social accounts

            // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
            // if (Platform.isIOS) {
            //   _fcm.subscribeToTopic('IOS');
            // } else if (Platform.isAndroid) {
            //   _fcm.subscribeToTopic('Android');
            // }

            Navigator.of(context).pushNamedAndRemoveUntil(
                     AppRouts.SignInPage,
                    (Route<dynamic> route) => false,);
            if(Platform.isIOS) {
              if(prefs.appLanguage == 'en'){
                _fcm.unsubscribeFromTopic('IOSEN');
              }else{
                _fcm.unsubscribeFromTopic('IOSAR');
              }
            }
            else{
              if(prefs.appLanguage == 'en'){
                _fcm.unsubscribeFromTopic('AndroidEn');
              } else{
                _fcm.unsubscribeFromTopic('AndroidAr');
              }
            }
          },
          title: '${context.translate(AppStrings.LOGOUT)}',
          description: '${context.translate(AppStrings.LOGOUT_DIALOG_MSG)}',
        );
      });
}