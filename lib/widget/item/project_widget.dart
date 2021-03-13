import 'package:flutter/material.dart';
import 'package:outmatic/config/image.dart';
import 'package:outmatic/model/project_model.dart';
import 'package:outmatic/util/app_theme.dart';

class ProjectWidget extends StatefulWidget {

  final ProjectModel project;
  final VoidCallback onPress;

  ProjectWidget({this.project, this.onPress});

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onPress(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(Images.menuProjectList, width: 30),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Project Nr", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),),
                    SizedBox(height: 5,),
                    Text(widget.project.projectId, style: TextStyle(color: Colors.black, fontSize: 16),),
                    SizedBox(height: 10,),
                    Text("Description", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),),
                    SizedBox(height: 5,),
                    Text(widget.project.name, style: TextStyle(color: Colors.black, fontSize: 16),),
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
