class ItemDetailModel {
  String artikelnummer, rfid_code, soort, type, merk, serienummer, bouwjaar, producent, kenteken, vca, vca_datum, uitvoerder, project, datum, in_gebruik, status;

  ItemDetailModel({
    this.artikelnummer = "",
    this.rfid_code = "",
    this.soort = "",
    this.type = "",
    this.merk = "",
    this.serienummer = "",
    this.bouwjaar = "",
    this.producent = "",
    this.kenteken = "",
    this.vca = "",
    this.vca_datum = "",
    this.uitvoerder = "",
    this.project = "",
    this.datum = "",
    this.in_gebruik = "",
    this.status = ""
});

  factory ItemDetailModel.fromJson(Map<String, dynamic> jsonItem) {
    try {
      return ItemDetailModel(
        artikelnummer: jsonItem['artikelnummer'].toString() ?? "",
        rfid_code: jsonItem['rfid_code'].toString() ?? "",
        soort: jsonItem['soort'].toString() ?? "",
        type: jsonItem['type'].toString() ?? "",
        merk: jsonItem['merk'].toString() ?? "",
        serienummer: jsonItem['serienummer'].toString() ?? "",
        bouwjaar: jsonItem['bouwjaar'].toString() ?? "",
        producent: jsonItem['producent'].toString() ?? "",
        kenteken: jsonItem['kenteken'].toString() ?? "",
        vca: jsonItem['vca'].toString() ?? "",
        vca_datum: jsonItem['vca_datum'].toString() ?? "",
        uitvoerder: jsonItem['uitvoerder'].toString() ?? "",
        project: jsonItem['project'].toString() ?? "",
        datum: jsonItem['datum'].toString() ?? "",
        in_gebruik: jsonItem['in_gebruik'].toString() ?? "",
        status: jsonItem['status'].toString() ?? "",
      );
    } catch (err) {
      return null;
    }
  }
}
