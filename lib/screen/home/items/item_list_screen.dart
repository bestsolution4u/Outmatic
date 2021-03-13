import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/routes.dart';
import 'package:outmatic/model/item_model.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/util/string_utils.dart';
import 'package:outmatic/util/toasts.dart';
import 'package:outmatic/widget/bar/pagenation_bar.dart';
import 'package:outmatic/widget/bar/subtitle_bar.dart';
import 'package:outmatic/widget/item/item_widget.dart';
import 'package:outmatic/widget/loading/app_loading.dart';

import '../../../app_bloc.dart';

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  int _curPage = 0, _pageCount = 0;
  List<ItemModel> items = [];
  ItemBloc _itemBloc;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _itemBloc = BlocProvider.of<ItemBloc>(context);
    _itemBloc.add(ItemFetchEvent(page: 0));
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      String rfid = StringUtil.parseRFID(onData.id);
      ToastUtils.showSuccessToast(context, rfid);
      _itemBloc.add(ItemScanEvent(rfid: rfid));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemBloc, ItemState>(
      listener: (context, state) {
        if (state is ItemFetchedState) {
          setState(() {
            items = state.items;
            if (_pageCount == 0) {
              _pageCount = (state.totalItemCount / 10).ceil();
            }
          });
        } else if (state is ItemSearchResultState) {
          setState(() {
            items = state.items;
          });
        } else if (state is ItemScanResultState) {
          setState(() {
            items = state.items;
          });
        } else if (state is ItemErrorState) {
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
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          centerTitle: false,
          leading: Container(),
          title: _isSearching
              ? _buildSearchField()
              : Text(
            "Artikenlen List",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: _buildActions(),
        ),
        body: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    items.length == 0 ? Expanded(child: Center(child: Text("No data"),),) : Container(),
                    state is ItemSearchResultState ? Container() : items.length > 0 ? SubTitleBar(
                      subTitle: state is ItemScanResultState ? "Press the Pagination, to Cancel Search result" : "Page ${_curPage + 1} of $_pageCount",
                    ) : Container(),
                    items.length > 0 ? Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(0),
                        itemCount: items.length,
                        itemBuilder: (context, index) => ItemWidget(
                            item: items[index],
                            onPress: () => Navigator.pushNamed(
                                context, Routes.projectItemDetail,
                                arguments: items[index].artikelnummer)),
                        separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 1,
                            color: AppTheme.primaryColor),
                      ),
                    ) : Container(),
                    state is ItemSearchResultState ? Container() : items.length > 0 ? PagenationBar(
                      pageCount: _pageCount,
                      currentPage: _curPage,
                      onPageSelected: (index) {
                        setState(() {
                          _curPage = index;
                          _itemBloc.add(ItemFetchEvent(page: index));
                        });
                      },
                    ) : Container()
                  ],
                ),
                state is ItemLoadingState ? AppLoadingDialog(text: "Loading Artikenlen...") : Container()
              ],
            );
          },
        )
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Artikenlen...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
      onSubmitted: (value) {
        _itemBloc.add(ItemSearchEvent(query: value));
      },
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              setState(() {
                _curPage = 0;
                _itemBloc.add(ItemFetchEvent(page: 0));
              });
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
