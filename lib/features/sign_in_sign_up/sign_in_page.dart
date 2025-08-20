import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/sign_in_sign_up/sign_in_manager.dart';
import 'package:tasawaaq/features/sign_in_sign_up/sign_in_request.dart';
import 'package:tasawaaq/features/sign_in_sign_up/sign_up_manager.dart';
import 'package:tasawaaq/features/sign_in_sign_up/sign_up_request.dart';
import 'package:tasawaaq/features/sign_in_sign_up/widgets/accept_terms.dart';
import 'package:tasawaaq/features/sign_in_sign_up/widgets/sign_tabs.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/custom_text_field/custom_text_field.dart';
import 'package:tasawaaq/shared/form/form_container.dart';
import 'package:tasawaaq/shared/forms_header/forms_header.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // final RegExp regExp = RegExp(
  //     r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^*?&_-])[A-Za-z\d!@#$%^*?&_-]{7,15}$");

  final TextEditingController _phoneMail = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final phoneMailFocus = FocusNode();
  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final mobileFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  removeControllers() {
    removeFocus(context);
    setState(() {
      _formKey.currentState?.reset();
      _phoneMail.clear();
      _name.clear();
      _email.clear();
      _mobile.clear();
      _password.clear();
      _confirmPassword.clear();
      _autoValidateMode = AutovalidateMode.disabled;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    locator<SignInManager>().isSignIn.value = true;
  }

  @override
  Widget build(BuildContext context) {
    final signInManager = context.use<SignInManager>();
    final signUpManager = context.use<SignUpManager>();
    final prefs = context.use<PrefsService>();

    final String signIn = prefs.appLanguage == "en"
        ? "Please sign in into your account"
        : "يرجى الدخول الى حسابك";
    final String signUp =
        prefs.appLanguage == "en" ? "Let’s Get Started!" : "هيا بنا نبدأ !";

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
            stream: signInManager.isSignIn.value
                ? signInManager.state$
                : signUpManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
              return FormsStateHandling(
                managerState: stateSnapshot.data,
                errorMsg: signInManager.isSignIn.value
                    ? signInManager.errorDescription
                    : signUpManager.errorDescription,
                onClickCloseErrorBtn: () {
                  signInManager.inState.add(ManagerState.IDLE);
                  signUpManager.inState.add(ManagerState.IDLE);
                },
                child: Container(
                  child: ValueListenableBuilder<bool>(
                      valueListenable: signInManager.isSignIn,
                      builder: (context, value, _) {
                        return Stack(
                          children: [
                            FormsHeader(
                              upperCenterIconPadding: 65,
                              hasSkipBtn: false,
                              title: '${context.translate(AppStrings.WELCOME)}',
                              firstDesc: value ? "$signIn" : "$signUp",
                              // secDesc: "sadipscing elitr, sed diam ",
                              bottomCenterIconPadding: 40,
                              // onSkipClickBtn: () {
                              //   Navigator.of(context)
                              //       .pushReplacementNamed(AppRouts.TABS_WIDGET);
                              // },
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
                                    confirmBtnTxt: value
                                        ? '${context.translate(AppStrings.LOGIN)}'
                                        : '${context.translate(AppStrings.REGISTER)}',
                                    onClickConfirmBtn: () {
                                      prefs.hasSignInSeen = true;
                                      print(
                                          "acceptTerms${signInManager.acceptTerms}");
                                      removeFocus(context);
                                      if (_formKey.currentState!.validate()) {
                                        // If all data are correct then save data to out variables
                                        _formKey.currentState!.save();
                                      } else {
                                        // If all data are not valid then start auto validation.
                                        setState(() {
                                          _autoValidateMode =
                                              AutovalidateMode.always;
                                        });
                                        context.use<ToastTemplate>().show(
                                            '${context.translate(AppStrings.PLEASE_ENTER_REQUIRED_FIELDS)}');
                                        return;
                                      }

                                      if (value) {
                                        signInManager.login(
                                          request: SignInRequest(
                                              email: _phoneMail.text,
                                              password: _password.text),
                                        );
                                      } else {
                                        if (signInManager.acceptTerms ==
                                            false) {
                                          context.use<ToastTemplate>().show(
                                              '${context.translate(AppStrings.MUST_ACCEPT_MSG)}');
                                          return;
                                        }
                                        signUpManager.signUp(
                                          request: SignUpRequest(
                                            name: _name.text,
                                            phone: _mobile.text,
                                            email: _email.text,
                                            password: _password.text,
                                          ),
                                        );
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                removeControllers();
                                                signInManager.isSignIn.value =
                                                    true;
                                              },
                                              child: TabItem(
                                                isSelected: value,
                                                title:
                                                    '${context.translate(AppStrings.LOG_In)}',
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                removeControllers();
                                                signInManager.isSignIn.value =
                                                    false;
                                              },
                                              child: TabItem(
                                                isSelected: !value,
                                                title:
                                                    '${context.translate(AppStrings.SIGN_UP)}',
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 35,
                                        ),
                                        if (value)
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 25),
                                            child: CustomTextFiled(
                                              hintText:
                                                  '${context.translate(AppStrings.Mobile_email)}',
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                  '${AppAssets.EMAIL_SVG}',
                                                  color:
                                                      AppStyle.blueTextButton,
                                                  // height: 15,
                                                ),
                                              ),
                                              maxLines: 1,
                                              controller: _phoneMail,
                                              currentFocus: phoneMailFocus,
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        passwordFocus);
                                              },
                                              validator: (validator) {
                                                if (value) if (validator!
                                                    .isEmpty) {
                                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        if (!value)
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 25),
                                            child: CustomTextFiled(
                                              hintText:
                                                  '${context.translate(AppStrings.NAME)}*',
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                  '${AppAssets.USER_TEXT_FIELD_SVG}',
                                                  color:
                                                      AppStyle.blueTextButton,
                                                  // height: 15,
                                                ),
                                              ),
                                              maxLines: 1,
                                              controller: _name,
                                              currentFocus: nameFocus,
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(emailFocus);
                                              },
                                              validator: (validator) {
                                                if (!value) if (validator!
                                                    .isEmpty) {
                                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        if (!value)
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 25),
                                            child: CustomTextFiled(
                                              hintText:
                                                  '${context.translate(AppStrings.EMAIL_ADDRESS_)}*',
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                  '${AppAssets.EMAIL_SVG}',
                                                  color:
                                                      AppStyle.blueTextButton,
                                                  // height: 15,
                                                ),
                                              ),
                                              maxLines: 1,
                                              controller: _email,
                                              currentFocus: emailFocus,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(mobileFocus);
                                              },
                                              validator: (validator) {
                                                if (!value) if (validator!
                                                    .isEmpty) {
                                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                                } else if (!EmailValidator
                                                    .validate(validator)) {
                                                  return "${AppLocalizations.of(context)!.translate('EnterAValidEmail_str')}";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        if (!value)
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 25),
                                            child: CustomTextFiled(
                                              maxLength: 8,
                                              hintText:
                                                  '${context.translate(AppStrings.mobile_naumber)}*',
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                  '${AppAssets.PHONE_SVG}',
                                                  color:
                                                      AppStyle.blueTextButton,
                                                  // height: 15,
                                                ),
                                              ),
                                              keyboardType: TextInputType.phone,
                                              obscureText: false,
                                              maxLines: 1,
                                              controller: _mobile,
                                              currentFocus: mobileFocus,
                                              validator: (validator) {
                                                if (!value) if (validator!
                                                    .isEmpty) {
                                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                                } else if (validator.length <
                                                    8) {
                                                  return "${AppLocalizations.of(context)!.translate(AppStrings.PHONE_MSG)}";
                                                }
                                                return null;
                                              },
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        passwordFocus);
                                              },
                                            ),
                                          ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 25),
                                          child: CustomTextFiled(
                                            hintText:
                                                '${context.translate(AppStrings.PASSWORD)}${value ? "" : "*"}',
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
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
                                                  .requestFocus(
                                                      confirmPasswordFocus);
                                            },
                                            validator: (validator) {
                                              if (validator!.isEmpty) {
                                                return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                              } else if (!value &&
                                                  validator.length < 5) {
                                                return prefs.appLanguage == 'en'
                                                    ? 'password must not less than 5 characters.'
                                                    : "يجب ألا تقل كلمة المرور عن 5 عناصر.";
                                              }
                                              // else if (!value &&
                                              //     !regExp.hasMatch(validator)) {
                                              //   return prefs.appLanguage == 'en'
                                              //       ? 'password between 7 to 15 characters which contain at least one numeric digit and a special character.'
                                              //       : "تتكون كلمة المرور من 7 إلى 15 عنصر و تحتوي على رقم واحد على الأقل عنصر خاص.";
                                              // }
                                              return null;
                                            },
                                          ),
                                        ),
                                        if (value)
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pushNamed(AppRouts
                                                            .ForgetPasswordPage);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 10,
                                                    ),
                                                    child: Text(
                                                      '${context.translate(AppStrings.FORGOT_PASSWORD_T)}',
                                                      style: AppFontStyle
                                                          .yellowTextH4,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        if (!value)
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 25),
                                            child: CustomTextFiled(
                                              hintText:
                                                  '${context.translate(AppStrings.CONFIRM_PASSWORD)}*',
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                  '${AppAssets.PASS_SVG}',
                                                  color:
                                                      AppStyle.blueTextButton,
                                                  // height: 15,
                                                ),
                                              ),
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: true,
                                              maxLines: 1,
                                              controller: _confirmPassword,
                                              currentFocus:
                                                  confirmPasswordFocus,
                                              onFieldSubmitted: (v) {},
                                              validator: (validator) {
                                                if (!value) if (validator!
                                                    .isEmpty) {
                                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                                } else if (validator !=
                                                    _password.text) {
                                                  return "${AppLocalizations.of(context)!.translate('PASSWORD_CONFIRMATION_MSG')}";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        if (!value) AcceptTerms()
                                      ],
                                    ),
                                  ),
                                  // if (value) SocialItemsWidget(),
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
                                    prefs.hasSignInSeen = true;
                                    Navigator.of(context).pushReplacementNamed(
                                        AppRouts.TABS_WIDGET);
                                    locator<PrefsService>().removeUserObj();
                                  },
                                  child: Text(
                                    '${context.translate(AppStrings.SKIP)}',
                                    style: AppFontStyle.whiteTextH3,
                                  )),
                            ),
                          ],
                        );
                      }),
                ),
              );
            }),
      ),
    );
  }
}
