import 'package:flutter/material.dart';

@immutable
abstract class ProjectItemEvent {}

class ProjectItemFetchEvent extends ProjectItemEvent {
  final String projectID;
  final int page;

  ProjectItemFetchEvent({this.page, this.projectID});
}

class ProjectItemCountEvent extends ProjectItemEvent {
  final String projectID;

  ProjectItemCountEvent({this.projectID});
}