import 'package:flutter/material.dart';

@immutable
abstract class ItemDetailEvent {}

class ItemDetailFetchEvent extends ItemDetailEvent {
  final String nodeTitle;

  ItemDetailFetchEvent({this.nodeTitle});
}