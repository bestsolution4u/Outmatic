import 'package:flutter/material.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/widget/bar/child_page_appbar.dart';
import 'package:outmatic/widget/bar/subtitle_bar.dart';
import 'package:outmatic/widget/button/app_button.dart';
import 'package:outmatic/widget/item/return_item_widget.dart';

class BatchScanStatusScreen extends StatefulWidget {

  final List<TagItemDetailModel> items;

  BatchScanStatusScreen({this.items});

  @override
  _BatchScanStatusScreenState createState() => _BatchScanStatusScreenState();
}

class _BatchScanStatusScreenState extends State<BatchScanStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppTheme.primaryDarkColor,
          ),
          ChildPageAppbar(
            title: "Batch Scan Item Status",
            onBack: () => Navigator.pop(context),
          ),
          SubTitleBar(
            subTitle: "Item status",
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemCount: widget.items.length,
                itemBuilder: (context, index) => ReturnItemWidget(item: widget.items[index], index: index,),
                separatorBuilder: (context, index) => Container(width: double.infinity, height: 1, color: Colors.grey,),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: AppTheme.primaryColor,
            padding: const EdgeInsets.all(15),
            child: AppButton(
              text: "CLOSE",
              fontSize: 14,
              onPressed: () => Navigator.pop(context),
            )
          )
        ],
      ),
    );
  }
}
