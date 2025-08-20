import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_style/app_style.dart';



class RemoveAddFavBottomWidget extends StatelessWidget {

  final bool? isFav;
  final VoidCallback? onClickRemove,onClickFav;


  const RemoveAddFavBottomWidget({Key? key,this.isFav,this.onClickFav,this.onClickRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(bottom: 15,left: 15,right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onClickRemove,
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.trashAlt,color: Colors.black54,size:23),
                SizedBox(
                  width: 8,
                ),
                Text("${context.translate(AppStrings.Remove)}",style: AppFontStyle.blueTextH4,)
              ],
            ),
          ),
          InkWell(
            onTap: onClickFav,
            child: Row(
              children: [
                Icon(isFav == true? Icons.favorite : Icons.favorite_border_outlined,color: isFav == true? AppStyle.blueTextButton : Colors.black54,size:27 ,),
                SizedBox(
                  width: 8,
                ),
                Text("${context.translate(isFav == true? AppStrings.Remove_from_Favorite : AppStrings.Add_to_Favorite)}",style: AppFontStyle.blueTextH4,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
