import 'package:flutter/material.dart';

@immutable
abstract class NewItemEvent {}

class NewItemSearchEvent extends NewItemEvent {
  final String query;

  NewItemSearchEvent({this.query});
}

class NewItemRFIDScannedEvent extends NewItemEvent {
  final String rfid;

  NewItemRFIDScannedEvent({this.rfid});
}

class NewItemAssignEvent extends NewItemEvent {
  final String title, rfid;

  NewItemAssignEvent({this.title, this.rfid});
}