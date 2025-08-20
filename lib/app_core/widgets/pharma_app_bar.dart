import 'package:flutter/material.dart';

class tasawaaqAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onClickBackBtn, onClickFilterBtn;
  final bool hasFilter;

  const tasawaaqAppBar({
    Key? key,
    required this.title,
    this.onClickBackBtn,
    this.hasFilter = false,
    this.onClickFilterBtn,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: onClickBackBtn ??
            () {
              Navigator.of(context).pop();
            },
      ),
      title: Text('$title'),
      actions: [
        if (hasFilter)
          IconButton(
            icon: Icon(Icons.filter_alt_rounded,color: Colors.black,),
            onPressed: onClickFilterBtn,
          ),
      ],
    );
  }
}
