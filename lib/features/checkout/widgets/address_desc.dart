import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_style/app_style.dart';

class AddressDesc extends StatelessWidget {

  final String? namePhone;
  final String? addressDesc;
  final VoidCallback? onClickDeleteBtn, onClickEditBtn;



  const AddressDesc({Key? key,this.addressDesc,this.namePhone,this.onClickDeleteBtn,this.onClickEditBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    if(namePhone != null)  Text("$namePhone",style: AppFontStyle.blueTextH4,),
                    if(namePhone != null)   SizedBox(height: 10,),
                    Text("$addressDesc",style: AppFontStyle.greyTextH4,),
                  ],
                )
            ),
            SizedBox(
              width: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onClickEditBtn,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                    child: SvgPicture.asset(
                      '${AppAssets.pen_edit}',
                      color: AppStyle.topDarkGrey,
                      matchTextDirection: true,
                      height: 20,
                    ),
                  ),
                ),

               if(onClickDeleteBtn != null) InkWell(
                  onTap: onClickDeleteBtn,
                  child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                      child: FaIcon(FontAwesomeIcons.trashAlt,color: Colors.black54,size:20)),
                ),
              ],
            )
          ],
        ));
  }
}
