import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_core.dart';

class BaseWidget extends StatefulWidget {
  final Widget child;

  const BaseWidget({Key? key, required this.child}) : super(key: key);
  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('LifeCycleState = $state');
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context);

    final loadingManager = context.use<LoadingManager>();

    return StreamBuilder(
        initialData: ManagerState.IDLE,
        stream: loadingManager.state$,
        builder: (context, stateSnapshot) {
          switch (stateSnapshot.data) {
            case ManagerState.LOADING:
              return Stack(
                children: [
                  widget.child,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black12.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
              break;

            case ManagerState.SOCKET_ERROR:
              return Stack(
                children: [
                  widget.child,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black12.withOpacity(0.3),
                    child: Center(
                      child: errorWidget(context),
                    ),
                  ),
                ],
              );
              break;

            case ManagerState.SUCCESS:
              return Stack(
                children: [
                  widget.child,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black12.withOpacity(0.3),
                    child: Center(
                      child: errorWidget(context),
                    ),
                  ),
                ],
              );
              break;
          }
          return stateSnapshot.data == ManagerState.LOADING
              ? Stack(
                  children: [
                    widget.child,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black12.withOpacity(0.3),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                )
              : widget.child;
        });
  }
}

Widget errorWidget(BuildContext context) {
  String errorDescription = locator<PrefsService>().appLanguage == 'en'
      ? 'Something Went Wrong Try Again Later'
      : 'حدث خطأ ما حاول مرة أخرى لاحقاً';
  return FadeInUp(
    child: CustomDialog(
      titleColor: Colors.black,
      // title: _err1.title,
      description: errorDescription,
      descriptionColor: Colors.black54,
      // onCloseBtn: () {
      //   // Navigator.of(context).pop();
      //   locator<LoadingManager>().inState.add(ManagerState.IDLE);
      // },
      confirmBtnTxt: context.translate(AppStrings.OK),
      onClickConfirmBtn: () {
        locator<LoadingManager>().inState.add(ManagerState.IDLE);
      },
    ),
  );
}
