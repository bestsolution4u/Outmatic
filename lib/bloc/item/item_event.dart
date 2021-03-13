import 'package:flutter/material.dart';

@immutable
abstract class ItemEvent {}

class ItemFetchEvent extends ItemEvent {
  final int page;

  ItemFetchEvent({this.page});
}

class ItemSearchEvent extends ItemEvent {
  final String query;

  ItemSearchEvent({this.query});
}

class ItemScanEvent extends ItemEvent {
  final String rfid;

  ItemScanEvent({this.rfid});
}