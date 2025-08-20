import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_page.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(AppRouts.AddAddressPage,
              arguments: AddAddressPageArgs(navigateFromAddresses: false));
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppStyle.yellowButton,
          ),
          child: Center(
            child: Text(
              '${context.translate(AppStrings.ADD_ADDRESS)}',
              style: AppFontStyle.blueTextH2,
            ),
          ),
        ),
      ),
    );
  }
}
