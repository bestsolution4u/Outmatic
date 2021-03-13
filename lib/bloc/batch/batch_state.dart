import 'package:flutter/material.dart';
import 'package:outmatic/model/batch_project_model.dart';
import 'package:outmatic/model/med_model.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';

@immutable
abstract class BatchState {}

class BatchInitialState extends BatchState {}

class BatchLoadingState extends BatchState {}

class BatchItemFetchedState extends BatchState {
  final List<TagItemDetailModel> items;

  BatchItemFetchedState({this.items});
}

class BatchMEDFetchedState extends BatchState {
  final List<MedModel> users;

  BatchMEDFetchedState({this.users});
}

class BatchPRDFetchedState extends BatchState {
  final List<BatchProjectModel> projects;

  BatchPRDFetchedState({this.projects});
}

class BatchUpdatedState extends BatchState {}

class BatchErrorState extends BatchState {
  final int code;
  final String message;

  BatchErrorState({this.code, this.message});
}
