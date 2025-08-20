import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/change_password/change_password_manager.dart';
import 'package:tasawaaq/features/change_password/change_password_request.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';
import 'package:tasawaaq/shared/custom_text_field/custom_text_field.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  String _oldPassword = "";
  String _newPassword = "";
  String _confirmNewPassword = "";

  final oldPasswordFocus = FocusNode();
  final newPasswordFocus = FocusNode();
  final confirmNewPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final changePasswordManager = context.use<ChangePasswordManager>();

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        persistentFooterButtons: [
          SlideInUp(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: CustomButton(
                onClickBtn: () {
                  removeFocus(context);
                  if (_formKey.currentState!.validate()) {
                    // If all data are correct then save data to out variables
                    _formKey.currentState!.save();
                  } else {
                    // If all data are not valid then start auto validation.
                    setState(() {
                      _autoValidateMode = AutovalidateMode.always;
                    });
                    // context.use<ToastTemplate>().show(
                    //     '${context.translate(AppStrings.PLEASE_ENTER_REQUIRED_FIELDS)}');
                    return;
                  }

                  changePasswordManager.changePasswordPost(
                      request: ChangePasswordRequest(
                          currentPassword: _oldPassword,
                          password: _newPassword,
                          passwordConfirmation: _confirmNewPassword),
                      thenDo: () {
                        _changePasswordClick(context);
                      });
                },
                txt: '${context.translate(AppStrings.Update_Password)}',
                btnWidth: double.infinity,
                btnColor: AppStyle.yellowButton,
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: MainAppBar(
            title: Text('${context.translate(AppStrings.CHANGE_PASSWORD)}'),
            hasCart: false,
          ),
        ),
        body: StreamBuilder<ManagerState>(
            initialData: ManagerState.IDLE,
            stream: changePasswordManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
              return FormsStateHandling(
                managerState: stateSnapshot.data,
                errorMsg: changePasswordManager.errorDescription,
                onClickCloseErrorBtn: () {
                  changePasswordManager.inState.add(ManagerState.IDLE);
                },
                child: SlideInDown(
                  child: Container(
                      padding: EdgeInsets.all(15),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _autoValidateMode,
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            CustomTextFiled(
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  '${AppAssets.PASS_SVG}',
                                  color: AppStyle.blueTextButton,
                                  // height: 15,
                                ),
                              ),
                              obscureText: true,
                              currentFocus: oldPasswordFocus,
                              maxLines: 1,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context)
                                    .requestFocus(newPasswordFocus);
                              },
                              // labelText: "block_rq_str",
                              hintText:
                                  '${AppLocalizations.of(context)!.translate(AppStrings.OLD_PASSWORD)}',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  _oldPassword = value;
                                } else {
                                  _oldPassword = '';
                                }
                              },
                              // keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            CustomTextFiled(
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  '${AppAssets.PASS_SVG}',
                                  color: AppStyle.blueTextButton,
                                  // height: 15,
                                ),
                              ),
                              obscureText: true,
                              currentFocus: newPasswordFocus,
                              maxLines: 1,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context)
                                    .requestFocus(confirmNewPasswordFocus);
                              },
                              hintText:
                                  '${AppLocalizations.of(context)!.translate(AppStrings.NEW_PASSWORD)}',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                } else if (value.length < 5) {
                                  return prefs.appLanguage == 'en'
                                      ? 'password must not less than 5 characters.'
                                      : "يجب ألا تقل كلمة المرور عن 5 عناصر.";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  _newPassword = value;
                                } else {
                                  _newPassword = '';
                                }
                              },
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            CustomTextFiled(
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  '${AppAssets.PASS_SVG}',
                                  color: AppStyle.blueTextButton,
                                  // height: 15,
                                ),
                              ),
                              obscureText: true,
                              currentFocus: confirmNewPasswordFocus,
                              maxLines: 1,
                              onFieldSubmitted: (v) {
                                // FocusScope.of(context).requestFocus(messageFocus);
                              },
                              hintText:
                                  '${AppLocalizations.of(context)!.translate(AppStrings.CONFIRM_NEW_PASSWORD)}',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                } else if (value != _newPassword) {
                                  return '${AppLocalizations.of(context)!.translate(AppStrings.PASSWORD_CONFIRMATION_MSG)}';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  _confirmNewPassword = value;
                                } else {
                                  _confirmNewPassword = '';
                                }
                              },
                            ),
                            SizedBox(
                              height: 35,
                            ),
                          ],
                        ),
                      )),
                ),
              );
            }),
      ),
    );
  }
}

void _changePasswordClick(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return TasawaaqDialog(
          titleTextAlign: TextAlign.start,
          contentTextAlign: TextAlign.start,
          confirmBtnTxt: '${context.translate(AppStrings.OK)}',
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          titleStyle: AppFontStyle.blueTextH3,
          descriptionStyle: TextStyle(
              color: AppStyle.topDarkGrey, fontSize: 14.sp, height: 1.7),
          onClickConfirmBtn: () {
            Navigator.of(context).pop();
            Navigator.pop(context, true);
          },
          title:
              '${context.translate(AppStrings.Password_Changed_Successfully)}',
          description:
              '${context.translate(AppStrings.password_successfully_updated)}',
        );
      });
}
