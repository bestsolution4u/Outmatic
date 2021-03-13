import 'package:flutter/material.dart';
import 'package:outmatic/config/image.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';
import 'package:outmatic/util/app_theme.dart';

class ReturnItemWidget extends StatelessWidget {

  final TagItemDetailModel item;
  final int index;

  ReturnItemWidget({this.item, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 30),
            child: Image.asset(Images.menuReturnItem, width: 30),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("#${index + 1}) Artikelen Nr", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),),
                SizedBox(height: 5,),
                Text(item.nummer, style: TextStyle(color: Colors.black, fontSize: 16),),
                SizedBox(height: 10,),
                Text("omschrijving", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),),
                SizedBox(height: 5,),
                Text(item.omschrijving, style: TextStyle(color: Colors.black, fontSize: 16),),
                SizedBox(height: 10,),
                Text("Medewerker", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),),
                SizedBox(height: 5,),
                Text(item.ms_personeel_fullname, style: TextStyle(color: Colors.black, fontSize: 16),),
                SizedBox(height: 10,),
                Text("Amount", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),),
                SizedBox(height: 5,),
                Text("", style: TextStyle(color: Colors.black, fontSize: 16),),
                SizedBox(height: 10,),
                Text("Project", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),),
                SizedBox(height: 5,),
                Text("${item.Description}\n(ProjectNr: ${item.ProjectNr})", style: TextStyle(color: Colors.black, fontSize: 16),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
