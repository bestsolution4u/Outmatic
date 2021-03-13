import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:outmatic/screen/home/batch_scan/batch_scan_med_screen.dart';
import 'package:outmatic/screen/home/batch_scan/batch_scan_prd_screen.dart';
import 'package:outmatic/screen/home/batch_scan/batch_scan_status_screen.dart';
import 'package:outmatic/screen/home/batch_scan/batch_scan_upd_screen.dart';
import 'package:outmatic/screen/home/projects/project_item_detail_screen.dart';
import 'package:outmatic/screen/home/projects/project_item_list_screen.dart';
import 'package:outmatic/screen/home/return_item/return_item_status_screen.dart';
import 'package:outmatic/screen/home/return_item/return_item_upd.dart';
import 'package:outmatic/screen/screen.dart';

class Routes {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String home = "/homeNavigation";
  static const String projectItem = "/projectItem";
  static const String projectItemDetail = "/projectItemDetail";
  static const String returnUPD = "/returnUPD";
  static const String returnStatus = "/returnStatus";
  static const String batchUPD = "/batchUPD";
  static const String batchMED = "/batchMED";
  static const String batchPRD = "/batchPRD";
  static const String batchStatus = "/batchStatus";

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case login:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case home:
        return MaterialPageRoute(builder: (context) => HomeNavigationScreen());

      case projectItem:
        return MaterialPageRoute(builder: (context) => ProjectItemListScreen(project: settings.arguments,));

      case projectItemDetail:
        return MaterialPageRoute(builder: (context) => ProjectItemDetailScreen(nodeTitle: settings.arguments,));

      case returnUPD:
        return MaterialPageRoute(builder: (context) => ReturnItemUPDScreen(items: settings.arguments));

      case returnStatus:
        return MaterialPageRoute(builder: (context) => ReturnItemStatusScreen(items: settings.arguments));

      case batchUPD:
        return MaterialPageRoute(builder: (context) => BatchScanUPDScreen(items: settings.arguments));

      case batchMED:
        return MaterialPageRoute(builder: (context) => BatchScanMEDScreen());

      case batchPRD:
        return MaterialPageRoute(builder: (context) => BatchScanPRDScreen());

      case batchStatus:
        return MaterialPageRoute(builder: (context) => BatchScanStatusScreen(items: settings.arguments,));

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text("Not Found"),
                  ),
                  body: Center(
                    child: Text('No path for ${settings.name}'),
                  ),
                ));
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
