import 'package:flutter/material.dart';
import 'package:outmatic/model/project_model.dart';

@immutable
abstract class ProjectState {}

class ProjectInitialState extends ProjectState {}

class ProjectLoadingState extends ProjectState {}

class ProjectFetchedState extends ProjectState {
  final List<ProjectModel> projects;
  final int lastPage;
  final int currentPage;
  ProjectFetchedState({this.projects, this.lastPage, this.currentPage});
}

class ProjectSearchResultState extends ProjectState {
  final List<ProjectModel> projects;

  ProjectSearchResultState({this.projects});
}

class ProjectErrorState extends ProjectState {
  final int code;
  final String message;
  ProjectErrorState({this.code, this.message});
}
