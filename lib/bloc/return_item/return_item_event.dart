import 'package:flutter/material.dart';

@immutable
abstract class ReturnItemEvent {}

class ReturnItemDetailEvent extends ReturnItemEvent {
  final String rfid;

  ReturnItemDetailEvent({this.rfid});
}

class ReturnItemUpdateEvent extends ReturnItemEvent {
  final String nodeTitle;

  ReturnItemUpdateEvent({this.nodeTitle});
}
