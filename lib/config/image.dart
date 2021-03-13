class Images {
  static const String Logo = "assets/images/logo.png";
  static const String Background = "assets/images/background.jpg";
  static const String Box = "assets/images/ic_item_detail_2.png";
  static const String ItemDetail1 = "assets/images/ic_item_detail_1.png";
  static const String ItemDetail3 = "assets/images/ic_item_detail_3.png";
  static const String person = "assets/images/ic_medewerker.png";

  /// menu images
  static const String menuHome = "assets/images/ic_home.png";
  static const String menuProjectList = "assets/images/ic_project.png";
  static const String menuItemList = "assets/images/ic_item_list.png";
  static const String menuAddNewItem = "assets/images/ic_new_item.png";
  static const String menuBatchScan = "assets/images/ic_batch_scan.png";
  static const String menuReturnItem = "assets/images/ic_return_item.png";
  static const String menuVCAItem = "assets/images/ic_vca_item.png";
  static const String menuSettings = "assets/images/ic_setting.png";
  static const String menuLogout = "assets/images/ic_logout.png";

  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}