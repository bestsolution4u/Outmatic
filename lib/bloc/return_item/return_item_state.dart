import 'package:flutter/material.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';

@immutable
abstract class ReturnItemState {}

class ReturnItemInitialState extends ReturnItemState {}

class ReturnItemLoadingState extends ReturnItemState {}

class ReturnItemFetchedState extends ReturnItemState {
  final TagItemDetailModel item;

  ReturnItemFetchedState({this.item});
}

class ReturnItemUpdatedState extends ReturnItemState {
  final List<TagItemDetailModel> items;

  ReturnItemUpdatedState({this.items});
}

class ReturnItemErrorState extends ReturnItemState {
  final int code;
  final String message;

  ReturnItemErrorState({this.code, this.message});
}