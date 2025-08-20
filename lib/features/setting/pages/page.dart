import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/drawer/drawer.dart';
import 'package:tasawaaq/features/setting/pages/page_manager.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tasawaaq/features/setting/pages/page_response.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/app_core/app_core.dart';


class PagesArgs {
  final id;
  final hasDrawer;
  PagesArgs({
    required this.id,
    required this.hasDrawer,
  });
}

class ServicesTemplatePage extends StatefulWidget {
  const ServicesTemplatePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ServicesTemplatePage> createState() => _ServicesTemplatePageState();
}

class _ServicesTemplatePageState extends State<ServicesTemplatePage> {

  PagesArgs? args;


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {

      args = ModalRoute.of(context)!.settings.arguments as PagesArgs;


      if(args != null){
        context.use<PageManager>().execute(pageId: args!.id);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // final PagesArgs args =
    //     ModalRoute.of(context)!.settings.arguments as PagesArgs;
    final pageManager = context.use<PageManager>();

    if(args==null){
      final PagesArgs args =
      ModalRoute.of(context)!.settings.arguments as PagesArgs;
      pageManager.execute(pageId: args.id);
    }

    return Material(
      child:  Observer<PageResponse>(
          onRetryClicked: () {
            pageManager.execute(pageId: args!.id);
          },
          manager: pageManager,
          stream: pageManager.pages$,
          onSuccess: (context, pageSnapshot) {
          return Scaffold(
            drawer: args!.hasDrawer == true ? AppDrawer():null,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: MainAppBar(
                hasDrawer: args!.hasDrawer,
                hasCart: false,
                title: Text(
                  "${pageSnapshot.data!.title}",
                ),
              ),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        width: 150.w,
                        child: Image.asset(
                          AppAssets.APP_BAR_LOGO,
                          // color: AppStyle.appBarColor,
                        ),
                      ),
                      // Text(
                      //   locator<PrefsService>().appLanguage == 'en' ? 'ALWAYS IN STYLE !':'! ALWAYS IN STYLE',
                      //   style: TextStyle(
                      //     fontSize: 10.sp,
                      //     color: AppStyle.yellowButton,
                      //   ),
                      // )
                    ],
                  ),
                ),
                // Text('${args.body}')
                Html(
                  data: "${pageSnapshot.data!.desc}",
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
