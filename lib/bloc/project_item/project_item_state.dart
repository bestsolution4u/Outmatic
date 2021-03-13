import 'package:flutter/material.dart';
import 'package:outmatic/model/project_item_model.dart';

@immutable
abstract class ProjectItemState {}

class ProjectItemInitialState extends ProjectItemState {}

class ProjectItemLoadingState extends ProjectItemState {}

class ProjectItemCountState extends ProjectItemState {
  final int count;

  ProjectItemCountState({this.count});
}

class ProjectItemFetchedState extends ProjectItemState {
  final List<ProjectItemModel> items;

  ProjectItemFetchedState({this.items});
}

class ProjectItemErrorState extends ProjectItemState {
  final int code;
  final String message;

  ProjectItemErrorState({this.code, this.message});
}