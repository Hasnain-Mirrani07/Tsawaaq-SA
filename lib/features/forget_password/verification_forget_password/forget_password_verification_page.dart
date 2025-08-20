// import 'package:tasawaaq/features/profile_phone_verification/pin_code_field/pin_code_field.dart';
// import 'package:tasawaaq/features/profile_phone_verification/pin_code_field/pin_code_style.dart';
import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_ResendManager.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_verification_manager.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_verification_request.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/pin_code_field/forget_password_pin_code.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/timer/forget_password_count_down_timer.dart'
    as timer;
import 'package:tasawaaq/features/forget_password/verification_forget_password/timer/forget_password_count_down_timer.dart';
import 'package:tasawaaq/features/verification/pin_code_field/pin_code_style.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/form/form_container.dart';
import 'package:tasawaaq/shared/forms_header/forms_header.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';

class ForgetPasswordVerificationArgs {
  final String? phone;
  final bool isFromEditProfile;

  ForgetPasswordVerificationArgs({
    @required this.phone,
    this.isFromEditProfile = false,
  });
}

class ForgetPasswordVerificationPage extends StatefulWidget {
  const ForgetPasswordVerificationPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordVerificationPageState createState() =>
      _ForgetPasswordVerificationPageState();
}

class _ForgetPasswordVerificationPageState
    extends State<ForgetPasswordVerificationPage> {
  // final TextEditingController _mobile = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String _code = '';
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    // final signInManager = context.use<SignInManager>();
    final forgetPasswordVerificationManager =
        context.use<ForgetPasswordVerificationManager>();
    final forgetPasswordResendManager =
        context.use<ForgetPasswordResendManager>();
    final toast = context.use<ToastTemplate>();

    final ForgetPasswordVerificationArgs args = ModalRoute.of(context)!
        .settings
        .arguments as ForgetPasswordVerificationArgs;

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
        body: ValueListenableBuilder<bool>(
          valueListenable: forgetPasswordResendManager.resendNotifier,
          builder: (_, isClicked, __) => StreamBuilder<ManagerState>(
              initialData: ManagerState.IDLE,
              stream: isClicked
                  ? forgetPasswordResendManager.state$
                  : forgetPasswordVerificationManager.state$,
              builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
                return FormsStateHandling(
                  managerState: stateSnapshot.data,
                  errorMsg: isClicked
                      ? forgetPasswordResendManager.errorDescription
                      : forgetPasswordVerificationManager.errorDescription,
                  onClickCloseErrorBtn: () {
                    forgetPasswordVerificationManager.inState
                        .add(ManagerState.IDLE);
                    forgetPasswordResendManager.inState.add(ManagerState.IDLE);
                    forgetPasswordResendManager.isResendClicked = false;
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        FormsHeader(
                          hasSkipBtn: false,
                          // title: '${context.translate(AppStrings.FORGOT_PASSWORD_T)}',
                          title: '${context.translate(AppStrings.VERIFICATION)}',
                          firstDesc: '${context.translate(AppStrings.OTP0)}',
                          secDesc: '${context.translate(AppStrings.OTP1)}',
                          yellowSecDesc: '${args.phone}',
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
                                    '${context.translate(AppStrings.VERIFY)}',
                                onClickConfirmBtn: _code.length < 4
                                    ? null
                                    : () {
                                        if (_code.length < 4) {
                                          toast.show(
                                              'Enter The OTP which we sent to your entered Mobile Number ${args.phone}');
                                          return;
                                        }
                                        forgetPasswordVerificationManager
                                            .forgetActivate(
                                                request:
                                                    ForgetPasswordVerificationRequest(
                                                        code: _code,
                                                        phone: args.phone))
                                            .then((value) {
                                          if (value == ManagerState.ERROR) {
                                            setState(() {
                                              hasError = true;
                                            });
                                          }
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
                                      Text(
                                        "${context.translate(AppStrings.Enter_Here)}",
                                        style: AppFontStyle.greyTextH3,
                                      ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 25),
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: ForgetPasswordPinCodeField(
                                            hasError: hasError,
                                            onChange: (value) {
                                              _code = value;
                                              if (value.length == 3) {
                                                setState(() {
                                                  hasError = false;
                                                });
                                              }
                                            },
                                            onSubmit: (value) {
                                              _code = value;
                                              print('_*_ $_code');
                                              setState(() {});
                                            },
                                            fieldCount: 4,
                                            fieldWidth: 55,
                                            height: 80,
                                            fieldStyle: PinCodeStyle(
                                              textStyle: TextStyle(
                                                  color: AppStyle.appBarColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                              fieldBackgroundColor: Colors.white,
                                              fieldBorder: Border.all(
                                                color: AppStyle.appBarColor,
                                                width: 1,
                                              ),
                                              unFoucsedFieldBackgroundColor:
                                                  Colors.white,
                                              unFoucsedFieldBorder: Border.all(
                                                color: AppStyle.appBarColor
                                                    .withOpacity(0.2),
                                                width: 1,
                                              ),
                                              completedFieldBorder: Border.all(
                                                color: Colors.green,
                                                width: 1.5,
                                              ),
                                              errorFieldBorder: Border.all(
                                                color: Colors.red,
                                                width: 1.5,
                                              ),
                                              fieldBorderRadius:
                                                  BorderRadius.circular(5),
                                              fieldPadding: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      timer.ForgetPasswordCountDownTimer(
                                          onResendClicked: () {
                                        forgetPasswordResendManager
                                            .isResendClicked = true;
                                        forgetPasswordResendManager.forgetResend(
                                            phone: args.phone!);
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Column(
                                children: [
                                  Text(
                                      '${context.translate(AppStrings.DID_NOT_GET)}'),
                                  StreamBuilder<bool>(
                                      initialData: false,
                                      stream: switch$,
                                      builder: (context, switchSnapshot) {
                                        return InkWell(
                                          onTap: switchSnapshot.data!
                                              ? () {
                                                  controller.reset();
                                                  controller.forward();
                                                  forgetPasswordResendManager
                                                      .isResendClicked = true;
                                                  forgetPasswordResendManager
                                                      .forgetResend(
                                                          phone: args.phone!);
                                                  inSwitch.add(false);
                                                }
                                              : null,
                                          child: Text(
                                            '${context.translate('Resend_str')}',
                                            style: TextStyle(
                                              color: AppStyle.yellowButton,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }),
                                ],
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
      ),
    );
  }
}
