class TagItemDetailModel {
  String nid,
      nummer,
      rfid_code,
      omschrijving,
      type,
      keuringvca,
      datum_van,
      project_id,
      ms_projecten_fullname,
      ProjectNr,
      vca_datum,
      Description,
      personeel_id,
      ms_personeel_fullname,
      in_gebruik,
      data_found;

  TagItemDetailModel(
      {this.nid = "",
      this.nummer = "",
      this.rfid_code = "",
      this.omschrijving = "",
      this.type = "",
      this.keuringvca = "",
      this.datum_van = "",
      this.project_id = "",
      this.ms_projecten_fullname = "",
      this.ProjectNr = "",
      this.vca_datum = "",
      this.Description = "",
      this.personeel_id = "",
      this.ms_personeel_fullname = "",
      this.data_found = "",
      this.in_gebruik = ""});

  factory TagItemDetailModel.fromJson(Map<String, dynamic> jsonItem) {
    try {
      return TagItemDetailModel(
        nid: jsonItem['nid'].toString() ?? "",
        nummer: jsonItem['nummer'].toString() ?? "",
        rfid_code: jsonItem['rfid_code'].toString() ?? "",
        omschrijving: jsonItem['omschrijving'].toString() ?? "",
        type: jsonItem['type'].toString() ?? "",
        keuringvca: jsonItem['keuringvca'].toString() ?? "",
        datum_van: jsonItem['datum_van'].toString() ?? "",
        project_id: jsonItem['project_id'].toString() ?? "",
        ms_projecten_fullname: jsonItem['ms_projecten_fullname'].toString() ?? "",
        ProjectNr: jsonItem['ProjectNr'].toString() ?? "",
        vca_datum: jsonItem['vca_datum'].toString() ?? "",
        Description: jsonItem['Description'].toString() ?? "",
        personeel_id: jsonItem['personeel_id'].toString() ?? "",
        ms_personeel_fullname: jsonItem['ms_personeel_fullname'].toString() ?? "",
        data_found: jsonItem['data_found'].toString() ?? "",
        in_gebruik: jsonItem['in_gebruik'].toString() ?? "",
      );
    } catch (err) {
      return null;
    }
  }
}
