import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/image.dart';
import 'package:outmatic/model/item_detail_model.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/widget/bar/child_page_appbar.dart';
import 'package:outmatic/widget/item/item_detail_item.dart';
import 'package:outmatic/widget/loading/app_loading.dart';

import '../../../app_bloc.dart';

class ProjectItemDetailScreen extends StatefulWidget {
  final String nodeTitle;

  ProjectItemDetailScreen({this.nodeTitle});

  @override
  _ProjectItemDetailScreenState createState() =>
      _ProjectItemDetailScreenState();
}

class _ProjectItemDetailScreenState extends State<ProjectItemDetailScreen>
    with TickerProviderStateMixin {
  ItemDetailModel _item = ItemDetailModel();
  TabController _tabController;
  ItemDetailBloc _itemDetailBloc;

  @override
  void initState() {
    _itemDetailBloc = BlocProvider.of<ItemDetailBloc>(context);
    _itemDetailBloc.add(ItemDetailFetchEvent(nodeTitle: widget.nodeTitle));
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemDetailBloc, ItemDetailState>(
      listener: (context, state) {
        if (state is ItemDetailFetchedState) {
          setState(() {
            _item = state.item;
          });
        } else if (state is ItemDetailErrorState) {
          String text = "";
          if (state.message.toLowerCase().contains("unauth")) {
            text = "Unauthenticated User. Please login";
          } else {
            text = "API error. Please contact with developer";
          }
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Error", style: TextStyle(color: Colors.red),),
              content: Text(text, style: TextStyle(color: Colors.black)),
              actions: [
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (state.message.toLowerCase().contains("unauth")) {
                      AppBloc.loginBloc.add(OnLogoutEvent());
                    }
                  },
                )
              ],
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).padding.top,
                  color: AppTheme.primaryDarkColor,
                ),
                ChildPageAppbar(
                  title: widget.nodeTitle,
                  onBack: () => Navigator.pop(context),
                ),
                TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: AppTheme.primaryColor,
                  tabs: [
                    Tab(child: Image.asset(Images.ItemDetail1, width: 24)),
                    Tab(child: Image.asset(Images.Box, width: 24)),
                    Tab(child: Image.asset(Images.ItemDetail3, width: 24)),
                  ],
                  controller: _tabController,
                  indicatorColor: AppTheme.primaryColor,
                  indicatorWeight: 3,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      buildDetail1(),
                      buildDetail2(),
                      buildDetail3()
                    ],
                    controller: _tabController,
                  ),
                )
              ],
            ),
            BlocBuilder<ItemDetailBloc, ItemDetailState>(
              builder: (context, state) {
                if (state is ItemDetailLoadingState) {
                  return AppLoadingDialog(
                    text: "Loading Item Details...",
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetail1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            ItemDetailItem(label: "Soort", content: _item.soort),
            SizedBox(height: 20,),
            ItemDetailItem(label: "Type", content: _item.type),
            Divider(height: 40, color: Colors.black,),
            ItemDetailItem(label: "Merk", content: _item.merk),
            SizedBox(height: 20,),
            ItemDetailItem(label: "Serienummer", content: _item.serienummer),
            SizedBox(height: 20,),
            ItemDetailItem(label: "Bouwjaar", content: _item.bouwjaar),
            SizedBox(height: 20,),
            ItemDetailItem(label: "Producent", content: _item.producent),
            SizedBox(height: 20,),
            ItemDetailItem(label: "Kenteken", content: _item.merk),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

  Widget buildDetail2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            ItemDetailItem(label: "Medewerker", content: _item.uitvoerder),
            SizedBox(height: 20,),
            ItemDetailItem(label: "Project", content: _item.project),
            SizedBox(height: 20,),
            ItemDetailItem(label: "Verhuurdatum", content: _item.datum),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

  Widget buildDetail3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            ItemDetailItem(label: "VCA", content: _item.vca),
            SizedBox(height: 20,),
            ItemDetailItem(label: "Datum", content: _item.vca_datum),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
