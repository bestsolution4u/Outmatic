import 'package:flutter/material.dart';
import 'package:outmatic/model/item_detail_model.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';

@immutable
abstract class VCAState {}

class VCAInitialState extends VCAState {}

class VCALoadingState extends VCAState {}

class VCAItemFetchedState extends VCAState {
  final TagItemDetailModel item;

  VCAItemFetchedState({this.item});
}

class VCAUpdatedState extends VCAState {}

class VCAErrorState extends VCAState {
  final int code;
  final String message;

  VCAErrorState({this.code, this.message});
}