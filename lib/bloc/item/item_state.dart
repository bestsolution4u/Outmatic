import 'package:flutter/material.dart';
import 'package:outmatic/model/item_model.dart';

@immutable
abstract class ItemState {}

class ItemInitialState extends ItemState {}

class ItemLoadingState extends ItemState {}

class ItemFetchedState extends ItemState {
  final List<ItemModel> items;
  final int totalItemCount;

  ItemFetchedState({this.items, this.totalItemCount});
}

class ItemSearchResultState extends ItemState {
  final List<ItemModel> items;

  ItemSearchResultState({this.items});
}

class ItemScanResultState extends ItemState {
  final List<ItemModel> items;

  ItemScanResultState({this.items});
}

class ItemErrorState extends ItemState {
  final int code;
  final String message;

  ItemErrorState({this.code, this.message});
}