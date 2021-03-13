import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/routes.dart';
import 'package:outmatic/model/project_item_model.dart';
import 'package:outmatic/model/project_model.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/widget/bar/child_page_appbar.dart';
import 'package:outmatic/widget/bar/pagenation_bar.dart';
import 'package:outmatic/widget/bar/subtitle_bar.dart';
import 'package:outmatic/widget/item/project_item_widget.dart';
import 'package:outmatic/widget/loading/app_loading.dart';

import '../../../app_bloc.dart';

class ProjectItemListScreen extends StatefulWidget {

  final ProjectModel project;

  ProjectItemListScreen({this.project});

  @override
  _ProjectItemListScreenState createState() => _ProjectItemListScreenState();
}

class _ProjectItemListScreenState extends State<ProjectItemListScreen> {
  int _curPage = 0, _pageCount = 0;
  List<ProjectItemModel> items = [];
  ProjectItemBloc _projectItemBloc;

  @override
  void initState() {
    super.initState();
    _projectItemBloc = BlocProvider.of<ProjectItemBloc>(context);
    _projectItemBloc.add(ProjectItemFetchEvent(projectID: widget.project.projectId, page: 0));
    _projectItemBloc.add(ProjectItemCountEvent(projectID: widget.project.projectId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectItemBloc, ProjectItemState>(
        listener: (context, state) {
          if (state is ProjectItemFetchedState) {
            setState(() {
              items = state.items;
            });
          } else if (state is ProjectItemCountState) {
            setState(() {
              _pageCount = (state.count / 10).ceil();
            });
          } else if (state is ProjectItemErrorState) {
            String text = "";
            if (state.message.toLowerCase().contains("unauth")) {
              text = "Unauthenticated User. Please login";
            } else {
              text = "API error. Please contact with developer";
            }
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text("Error", style: TextStyle(color: Colors.red),),
                content: Text(text, style: TextStyle(color: Colors.black)),
                actions: [
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (state.message.toLowerCase().contains("unauth")) {
                        AppBloc.loginBloc.add(OnLogoutEvent());
                      }
                    },
                  )
                ],
              ),
            );
          }
        },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).padding.top,
                  color: AppTheme.primaryDarkColor,
                ),
                ChildPageAppbar(
                  title: widget.project.projectId,
                  onBack: () => Navigator.pop(context),
                ),
                items.length == 0 ? Expanded(child: Center(child: Text("No data"),),) : Container(),
                items.length > 0 ? SubTitleBar(
                  subTitle: "Page ${_curPage + 1} of $_pageCount",
                ) : Container(),
                items.length > 0 ? Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(0),
                    itemCount: items.length,
                    itemBuilder: (context, index) => ProjectItemWidget(projectItem: items[index], onPress: () => Navigator.pushNamed(context, Routes.projectItemDetail, arguments: items[index].title)),
                    separatorBuilder: (context, index) => Container(width: double.infinity, height: 1, color: AppTheme.primaryColor),
                  ),
                ) : Container(),
                items.length > 0 ? PagenationBar(
                  pageCount: _pageCount,
                  currentPage: _curPage,
                  onPageSelected: (index) {
                    setState(() {
                      _curPage = index;
                      _projectItemBloc.add(ProjectItemFetchEvent(projectID: widget.project.projectId, page: index));
                    });
                  },
                ) : Container()
              ],
            ),
            BlocBuilder<ProjectItemBloc, ProjectItemState>(
              builder: (context, state) {
                if (state is ProjectItemLoadingState) {
                  return AppLoadingDialog(
                    text: "Loading Items...",
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
