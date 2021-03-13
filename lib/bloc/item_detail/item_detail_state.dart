import 'package:flutter/material.dart';
import 'package:outmatic/model/item_detail_model.dart';

@immutable
abstract class ItemDetailState {}

class ItemDetailInitialState extends ItemDetailState {}

class ItemDetailLoadingState extends ItemDetailState {}

class ItemDetailFetchedState extends ItemDetailState {
  final ItemDetailModel item;

  ItemDetailFetchedState({this.item});
}

class ItemDetailErrorState extends ItemDetailState {
  final int code;
  final String message;

  ItemDetailErrorState({this.code, this.message});
}