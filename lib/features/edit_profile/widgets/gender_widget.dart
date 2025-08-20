import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/edit_profile/edit_profile_manager.dart';
import 'package:tasawaaq/shared/custom_list_tile/custom_list_tile.dart';

class GenderWidget extends StatefulWidget {
  final String? gender;
  const GenderWidget({Key? key, this.gender}) : super(key: key);

  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    locator<EditProfileManager>().resetGenderSubject();
    if (widget.gender != null) {
      if (widget.gender != 'null') {
        if (widget.gender!.isNotEmpty) {
          if(widget.gender!.toLowerCase() == 'male'){
            locator<EditProfileManager>().selectGenderSubject.value = genders[0];
          }else if(widget.gender!.toLowerCase() == 'female'){
            locator<EditProfileManager>().selectGenderSubject.value = genders[1];
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final editProfileManager = context.use<EditProfileManager>();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "${AppLocalizations.of(context)!.translate(AppStrings.GENDER)} (${AppLocalizations.of(context)!.translate(AppStrings.OPTIONAL)})",
              style: AppFontStyle.blueTextH4,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey)),
            child: ValueListenableBuilder<Gender>(
                valueListenable: editProfileManager.selectGenderSubject,
                builder: (context, areaValue, _) {
                  return CustomAnimatedOpenTile(
                    vsync: this,
                    headerTxt: '${areaValue.title}',
                    body: Container(
                      // height: MediaQuery.of(context).size.height * .45,
                      child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return Container(
                              child: Divider(),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: genders.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                editProfileManager.selectGenderSubject.value = genders[index];
                                // setState(() {
                                //
                                // });
                              },
                              child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: Text("${genders[index].title}")),
                            );
                          }),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

List<Gender> genders = [
  Gender(id: 1, title: locator<PrefsService>().appLanguage == 'en' ? "Male":"ذكر", value: 'male'),
  Gender(id: 2, title: locator<PrefsService>().appLanguage == 'en' ? "Female":"انثي", value: 'female'),
];

class Gender {
  int? id;
  String? title;
  String? value;
  Gender({this.title, this.id, this.value});
}
