class ItemModel {
  String id, artikelnummer, type;

  ItemModel({this.id, this.artikelnummer, this.type});

  factory ItemModel.fromJson(Map<String, dynamic> jsonItem) {
    try {
      return ItemModel(
        id: jsonItem['id'].toString() ?? "",
        artikelnummer: jsonItem['artikelnummer'].toString() ?? "",
        type: jsonItem['type'].toString() ?? "",
      );
    } catch (err) {
      return null;
    }
  }

  factory ItemModel.fromScanResult(Map<String, dynamic> jsonItem) {
    try {
      return ItemModel(
        id: jsonItem['id'].toString() ?? "",
        artikelnummer: jsonItem['nummer'].toString() ?? "",
        type: jsonItem['omschrijving'].toString() ?? "",
      );
    } catch (err) {
      return null;
    }
  }
}