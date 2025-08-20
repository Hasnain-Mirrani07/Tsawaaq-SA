import 'package:flutter/material.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/search/search_get/search_manager.dart';
import 'package:tasawaaq/features/search/search_get/search_response.dart';
import 'package:tasawaaq/features/search/search_post/search_post_manager.dart';
import 'package:tasawaaq/features/search/widgets/recent_searches_widget.dart';
import 'package:tasawaaq/features/search/widgets/search_by_widget.dart';
import 'package:tasawaaq/features/search/widgets/search_text_field_widget.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';
import 'package:tasawaaq/shared/title_desc_btn/title_desc_btn.dart';
import 'package:tasawaaq/app_core/app_core.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  void initState() {
    super.initState();
    locator<SearchManager>().resetManager();
    locator<SearchGetManager>().execute();
    // locator<SearchManager>().resetSearchAttributesManager();

    // locator<AllStoresManager>().selectedIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    final searchManager = context.use<SearchManager>();
    final searchGetManager = context.use<SearchGetManager>();

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Observer<SearchGetResponse>(
          onRetryClicked: () {
            searchGetManager.execute();
          },
          manager: searchGetManager,
          stream: searchGetManager.searchGet$,
          onSuccess: (context, searchGetSnapshot) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TitleDescBtn(
                    title: "${context.translate(AppStrings.Search_Products)}",
                    desc: "${searchGetSnapshot.data!.total} ${context.translate(AppStrings.PRODUCTS)}",
                    isFilter: false,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SearchTextFiledWidget()),

                RecentSearchesWidget(recentSearchList: searchGetSnapshot.data!.recectSearchs,title:searchGetSnapshot.data!.hasRecent == true ?"${context.translate(AppStrings.Recent_Searches)}":"${context.translate(AppStrings.MOST_POPULAR_SEARCHES)}",),
                // RecentSearchesWidget(recentSearchList: searchGetSnapshot.data!.recectSearchs,title:"${context.translate(AppStrings.popular_Searches)}",isDivider: false,),
                SizedBox(
                  height: 25,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SearchByWidget())
              ],
            ),
          );
        }
      ),
    );
  }
}


