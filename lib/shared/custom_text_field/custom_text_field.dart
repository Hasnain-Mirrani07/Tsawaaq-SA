import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';

final prefs = locator<PrefsService>();

class CustomTextFiled extends StatelessWidget {
  final FocusNode? currentFocus;
  final bool? obscureText;
  final bool enable;
  final bool? isTextArea;
  final int? maxLines;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? labelText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final fillColor;
  final hintText;
  final initialValue;
  final int? maxLength;
  final Color? borderColor;
  final double borderRadius;
  // FocusNode nextFocus;

  CustomTextFiled(
      {this.currentFocus,
        this.isTextArea = false,
        this.obscureText,
        this.enable = true,
        this.maxLines,
        this.onFieldSubmitted,
        this.validator,
        this.onChanged,
        this.keyboardType,
        this.prefixIcon,
        this.suffixIcon,
        this.labelText,
        this.controller,
        this.fillColor,
        this.hintText,
        this.initialValue,
        this.maxLength,
        this.borderColor,
        this.borderRadius = 17,
        // this.nextFocus,

      });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        enabled: enable,
        maxLength: maxLength,
        initialValue: initialValue,
        controller: controller,
        focusNode: currentFocus,
        obscureText: obscureText ?? false,
        maxLines: maxLines,
        scrollPhysics: BouncingScrollPhysics(),
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            counterText: '',
            errorMaxLines: 3,
            contentPadding: isTextArea == false
                ? EdgeInsets.symmetric(
                horizontal: prefixIcon != null ? 0 : 15, vertical: 0)
                : EdgeInsets.all(15),
            // isDense: true,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
              borderSide: BorderSide(
                color:borderColor??Color(0xffA2ADB5) ,
              ),
            ),
            // filled: true,
            prefixIcon: prefixIcon != null
                ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(
                    prefs.appLanguage == 'en' ? 0 : math.pi),
                child: prefixIcon)
                : null,
            suffixIcon: suffixIcon,
            labelText: labelText,
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xff707070)),
            // hintText: hintText
            fillColor: fillColor),
      ),
    );
  }
}
