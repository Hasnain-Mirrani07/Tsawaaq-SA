import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/forget_confirm_password/forget_confirm_password_manager.dart';
import 'package:tasawaaq/features/forget_confirm_password/forget_confirm_password_request.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/custom_text_field/custom_text_field.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
import 'package:tasawaaq/shared/form/form_container.dart';
import 'package:tasawaaq/shared/forms_header/forms_header.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';

class ForgetPasswordConfirmArgs {
  final int userId;

  ForgetPasswordConfirmArgs({
    required this.userId,
  });
}

class ForgetPasswordConfirmPage extends StatefulWidget {
  const ForgetPasswordConfirmPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordConfirmPageState createState() =>
      _ForgetPasswordConfirmPageState();
}

class _ForgetPasswordConfirmPageState extends State<ForgetPasswordConfirmPage> {
  final prefs = locator<PrefsService>();

  // final RegExp regExp = RegExp(
  //     r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^*?&_-])[A-Za-z\d!@#$%^*?&_-]{7,15}$");

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final forgetPasswordConfirmManager =
        context.use<ForgetPasswordConfirmManager>();
    final ForgetPasswordConfirmArgs args =
        ModalRoute.of(context)!.settings.arguments as ForgetPasswordConfirmArgs;
    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
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
        body: StreamBuilder<ManagerState>(
            initialData: ManagerState.IDLE,
            stream: forgetPasswordConfirmManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
              return FormsStateHandling(
                managerState: stateSnapshot.data,
                errorMsg: forgetPasswordConfirmManager.errorDescription,
                onClickCloseErrorBtn: () {
                  forgetPasswordConfirmManager.inState.add(ManagerState.IDLE);
                },
                child: Stack(
                  children: [
                    FormsHeader(
                      upperCenterIconPadding: 65,
                      hasSkipBtn: false,
                      title:
                          '${context.translate(AppStrings.FORGOT_PASSWORD_T)}',
                      firstDesc:
                          '${context.translate(AppStrings.FORGOT_PASSWORD_2)}',
                      bottomCenterIconPadding: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 250,
                          ),
                          TasawaaqFormContainer(
                            confirmBtnTxt:
                                '${context.translate(AppStrings.CHANGE)}',
                            onClickConfirmBtn: () {
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

                              forgetPasswordConfirmManager
                                  .forgetPasswordConfirmation(
                                      request:
                                          ForgetPasswordConfirmationRequest(
                                              userId: '${args.userId}',
                                              password: '${_password.text}'))
                                  .then((value) {
                                _forgetPasswordDialog(context);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 25),
                                    child: CustomTextFiled(
                                      hintText:
                                          '${context.translate(AppStrings.NEW_PASSWORD)}',
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SvgPicture.asset(
                                          '${AppAssets.PASS_SVG}',
                                          color: AppStyle.blueTextButton,
                                          // height: 15,
                                        ),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      maxLines: 1,
                                      controller: _password,
                                      currentFocus: passwordFocus,
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(confirmPasswordFocus);
                                      },
                                      // validator: (validator) {
                                      //   if (validator!.isEmpty) {
                                      //     return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                      //   }
                                      //   return null;
                                      // },
                                      validator: (validator) {
                                        if (validator!.isEmpty) {
                                          return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                        } else if (validator.length < 5) {
                                          return prefs.appLanguage == 'en'
                                              ? 'password must not less than 5 characters.'
                                              : "يجب ألا تقل كلمة المرور عن 5 عناصر.";
                                        }
                                        // else if (!regExp
                                        //     .hasMatch(validator)) {
                                        //   return prefs.appLanguage == 'en'
                                        //       ? 'password between 7 to 15 characters which contain at least one numeric digit and a special character.'
                                        //       : "تتكون كلمة المرور من 7 إلى 15 عنصر و تحتوي على رقم واحد على الأقل عنصر خاص.";
                                        // }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 25),
                                    child: CustomTextFiled(
                                      hintText:
                                          '${context.translate(AppStrings.CONFIRM_NEW_PASSWORD)}',
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SvgPicture.asset(
                                          '${AppAssets.PASS_SVG}',
                                          color: AppStyle.blueTextButton,
                                          // height: 15,
                                        ),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      maxLines: 1,
                                      controller: _confirmPassword,
                                      currentFocus: confirmPasswordFocus,
                                      onFieldSubmitted: (v) {},
                                      validator: (validator) {
                                        if (validator!.isEmpty) {
                                          return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                        } else if (validator !=
                                            _password.text) {
                                          return "${AppLocalizations.of(context)!.translate('PASSWORD_CONFIRMATION_MSG')}";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 75,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: prefs.appLanguage == 'en' ? 20 : null,
                      left: prefs.appLanguage == 'ar' ? 20 : null,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRouts.TABS_WIDGET,
                                (Route<dynamic> route) => false);
                          },
                          child: Text(
                            '${context.translate(AppStrings.SKIP)}',
                            style: AppFontStyle.whiteTextH3,
                          )),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

void _forgetPasswordDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return TasawaaqDialog(
          titleStyle: TextStyle(fontSize: 16),
          descriptionStyle: TextStyle(fontSize: 16),
          titleTextAlign: TextAlign.start,
          contentTextAlign: TextAlign.start,
          confirmBtnTxt: '${context.translate(AppStrings.OK)}',
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          onClickConfirmBtn: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouts.SignInPage, (Route<dynamic> route) => false);
          },
          title:
              '${context.translate(AppStrings.Password_Changed_Successfully)}',
          description:
              '${context.translate(AppStrings.password_successfully_updated)}',
        );
      });
}
