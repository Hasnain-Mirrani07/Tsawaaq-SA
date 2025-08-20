import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';

class FormTxtField extends StatelessWidget {
  final TextInputType? keyBoardType;
  final String? txtFHint;
  final String? Function(String?)? txtFSubmitted;
  final String? Function(String?)? txtFValidator;
  final String? Function(String?)? txtFChanged;
  final bool? obscure;
  final FocusNode? focusNode;
  final int? txtFMaxLines;
  final double? width;
  final TextEditingController? controller;
  const FormTxtField({
    this.keyBoardType,
    this.txtFHint = '',
    this.txtFSubmitted,
    this.txtFValidator,
    this.txtFChanged,
    this.obscure = false,
    this.focusNode,
    this.txtFMaxLines = 1,
    this.width,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context);
    final prefs = context.use<PrefsService>();

    return Container(
      // height: 70,
      width: width ?? MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        style: TextStyle(height: 1.3),
        controller: controller,
        maxLines: txtFMaxLines,
        scrollPhysics: BouncingScrollPhysics(),
        onFieldSubmitted: txtFSubmitted ?? (value) {},
        focusNode: focusNode,
        validator: txtFValidator ??
            (value) {
              //   if (value.isEmpty) {
              //     return AppLocalizations.of(
              //             context)
              //         .translate(
              //             '*required_str');
              //   } else if (!EmailValidator
              //       .validate(value)) {
              //     return AppLocalizations.of(
              //             context)
              //         .translate(
              //             'EnterAValidEmail_str');
              //   }
              return null;
            },
        onChanged: txtFChanged ??
            (value) {
              // if (value.isNotEmpty) {
              //   _email = value;
              // } else {
              //   _email = '';
              // }
            },
        keyboardType: keyBoardType,
        obscureText: obscure!,
        decoration: InputDecoration(
          isDense: true,
          // border: InputBorder.none,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: new BorderSide(color: Colors.red),
          ),
          // focusedBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: new BorderSide(color: Colors.grey[300]!),
          ),
          // enabledBorder: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          // errorBorder: InputBorder.none,
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(10.0),
          //   ),
          //   borderSide: new BorderSide(color: Colors.grey[200]),
          // ),
          // // disabledBorder: InputBorder.none,
          // disabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(10.0),
          //   ),
          // borderSide: new BorderSide(color: Colors.grey[200]),
          // ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          hintText: txtFHint,
          filled: true,
          fillColor: Colors.grey[200],
          hintStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, height: 1.3),
        ),
      ),
    );
  }
}
