abstract class VCAEvent {}

class VCADetailEvent extends VCAEvent {
  final String rfid;

  VCADetailEvent({this.rfid});
}

class VCAUpdateEvent extends VCAEvent {
  final String title;

  VCAUpdateEvent({this.title});
}