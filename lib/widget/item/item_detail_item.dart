import 'package:flutter/material.dart';
import 'package:outmatic/util/app_theme.dart';

class ItemDetailItem extends StatelessWidget {

  final String label, content;

  ItemDetailItem({this.label, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppTheme.primaryColor, fontSize: 12),),
        SizedBox(height: 10,),
        Text(content ?? "N/A", style: TextStyle(color: Colors.black, fontSize: 16),),
      ],
    );
  }
}
