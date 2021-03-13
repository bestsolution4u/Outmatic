import 'package:flutter/material.dart';
import 'package:outmatic/screen/home/drawer_menu.dart';

class DrawerMenuController extends StatefulWidget {
  final double drawerWidth;
  final Widget screenView;
  final AnimatedIconData animatedIconData;
  final Widget menuView;
  final DrawerMenuIndex screenIndex;
  final Function(bool) drawerIsOpen;
  final Function(DrawerMenuIndex) onMenuPress;

  DrawerMenuController(
      {this.drawerWidth = 250,
      this.screenView,
      this.animatedIconData = AnimatedIcons.arrow_menu,
      this.menuView,
      this.screenIndex,
      this.drawerIsOpen,
      this.onMenuPress});

  @override
  _DrawerMenuControllerState createState() => _DrawerMenuControllerState();
}

class _DrawerMenuControllerState extends State<DrawerMenuController>
    with TickerProviderStateMixin {
  ScrollController scrollController;
  AnimationController iconAnimationController;
  AnimationController animationController;
  double scrollOffset = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController
      ..animateTo(1.0,
          duration: const Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController
      ..addListener(() {
        if (scrollController.offset <= 0) {
          if (scrollOffset != 1.0) {
            setState(() {
              scrollOffset = 1.0;
              try {
                widget.drawerIsOpen(true);
              } catch (_) {}
            });
          }
          iconAnimationController.animateTo(0.0,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        } else if (scrollController.offset > 0 &&
            scrollController.offset < widget.drawerWidth.floor()) {
          iconAnimationController.animateTo(
              (scrollController.offset * 100 / (widget.drawerWidth)) / 100,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        } else {
          if (scrollOffset != 0.0) {
            setState(() {
              scrollOffset = 0.0;
              try {
                widget.drawerIsOpen(false);
              } catch (_) {}
            });
          }
          iconAnimationController.animateTo(1.0,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        }
      });
    WidgetsBinding.instance.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  Future<bool> getInitState() async {
    scrollController.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          child: Row(
            children: [
              SizedBox(
                width: widget.drawerWidth,
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: iconAnimationController,
                  builder: (BuildContext context, Widget child) {
                    return Transform(
                      //transform we use for the stable drawer  we, not need to move with scroll view
                      transform: Matrix4.translationValues(scrollController.offset, 0.0, 0.0),
                      child: DrawerMenu(
                        screenIndex: widget.screenIndex == null ? DrawerMenuIndex.Home : widget.screenIndex,
                        animationController: iconAnimationController,
                        drawerWidth: widget.drawerWidth,
                        onMenuPress: (DrawerMenuIndex index) {
                          onMenuClick();
                          widget.onMenuPress(index);
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.grey.withOpacity(0.6), blurRadius: 24),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      IgnorePointer(
                        ignoring: scrollOffset == 1 || false,
                        child: widget.screenView,
                      ),
                      if (scrollOffset == 1.0)
                        InkWell(
                          onTap: () => onMenuClick(),
                        ),
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, left: 8),
                        child: SizedBox(
                          width: AppBar().preferredSize.height - 8,
                          height: AppBar().preferredSize.height - 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                              child: Center(
                                child: widget.menuView != null
                                    ? widget.menuView
                                    : AnimatedIcon(
                                  color: Colors.white,
                                    icon: widget.animatedIconData != null ? widget.animatedIconData : AnimatedIcons.arrow_menu,
                                    progress: iconAnimationController),
                              ),
                              onTap: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                onMenuClick();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onMenuClick() {
    if (scrollController.offset != 0.0) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
