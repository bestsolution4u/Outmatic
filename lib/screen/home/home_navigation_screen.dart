import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'batch_scan/batch_scan_screen.dart';
import 'items/item_list_screen.dart';
import 'new_item/new_item_screen.dart';
import 'projects/project_list_screen.dart';
import 'return_item/return_item_screen.dart';
import 'settings/settings_screen.dart';
import 'vca_item/vca_item_screen.dart';
import 'drawer_menu.dart';
import 'home/home_screen.dart';
import 'drawer_menu_controller.dart';

class HomeNavigationScreen extends StatefulWidget {
  @override
  _HomeNavigationScreenState createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {

  Widget screenView;
  DrawerMenuIndex drawerIndex;
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    drawerIndex = DrawerMenuIndex.Home;
    screenView = HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DrawerMenuController(
        drawerWidth: MediaQuery.of(context).size.width * 0.7,
        screenIndex: drawerIndex,
        screenView: screenView,
        animatedIconData: AnimatedIcons.arrow_menu,
        onMenuPress: (DrawerMenuIndex index) => onMenuPress(index),
      ),
    );
  }

  void onMenuPress(DrawerMenuIndex index) {
    if (drawerIndex != index) {
      if (index == DrawerMenuIndex.Logout) {
        _loginBloc.add(OnLogoutEvent());
      } else {
        drawerIndex = index;
        switch (index) {
          case DrawerMenuIndex.Home:
            setState(() {
              screenView = HomeScreen();
            });
            break;

          case DrawerMenuIndex.ProjectList:
            setState(() {
              screenView = ProjectListScreen();
            });
            break;

          case DrawerMenuIndex.ItemList:
            setState(() {
              screenView = ItemListScreen();
            });
            break;

          case DrawerMenuIndex.NewItem:
            setState(() {
              screenView = NewItemScreen();
            });
            break;

          case DrawerMenuIndex.BatchScan:
            setState(() {
              screenView = BatchScanScreen();
            });
            break;

          case DrawerMenuIndex.ReturnItem:
            setState(() {
              screenView = ReturnItemScreen();
            });
            break;

          case DrawerMenuIndex.VcaItem:
            setState(() {
              screenView = VCAItemScreen();
            });
            break;

          case DrawerMenuIndex.Settings:
            setState(() {
              screenView = SettingsScreen();
            });
            break;

          default:
            setState(() {
              screenView = HomeScreen();
            });
            break;
        }
      }
    }
  }
}
