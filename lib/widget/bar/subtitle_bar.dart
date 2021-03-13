import 'package:flutter/material.dart';
import 'package:outmatic/util/app_theme.dart';

class SubTitleBar extends StatelessWidget {
  final String subTitle;

  SubTitleBar({this.subTitle = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.primaryDarkColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Text(subTitle, style: TextStyle(color: Colors.white, fontSize: 18),),
    );
  }
}
