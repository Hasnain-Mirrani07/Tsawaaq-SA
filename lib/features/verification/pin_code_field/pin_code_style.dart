import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PinCodeStyle {
  final TextStyle? textStyle;
  final double? fieldPadding;
  final Color? fieldBackgroundColor;
  final Color? unFoucsedFieldBackgroundColor;
  final BoxBorder? fieldBorder;
  final BoxBorder? unFoucsedFieldBorder;
  final BoxBorder? errorFieldBorder;
  final BoxBorder? completedFieldBorder;
  final BorderRadiusGeometry? fieldBorderRadius;

  PinCodeStyle({
    this.textStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
    this.fieldBackgroundColor,
    this.fieldPadding,
    this.fieldBorder,
    this.fieldBorderRadius,
    this.unFoucsedFieldBackgroundColor,
    this.unFoucsedFieldBorder,
    this.errorFieldBorder,
    this.completedFieldBorder,
  });
}
