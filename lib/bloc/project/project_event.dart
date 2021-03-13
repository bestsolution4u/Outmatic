import 'package:flutter/material.dart';

@immutable
abstract class ProjectEvent {}

class ProjectFetchEvent extends ProjectEvent {
  final int page;

  ProjectFetchEvent({this.page = 0});
}

class ProjectSearchEvent extends ProjectEvent {
  final String query;

  ProjectSearchEvent({this.query});
}