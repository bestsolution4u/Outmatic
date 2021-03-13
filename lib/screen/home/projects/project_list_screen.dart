import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/app_bloc.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/routes.dart';
import 'package:outmatic/model/project_model.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/widget/bar/default_appbar.dart';
import 'package:outmatic/widget/bar/pagenation_bar.dart';
import 'package:outmatic/widget/bar/subtitle_bar.dart';
import 'package:outmatic/widget/item/project_widget.dart';
import 'package:outmatic/widget/loading/app_loading.dart';

class ProjectListScreen extends StatefulWidget {
  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  int _curPage = 0, _pageCount = 0;
  List<ProjectModel> projects = [];
  ProjectBloc _projectBloc;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _projectBloc = BlocProvider.of<ProjectBloc>(context);
    _projectBloc.add(ProjectFetchEvent(page: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectFetchedState) {
          setState(() {
            _pageCount = state.lastPage;
            projects = state.projects;
          });
        } else if (state is ProjectSearchResultState) {
          setState(() {
            projects = state.projects;
          });
        } else if (state is ProjectErrorState) {
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
              title: Text(
                "Error",
                style: TextStyle(color: Colors.red),
              ),
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
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          centerTitle: false,
          leading: Container(),
          title: _isSearching
              ? _buildSearchField()
              : Text(
                  "Project List",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          actions: _buildActions(),
        ),
        body: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    projects.length == 0
                        ? Expanded(
                            child: Center(
                              child: Text("No data"),
                            ),
                          )
                        : Container(),
                    state is ProjectSearchResultState
                        ? Container()
                        : projects.length > 0
                            ? SubTitleBar(
                                subTitle: "Page ${_curPage + 1} of $_pageCount",
                              )
                            : Container(),
                    projects.length > 0
                        ? Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.all(0),
                              itemCount: projects.length,
                              itemBuilder: (context, index) => ProjectWidget(
                                  project: projects[index],
                                  onPress: () => Navigator.pushNamed(
                                      context, Routes.projectItem,
                                      arguments: projects[index])),
                              separatorBuilder: (context, index) => Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: AppTheme.primaryColor),
                            ),
                          )
                        : Container(),
                    state is ProjectSearchResultState
                        ? Container()
                        : projects.length > 0
                            ? PagenationBar(
                                pageCount: _pageCount,
                                currentPage: _curPage,
                                onPageSelected: (index) {
                                  setState(() {
                                    _curPage = index;
                                    _projectBloc.add(
                                        ProjectFetchEvent(page: index + 1));
                                  });
                                },
                              )
                            : Container()
                  ],
                ),
                state is ProjectLoadingState
                    ? AppLoadingDialog(
                        text: "Loading Projects...",
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Projects...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
      onSubmitted: (value) {
        _projectBloc.add(ProjectSearchEvent(query: value));
      },
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              setState(() {
                _curPage = 0;
                _projectBloc.add(
                    ProjectFetchEvent(page: 1));
              });
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
