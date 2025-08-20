import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/verification/pin_code_field/pin_code_style.dart';
import 'package:tasawaaq/features/verification/pin_code_field/pin_input_type.dart';

// ignore: must_be_immutable
class PinCodeField extends StatefulWidget {
  final double height;
  final double fieldWidth;
  final int fieldCount;
  final PinCodeStyle fieldStyle;
  final ValueChanged<String>? onSubmit;
  final PinInputType inputType;
  final String pinInputCustom;
  bool hasError;
  final ValueChanged<String> onChange;

  PinCodeField({
    this.height = 50,
    this.fieldWidth = 50,
    this.fieldCount = 4,
    required this.fieldStyle,
    this.inputType = PinInputType.none,
    this.pinInputCustom = "*",
    this.onSubmit,
    this.hasError = false,
    required this.onChange,
  });

  @override
  State<StatefulWidget> createState() => _PinCodeFieldState();
}

class _PinCodeFieldState extends State<PinCodeField> {
  late FocusNode _focusNode;
  late List<String> pinsInputed;
  bool ending = false;
  String _pinCode = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    pinsInputed = [];
    for (var i = 0; i < widget.fieldCount; i++) {
      pinsInputed.add("");
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();
    super.dispose();
  }

  _PinCodeFieldState();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Stack(children: [
        // FittedBox(
        // child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildBody(context),
        ),
        // ),
        Opacity(
          child: TextField(
            maxLength: widget.fieldCount,
            autofocus: true,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            onSubmitted: (text) {
              print(text);
            },
            onChanged: (text) {
              widget.onChange(text);
              widget.hasError = false;
              _pinCode = text;
              if (ending && text.length == widget.fieldCount) {
                return;
              }
              _bindTextIntoWidget(text);
              setState(() {});
              ending = text.length == widget.fieldCount;
              if (ending) {
                widget.onSubmit!(text);
              }
              // widget.onSubmit(text);
            },
          ),
          opacity: 0.0,
        )
      ]),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    var tmp = <Widget>[];
    for (var i = 0; i < widget.fieldCount; i++) {
      tmp.add(_buildFieldInput(context, i));
      if (i < widget.fieldCount - 1) {
        tmp.add(SizedBox(
          width: widget.fieldStyle.fieldPadding,
        ));
      }
    }
    return tmp;
  }

  Widget _buildFieldInput(BuildContext context, int i) {
    return InkWell(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Container(
        width: widget.fieldWidth,
        alignment: Alignment.center,
        child: Text(
          _getPinDisplay(i),
          style: widget.fieldStyle.textStyle,
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: _pinCode.length > i
              ? widget.fieldStyle.fieldBackgroundColor
              : widget.fieldStyle.unFoucsedFieldBackgroundColor,
          border: _pinCode.length == 4
              ? widget.hasError
                  ? widget.fieldStyle.errorFieldBorder
                  : widget.fieldStyle.completedFieldBorder
              : widget.fieldStyle.unFoucsedFieldBorder,
          borderRadius: widget.fieldStyle.fieldBorderRadius,
          boxShadow: [
            BoxShadow(
                color: AppStyle.appBarColor.withOpacity(0.1),
                offset: Offset(0, 20),
                blurRadius: 60),
          ],
        ),
      ),
    );
  }

  String _getPinDisplay(int position) {
    var display = "";
    var value = pinsInputed[position];
    switch (widget.inputType) {
      case PinInputType.password:
        display = "*";
        break;
      case PinInputType.custom:
        display = widget.pinInputCustom;
        break;
      default:
        display = value;
        break;
    }
    return value.isNotEmpty ? display : value;
  }

  void _bindTextIntoWidget(String text) {
    ///Reset value
    for (var i = text.length; i < pinsInputed.length; i++) {
      pinsInputed[i] = "";
    }
    if (text.isNotEmpty) {
      for (var i = 0; i < text.length; i++) {
        pinsInputed[i] = text[i];
      }
    }
  }
}
