import 'package:flutter/material.dart';
import 'package:outmatic/config/image.dart';
import 'package:outmatic/util/app_theme.dart';

class DrawerMenu extends StatefulWidget {
  final double drawerWidth;
  final AnimationController animationController;
  final DrawerMenuIndex screenIndex;
  final Function(DrawerMenuIndex) onMenuPress;

  DrawerMenu(
      {this.animationController,
      this.screenIndex,
      this.onMenuPress,
      this.drawerWidth = 250});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  List<DrawerMenuItem> menuList;

  @override
  void initState() {
    super.initState();
    setMenuList();
  }

  void setMenuList() {
    menuList = <DrawerMenuItem>[
      DrawerMenuItem(
          label: "Home",
          image: Images.menuHome,
          index: DrawerMenuIndex.Home),
      DrawerMenuItem(
          label: "Projecten",
          image: Images.menuProjectList,
          index: DrawerMenuIndex.ProjectList),
      DrawerMenuItem(
          label: "Artikelen",
          image: Images.menuItemList,
          index: DrawerMenuIndex.ItemList),
      DrawerMenuItem(
          label: "Add New Item",
          image: Images.menuAddNewItem,
          index: DrawerMenuIndex.NewItem),
      DrawerMenuItem(
          label: "Batch Scan Item",
          image: Images.menuBatchScan,
          index: DrawerMenuIndex.BatchScan),
      DrawerMenuItem(
          label: "Return Item",
          image: Images.menuReturnItem,
          index: DrawerMenuIndex.ReturnItem),
      DrawerMenuItem(
          label: "VCA Item",
          image: Images.menuVCAItem,
          index: DrawerMenuIndex.VcaItem),
      DrawerMenuItem(
          label: "Settings",
          image: Images.menuSettings,
          index: DrawerMenuIndex.Settings),
      DrawerMenuItem(
          label: "Logout",
          image: Images.menuLogout,
          index: DrawerMenuIndex.Logout),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: widget.drawerWidth,
              height: widget.drawerWidth,
              child: Stack(
                children: [
                  Image.asset(Images.Background,
                      width: widget.drawerWidth, height: widget.drawerWidth),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Outmatic", style: Theme.of(context).textTheme.headline3),
                          SizedBox(height: 10),
                          Text("Materieelbeheer")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: menuList.length,
              itemBuilder: (context, index) => buildMenuItem(menuList[index]),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(DrawerMenuItem item) {
    return Column(
      children: [
        item.index == DrawerMenuIndex.NewItem || item.index == DrawerMenuIndex.Settings || item.index == DrawerMenuIndex.Logout ? Divider(height: 0, thickness: 1,) : Container(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: AppTheme.primaryColor.withOpacity(0.2),
            highlightColor: Colors.transparent,
            onTap: () => widget.onMenuPress(item.index),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      Image.asset(item.image,
                          width: 24,
                          height: 24,
                          color: widget.screenIndex == item.index
                              ? AppTheme.primaryColor
                              : Colors.black),
                      SizedBox(width: 20),
                      Text(item.label,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: widget.screenIndex == item.index
                                  ? AppTheme.primaryColor
                                  : Colors.black),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
                widget.screenIndex == item.index
                    ? AnimatedBuilder(
                  animation: widget.animationController,
                  builder: (context, child) => Transform(
                    transform: Matrix4.translationValues(
                        (widget.drawerWidth - 64) *
                            (1.0 - widget.animationController.value - 1.0),
                        0.0,
                        0.0),
                    child: Container(
                      width: widget.drawerWidth - 64,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(28),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                    ),
                  ),
                )
                    : Container()
              ],
            ),
          ),
        )
      ],
    );
  }
}

enum DrawerMenuIndex {
  Home,
  ProjectList,
  ItemList,
  NewItem,
  BatchScan,
  ReturnItem,
  VcaItem,
  Settings,
  Logout
}

class DrawerMenuItem {
  String image, label;
  DrawerMenuIndex index;

  DrawerMenuItem({this.image, this.label, this.index});
}
