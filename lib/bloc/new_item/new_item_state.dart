import 'package:flutter/material.dart';
import 'package:outmatic/model/item_detail_model.dart';

@immutable
abstract class NewItemState {}

class NewItemInitialState extends NewItemState {}

class NewItemLoadingState extends NewItemState {}

class NewItemSearchResultState extends NewItemState {
  final ItemDetailModel item;

  NewItemSearchResultState({this.item});
}

class NewItemRFIDItemDetailFetchedState extends NewItemState {
  final Map<String, dynamic> item;

  NewItemRFIDItemDetailFetchedState({this.item});
}

class NewItemUpdatedState extends NewItemState {}

class NewItemErrorState extends NewItemState {
  final int code;
  final String message;

  NewItemErrorState({this.code, this.message});
}