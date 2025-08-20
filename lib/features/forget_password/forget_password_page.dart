import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/forget_password/forget_password_manager.dart';
import 'package:tasawaaq/features/forget_password/forget_password_request.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/custom_text_field/custom_text_field.dart';
import 'package:tasawaaq/shared/form/form_container.dart';
import 'package:tasawaaq/shared/forms_header/forms_header.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _mobile = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final forgetPasswordManager = context.use<ForgetPasswordManager>();

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), //
          child: MainAppBar(
            hasRoundedEdge: false,
            hasLeading: true,
            hasDrawer: false,
            hasCart: false,
            hasInfo: false,
            elevation: 0.0,
          ),
        ),
        body: StreamBuilder<ManagerState>(
            initialData: ManagerState.IDLE,
            stream: forgetPasswordManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
              return FormsStateHandling(
                managerState: stateSnapshot.data,
                errorMsg: forgetPasswordManager.errorDescription,
                onClickCloseErrorBtn: () {
                  forgetPasswordManager.inState.add(ManagerState.IDLE);
                },
                child: Container(
                  child: Stack(
                    children: [
                      FormsHeader(
                        hasSkipBtn: false,
                        title:
                            '${context.translate(AppStrings.FORGOT_PASSWORD_T)}',
                        firstDesc:
                            '${context.translate(AppStrings.FORGOT_PASSWORD_0)}',
                        secDesc:
                            '${context.translate(AppStrings.FORGOT_PASSWORD_1)}',
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
                                  '${context.translate(AppStrings.Send)}',
                              onClickConfirmBtn: () {
                                print(
                                    "acceptTerms${forgetPasswordManager.acceptTerms}");
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
                                forgetPasswordManager.forgetPassword(
                                  request:
                                      ForgetPasswordRequest(phone: _mobile.text),
                                );
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
                                    Text(
                                      "${context.translate(AppStrings.Enter_Here)}",
                                      style: AppFontStyle.greyTextH3,
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 25),
                                      child: CustomTextFiled(
                                        maxLength: 8,
                                        hintText:
                                            '${context.translate(AppStrings.ENTER_PHONE_NUM)}',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SvgPicture.asset(
                                            '${AppAssets.PHONE_SVG}',
                                            color: AppStyle.blueTextButton,
                                            // height: 15,
                                          ),
                                        ),
                                        keyboardType: TextInputType.phone,
                                        // obscureText: true,
                                        maxLines: 1,
                                        controller: _mobile,
                                        // currentFocus: mobileFocus,
                                        validator: (validator) {
                                          if (validator!.isEmpty) {
                                            return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                          } else if (validator.length < 8) {
                                            return "${AppLocalizations.of(context)!.translate('PasswordMustBe8CharacterAtLeast_str')}";
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (v) {},
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
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
