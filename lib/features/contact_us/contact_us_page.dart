import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/contact_us/contact_us_manager.dart';
import 'package:tasawaaq/features/contact_us/contact_us_request.dart';
import 'package:tasawaaq/features/drawer/drawer.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';
import 'package:tasawaaq/shared/custom_text_field/custom_text_field.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';
import 'package:tasawaaq/shared/title_desc_btn/title_desc_btn.dart';


class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final prefs = locator<PrefsService>();





  String _name = "";
  String _email = "";
  String _phone = "";
  String _message = "";


  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final messageFocus = FocusNode();


  @override
  void initState() {


    if(prefs.userObj != null){
      _name = prefs.userObj!.name!;
      _email = prefs.userObj!.email!;
      _phone = prefs.userObj!.phone!;
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contactUsManager = context.use<ContactUsManager>();

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        drawer: AppDrawer(),
        persistentFooterButtons: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            child: CustomButton(
              onClickBtn: (){
                // _contactUsClick(context);
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

                contactUsManager.contactUsPost(
                    request: ContactUsPostRequest(
                      phone: _phone,
                      email: _email,
                      name: _name,
                      message: _message,
                    ),thenDo: (){
                  _contactUsClick(context);
                });
              },
              txt: '${context.translate(AppStrings.Send)}',
              btnWidth: double.infinity,
              btnColor: AppStyle.yellowButton, ),
          )
        ],
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: MainAppBar(
            hasDrawer: true,
            title: Text('${context.translate(AppStrings.CONTACT_US)}'),
            hasCart: false,
          ),
        ),
        body: StreamBuilder<ManagerState>(
            initialData: ManagerState.IDLE,
            stream: contactUsManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
            return FormsStateHandling(
              managerState: stateSnapshot.data,
              errorMsg: contactUsManager.errorDescription,
              onClickCloseErrorBtn: () {
                contactUsManager.inState.add(ManagerState.IDLE);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                child:  Form(
                  key: _formKey,
                  autovalidateMode: _autoValidateMode,
                  child: ListView(
                    children: [
                     SizedBox(
                       height: 25,
                     ),
                      TitleDescBtn(
                        title: "${context.translate(AppStrings.SEND_US_MSG)}",
                        desc: context.use<PrefsService>().appLanguage == 'en' ? "We are interested to hear your feedback!":"نحن مهتمون بسماع تعليقاتك !",
                        isFilter: false,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      //// start name
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("${AppLocalizations.of(context)!.translate(AppStrings.NAME)}*",style: AppFontStyle.blueTextH4,),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextFiled(
                        initialValue: _name,
                        obscureText: false,
                        currentFocus: nameFocus,
                        maxLines: 1,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(emailFocus);
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
                        height: 35,
                      ),
                      //// start email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("${AppLocalizations.of(context)!.translate(AppStrings.EMAIL_ADDRESS_)}*",style: AppFontStyle.blueTextH4,),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextFiled(
                        initialValue: _email,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        currentFocus: emailFocus,
                        maxLines: 1,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(phoneFocus);
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
                        height: 35,
                      ),
                      //// start phone
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("${AppLocalizations.of(context)!.translate(AppStrings.PHONE_NUMBER)}*",style: AppFontStyle.blueTextH4,),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextFiled(
                        initialValue: _phone,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        currentFocus: phoneFocus,
                        maxLines: 1,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(messageFocus);
                        },
                        hintText:
                        '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                        validator: (value) {
                          if (prefs.userObj == null) {
                            if (value!.isEmpty) {
                              return "${AppLocalizations.of(context)!.translate('*required_str')}";
                            } else if (value.length != 8) {
                              return '${AppLocalizations.of(context)!.translate(AppStrings.PHONE_MSG)}';
                            }
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

                      SizedBox(
                        height: 35,
                      ),
                      ////// message start

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("${AppLocalizations.of(context)!.translate(AppStrings.MESSAGE)}*",style: AppFontStyle.blueTextH4,),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextFiled(
                        isTextArea: true,
                        obscureText: false,
                        currentFocus: messageFocus,
                        maxLines: 4,
                        onFieldSubmitted: (v) {
                          // FocusScope.of(context).requestFocus(emailFocus);
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
                            _message = value;
                          } else {
                            _message = '';
                          }
                        },
                        // keyboardType: TextInputType.emailAddress,
                      ),

                      ////// message end

                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                )
              ),
            );
          }
        ),
      ),
    );
  }
}

void _contactUsClick(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return TasawaaqDialog(
          titleTextAlign: TextAlign.start,
          contentTextAlign: TextAlign.start,
          confirmBtnTxt: '${context.translate(AppStrings.OK)}',
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          onClickConfirmBtn: (){
            Navigator.of(context).pop();
            // Navigator.popUntil(context, (route) => route.settings.name == AppRouts.ContactUsPage);
            Navigator.pop(context, true);

          },
          title: '${context.translate(AppStrings.CONTACT_TITLE)}',
          description: '${context.translate(AppStrings.Thanks_contact_us)}${context.translate(AppStrings.representative_contact_soon)}',
        );
      });
}