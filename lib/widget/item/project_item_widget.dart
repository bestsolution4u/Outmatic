import 'package:flutter/material.dart';
import 'package:outmatic/config/image.dart';
import 'package:outmatic/model/project_item_model.dart';
import 'package:outmatic/util/app_theme.dart';

class ProjectItemWidget extends StatelessWidget {

  final ProjectItemModel projectItem;
  final VoidCallback onPress;

  ProjectItemWidget({this.projectItem, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onPress(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(Images.Box, width: 30),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Project Item ID", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),),
                    SizedBox(height: 5,),
                    Text(projectItem.title, style: TextStyle(color: Colors.black, fontSize: 16),),
                    SizedBox(height: 10,),
                    Text("Description", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),),
                    SizedBox(height: 5,),
                    Text(projectItem.description, style: TextStyle(color: Colors.black, fontSize: 16),),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Icon(Icons.keyboard_arrow_right),
              SizedBox(width: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
