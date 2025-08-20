// import 'package:tasawaaq/features/trips/trips_data.dart';
// import 'package:tasawaaq/features/trips/trips_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/edit_profile/edit_profile_manager.dart';

// final boatBookingManager = locator<BoatBookingManager>();
final now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final ToastTemplate _showToast = locator<ToastTemplate>();
final yesterday = DateTime(now.year, now.month, now.day - 1);
final prefs = locator<PrefsService>();

class DateWidget extends StatefulWidget {
  final String? dateOfBirth;

  const DateWidget({Key? key, this.dateOfBirth}) : super(key: key);

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  final editProfileManager = locator<EditProfileManager>();

  @override
  void initState() {
    super.initState();
    if (widget.dateOfBirth != null) {
      if (widget.dateOfBirth != 'null') {
        if(widget.dateOfBirth != "0000-00-00"){
        if (widget.dateOfBirth!.isNotEmpty) {
          editProfileManager.selectDateSubject.value = widget.dateOfBirth;
         }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "${AppLocalizations.of(context)!.translate(AppStrings.Date_of_Birth)} (${AppLocalizations.of(context)!.translate(AppStrings.OPTIONAL)})",
              style: AppFontStyle.blueTextH4,
            ),
          ),

          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(color: AppStyle.introGrey),
              // color: containerColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ValueListenableBuilder(
                valueListenable: editProfileManager.selectDateSubject,
                builder: (context, dateValue, _) {
                  return InkWell(
                    onTap: () {
                      Future<void> selectSingleData(context) async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          firstDate:
                              DateTime(now.year - 100, now.month, now.day + 1),
                          initialDate:
                              DateTime(now.year, now.month, now.day + 1),
                          lastDate:
                              new DateTime(now.year + 1, now.month, now.day),
                        );
                        if (picked != null) {
                          editProfileManager.selectDateSubject.value =
                              formatter.format(picked);
                          _showToast.show(formatter.format(picked));
                        }
                      }

                      selectSingleData(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "$dateValue",
                        ),
                        SvgPicture.asset(
                          AppAssets.calendar,
                          semanticsLabel: 'calendar',
                          color: AppStyle.introGrey,
                        ),

                        // dateOrDateWidget(dateValue)
                      ],
                    ),
                  );
                }),
          ),
          // SizedBox(
          //   height: 25,
          // ),
        ],
      ),
    );
  }
}
