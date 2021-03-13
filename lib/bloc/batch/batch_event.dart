
abstract class BatchEvent {}

class BatchItemDetailEvent extends BatchEvent {
  final String rfid;

  BatchItemDetailEvent({this.rfid});
}

class BatchMedSearchEvent extends BatchEvent {
  final String query;

  BatchMedSearchEvent({this.query});
}

class BatchPrdSearchEvent extends BatchEvent {
  final String query;

  BatchPrdSearchEvent({this.query});
}

class BatchUpdateEvent extends BatchEvent {
  final String uid, projectID, nodeDetails;

  BatchUpdateEvent({this.uid, this.projectID, this.nodeDetails});
}