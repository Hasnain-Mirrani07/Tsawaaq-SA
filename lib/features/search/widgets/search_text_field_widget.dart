import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/search/search_post/search_post_manager.dart';
import 'package:tasawaaq/features/search_results/search_results_page.dart';
import 'package:tasawaaq/shared/custom_text_field/custom_text_field.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';

class SearchTextFiledWidget extends StatefulWidget {
  const SearchTextFiledWidget({Key? key}) : super(key: key);

  @override
  _SearchTextFiledWidgetState createState() => _SearchTextFiledWidgetState();
}

class _SearchTextFiledWidgetState extends State<SearchTextFiledWidget> {
  String? _search;
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomTextFiled(
      controller: _controller,
      obscureText: false,
      maxLines: 1,
      suffixIcon: IconButton(
        onPressed: (){
          removeFocus(context);
          Navigator.of(context).pushNamed(AppRouts.SearchResultsPage,);
          _controller.clear();
        },
        icon: Container(
          child: SvgPicture.asset(
            AppAssets.search,
            semanticsLabel: 'tasawaaq Logo',
            height: 18,
            width: 18,
            color: AppStyle.introGrey,
            matchTextDirection: true,
          ),
        ),
      ),
      onFieldSubmitted: (v) {
        removeFocus(context);
        Navigator.of(context).pushNamed(AppRouts.SearchResultsPage,);
        _controller.clear();
      },
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
          _search = value;
          locator<SearchManager>().keyWordSubject = value;
        } else {
          _search = '';
          locator<SearchManager>().keyWordSubject = '';
        }
      },);
  }
}
