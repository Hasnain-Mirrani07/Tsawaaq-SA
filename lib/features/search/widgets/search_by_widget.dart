import 'package:flutter/material.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/search/search_post/search_post_manager.dart';
import 'package:tasawaaq/shared/check_box/check_box.dart';
import 'package:tasawaaq/app_core/app_core.dart';

class SearchByWidget extends StatefulWidget {
  const SearchByWidget({Key? key}) : super(key: key);

  @override
  _SearchByWidgetState createState() => _SearchByWidgetState();
}

class _SearchByWidgetState extends State<SearchByWidget> {

  List<SearchItem> searchItems = [
    SearchItem(
        id: "mall",
        title: locator<PrefsService>().appLanguage == "en" ? "Mall":"مول"
    ),
    SearchItem(
        id: "store",
        title:locator<PrefsService>().appLanguage == "en" ? "Stores":"المتاجر"
    ),
    SearchItem(
        id: "brand",
        title: locator<PrefsService>().appLanguage == "en" ? "Brands":"العلامات التجارية"
    ),
    SearchItem(
        id: "category",
        title: locator<PrefsService>().appLanguage == "en" ? "Category":"قسم"
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final searchManager= context.use<SearchManager>();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${context.translate(AppStrings.Search_By)}",style: AppFontStyle.blueTextH2,),

          SizedBox(
            height: 15,
          ),
          StreamBuilder<List<SearchItem>>(
              stream: searchManager.selectedSearchItemsSubject.stream,
              builder: (context, selectedSearchItemsSnapShot) {
                return  selectedSearchItemsSnapShot.hasData?
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return Container(
                        child: Divider(),
                      );
                    },
                    shrinkWrap: true,
                    itemCount: searchItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("${searchItems[index].title}",style: AppFontStyle.greyTextH3,),

                            InkWell(
                                onTap: (){
                                  if(!selectedSearchItemsSnapShot.data!.contains(searchItems[index])){
                                    searchManager.searchItemsList.add(searchItems[index]);
                                    searchManager.typeSubject.add(searchItems[index].id);
                                  }else{
                                    searchManager.searchItemsList.remove(searchItems[index]);
                                    searchManager.typeSubject.remove(searchItems[index].id);

                                  }
                                  searchManager.selectedSearchItemsSubject.sink.add(searchManager.searchItemsList);
                                  print("${selectedSearchItemsSnapShot.data} selectedSearchItemsValue");
                                  print("${searchManager.typeSubject}=> searchManager.typeSubject");
                                },
                                child: selectedSearchItemsSnapShot.data!.contains(searchItems[index]) ? BoxChecked():BoxNotChecked()),

                          ],
                        ),
                      );
                    }):Container();
              }
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}


class SearchItem {
  final String title;
  final String id;

  SearchItem({ this.id= "", this.title = ""});

}

