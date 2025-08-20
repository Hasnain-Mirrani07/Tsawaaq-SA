import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_core/services/media_service/media_Service.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/domain/user.dart';
import 'package:tasawaaq/features/edit_profile/edit_profile_manager.dart';
import 'package:tasawaaq/features/edit_profile/edit_profile_request.dart';
import 'package:tasawaaq/features/edit_profile/widgets/avatar_widget.dart';
import 'package:tasawaaq/features/edit_profile/widgets/date_widget.dart';
import 'package:tasawaaq/features/edit_profile/widgets/gender_widget.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';
import 'package:tasawaaq/shared/custom_text_field/custom_text_field.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';

// class EditProfileArgs {
//   final User user;
//
//   EditProfileArgs({required this.user});
// }

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({Key? key,required this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String _name = "";
  String _email = "";
  String _phone = "";

  @override
  void initState() {
    super.initState();
    _name = "${widget.user.name}";
    _email = "${widget.user.email}";
    _phone = "${widget.user.phone}";
 }



  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    // final EditProfileArgs args =
    //     ModalRoute.of(context)!.settings.arguments as EditProfileArgs;



    final prefs = context.use<PrefsService>();
    final editProfileManager = context.use<EditProfileManager>();
    final mediaService = context.use<MediaService>();

    final String initialDate = prefs.appLanguage == 'en' ? "Date of Birth" : "تاريخ الميلاد";


  return GestureDetector(
    onTap: () {
      removeFocus(context);
    },
    child: Scaffold(
          backgroundColor: Colors.white,
          persistentFooterButtons: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: CustomButton(
                onClickBtn: () async {
                  removeFocus(context);
                  if (_formKey.currentState!.validate()) {
                    // If all data are correct then save data to out variables
                    _formKey.currentState!.save();
                  } else {
                    // If all data are not valid then start auto validation.
                    setState(() {
                      _autoValidateMode = AutovalidateMode.always;
                    });
                    context.use<ToastTemplate>().show(
                        '${context.translate(AppStrings.PLEASE_ENTER_REQUIRED_FIELDS)}');
                    return;
                  }

                  editProfileManager.editProfile(
                      request: EditProfileRequest(
                    image: //  isImageChange
                        locator<MediaService>().hasSelectedImage
                            ? await MultipartFile.fromFile(
                                locator<MediaService>().selectedImage.path,
                                filename: 'profileImage',
                              )
                            : null,
                    phone: _phone,
                    name: _name,
                    birthDate: editProfileManager.selectDateSubject.value == initialDate ? '' : editProfileManager.selectDateSubject.value,
                    email: _email,
                    gender: editProfileManager.selectGenderSubject.value.value,
                  ),thenDo: (){
                    showDialog(
                        context: context,
                        builder: (_) {
                          return TasawaaqDialog(
                              onCloseBtn: (){
                                Navigator.of(context).pop();
                              },
                              titleTextAlign: TextAlign.start,
                              contentTextAlign: TextAlign.start,
                              confirmBtnTxt: '${context.translate(AppStrings.OK)}',
                              columnCrossAxisAlignment: CrossAxisAlignment.start,
                              onClickConfirmBtn: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              title: '${context.translate(AppStrings.Profile_Successfully)}',
                              description:'${context.translate(AppStrings.Your_Profile_Successfully)}'

                            // '${context.translate(AppStrings.continue_shopping_cart)}',
                          );
                        });
                  });

                  editProfileManager.changedPhoneNumber = _phone;
                },
                txt: '${context.translate(AppStrings.UPDATE_PROFILE)}',
                btnWidth: double.infinity,
                btnColor: AppStyle.yellowButton,
              ),
            )
          ],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: MainAppBar(
              onBackClicked: () {
                Navigator.pop(context);
                locator<MediaService>().removeSelectedImage();
              },
              title: Text('${context.translate(AppStrings.EDIT_PROFILE)}'),
              hasCart: false,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: StreamBuilder<ManagerState>(
                initialData: ManagerState.IDLE,
                stream: editProfileManager.state$,
                builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
                  return FormsStateHandling(
                    managerState: stateSnapshot.data,
                    errorMsg: editProfileManager.errorDescription,
                    onClickCloseErrorBtn: () {
                      editProfileManager.inState.add(ManagerState.IDLE);
                    },
                    child: Container(
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _autoValidateMode,
                        child: ListView(
                          children: [
                            AvatarWidget(
                              imageUrl: widget.user.image,
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //// start name
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    "${AppLocalizations.of(context)!.translate(AppStrings.NAME)}*",
                                    style: AppFontStyle.blueTextH4,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextFiled(
                                  initialValue: _name,
                                  obscureText: false,
                                  currentFocus: nameFocus,
                                  maxLines: 1,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(emailFocus);
                                  },
                                  // labelText: "block_rq_str",
                                  hintText:
                                      '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      _name = value;
                                    } else {
                                      _name = '';
                                    }
                                  },
                                  // keyboardType: TextInputType.emailAddress,
                                ),
                                //// end name
                                SizedBox(
                                  height: 25,
                                ),
                                //// start email
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    "${AppLocalizations.of(context)!.translate(AppStrings.EMAIL_ADDRESS_)}*",
                                    style: AppFontStyle.blueTextH4,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextFiled(
                                  initialValue: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false,
                                  currentFocus: emailFocus,
                                  maxLines: 1,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(phoneFocus);
                                  },
                                  hintText:
                                      '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                    } else if (!EmailValidator.validate(value)) {
                                      return "${AppLocalizations.of(context)!.translate('EnterAValidEmail_str')}";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      _email = value;
                                    } else {
                                      _email = '';
                                    }
                                  },
                                ),
                                //// end email
                                SizedBox(
                                  height: 25,
                                ),
                                //// start phone
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    "${AppLocalizations.of(context)!.translate(AppStrings.PHONE_NUMBER)}*",
                                    style: AppFontStyle.blueTextH4,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextFiled(
                                  initialValue: _phone,
                                  keyboardType: TextInputType.phone,
                                  obscureText: false,
                                  currentFocus: phoneFocus,
                                  maxLines: 1,
                                  onFieldSubmitted: (v) {
                                    // FocusScope.of(context).requestFocus(phoneFocus);
                                  },
                                  hintText:
                                      '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                    } else if (value.length != 8) {
                                      return '${AppLocalizations.of(context)!.translate(AppStrings.PHONE_MSG)}';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      _phone = value;
                                    } else {
                                      _phone = '';
                                    }
                                  },
                                ),
                                //// end phone
                              ],
                            ),

                            SizedBox(
                              height: 25,
                            ),

                            //// start select area

                            DateWidget(dateOfBirth: '${widget.user.dateOfBirth}'),

                            SizedBox(
                              height: 25,
                            ),

                            GenderWidget(gender: widget.user.gender,),
                            SizedBox(
                              height: 45,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )),
  );
  }
}
