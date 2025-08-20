import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';

class CopyOfAnimatedTile extends StatefulWidget {
  final String? headerText;
  final List<Widget> body;
  final bool? outValue;
  final Color? bodyColor;
  final Color? headerColor;
  final bool tileState;
  final bool isColumn;

  CopyOfAnimatedTile({
    this.headerText,
    required this.body,
    this.outValue,
    this.bodyColor,
    this.headerColor,
    this.tileState = false,
    this.isColumn = true,
  });

  @override
  _CopyOfAnimatedTileState createState() => _CopyOfAnimatedTileState();
}

class _CopyOfAnimatedTileState extends State<CopyOfAnimatedTile>
    with TickerProviderStateMixin {
  late BehaviorSubject<bool> open;

  @override
  void initState() {
    open = BehaviorSubject<bool>.seeded(widget.tileState);
    super.initState();
  }

  @override
  void dispose() {
    open.close();
    super.dispose();
  }

  void openToggle() {
    if (open.value == false) {
      open.add(true);
    } else {
      open.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: widget.outValue,
        stream: open.stream,
        builder: (context, openSnapshot) {
          return AnimatedSize(
            duration: new Duration(milliseconds: 350),
            reverseDuration: Duration(milliseconds: 350),
            alignment: Alignment.topCenter,
            // vsync: this,
            curve: Curves.easeIn,
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      openToggle();
                    },
                    child: Container(
                      key: UniqueKey(),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          color: widget.headerColor,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "${widget.headerText}",
                                style: openSnapshot.data == false
                                    ? AppFontStyle.greyTextH2
                                    : AppFontStyle.blueTextH2,
                              ),
                              openSnapshot.data == false
                                  ? Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      size: 25.0,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.keyboard_arrow_up_sharp,

                                      size: 25.0,
                                      // color: AppStyle.c1,
                                    )
                            ],
                          )),
                    ),
                  ),
                  openSnapshot.data == true
                      ? Container(
                          width: widget.isColumn
                              ? double.infinity
                              : MediaQuery.of(context).size.width * 0.95,
                          color: widget.bodyColor,
                          key: UniqueKey(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: widget.isColumn
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: widget.body,
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: widget.body,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        });
  }
}
