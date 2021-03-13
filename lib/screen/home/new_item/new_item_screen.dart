import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/application.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/util/string_utils.dart';
import 'package:outmatic/util/toasts.dart';
import 'package:outmatic/widget/bar/subtitle_bar.dart';
import 'package:outmatic/widget/button/app_button.dart';
import 'package:outmatic/widget/loading/app_loading.dart';

import '../../../app_bloc.dart';

class NewItemScreen extends StatefulWidget {
  @override
  _NewItemScreenState createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {

  NewItemBloc _newItemBloc;
  String _subTitle = "";
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";
  String swipedID = "", associatedID = "", title = "", type = "", datum = "";

  @override
  void initState() {
    super.initState();
    _newItemBloc = BlocProvider.of<NewItemBloc>(context);
    _subTitle = "Swipe the RFID Tag to check for associated item";
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      String rfid = StringUtil.parseRFID(onData.id);
      ToastUtils.showSuccessToast(context, rfid);
      setState(() {
        swipedID = rfid;
      });
      _newItemBloc.add(NewItemRFIDScannedEvent(rfid: rfid));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewItemBloc, NewItemState>(
      listener: (context, state) {
        if (state is NewItemSearchResultState) {
          setState(() {
            associatedID = state.item?.rfid_code;
            title = state.item?.artikelnummer;
            type = state.item?.type;
            datum = state.item?.vca_datum;
            if (swipedID.isEmpty) {
              _subTitle = "Swipe the RFID Tag to assign";
            } else {
              _subTitle = "Assign the RFID Tag";
            }
          });
          //// test
          /*swipedID = Application.rfidTest;
          _newItemBloc.add(NewItemRFIDScannedEvent(rfid: Application.rfidTest));*/
          //// test
        } else if (state is NewItemRFIDItemDetailFetchedState) {
          if (state.item != null) {
            setState(() {
              associatedID = state.item['rfid_code'];
              title = state.item['nummer'];
              type = state.item['omschrijving'];
              datum = state.item['datum_van'];
              if (swipedID.isEmpty) {
                _subTitle = "Swipe the RFID Tag to assign";
              } else {
                _subTitle = "Assign the RFID Tag";
              }
            });
          }
        } else if (state is NewItemUpdatedState) {
          setState(() {
            _subTitle = "RFID Tag assigned to the item";
          });
        } else if (state is NewItemErrorState) {
          if (state.message.toLowerCase().contains("projecten_data1")) {
            ToastUtils.showSuccessToast(context, "No assigned items to this RFID tag");
          } else {
            String text = "";
            if (state.message.toLowerCase().contains("unauth")) {
              text = "Unauthenticated User. Please login";
            } else {
              text = state.message;
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
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          centerTitle: false,
          leading: Container(),
          title: _isSearching ? _buildSearchField() : Text("Add New Item ", style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),),
          actions: _buildActions(),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubTitleBar(
                  subTitle: _subTitle,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("New RFID Tag Information", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 30,),
                            Text("Swiped RFID Tag ID", style: TextStyle(color: AppTheme.primaryColor),),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(swipedID, style: TextStyle(fontSize: 18, color: Colors.black),)
                              ],
                            ),
                            SizedBox(height: 20,),
                            Container(width: double.infinity, height: 2, color: Colors.black,),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Item Information", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 30,),
                            Text("nummer", style: TextStyle(color: AppTheme.primaryColor),),
                            SizedBox(height: 10,),
                            Text(title, style: TextStyle(color: Colors.black, fontSize: 18),),
                            SizedBox(height: 20,),
                            Text("omschrijving", style: TextStyle(color: AppTheme.primaryColor),),
                            SizedBox(height: 10,),
                            Text(type, style: TextStyle(color: Colors.black, fontSize: 18),),
                            SizedBox(height: 20,),
                            Text("keuringvca", style: TextStyle(color: AppTheme.primaryColor),),
                            SizedBox(height: 10,),
                            Text(datum, style: TextStyle(color: Colors.black, fontSize: 18),),
                            SizedBox(height: 20,),
                            Text("Associated RFID Tag ID", style: TextStyle(color: AppTheme.primaryColor),),
                            SizedBox(height: 10,),
                            Text(associatedID, style: TextStyle(color: Colors.black, fontSize: 18),),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: AppTheme.primaryColor,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(child: AppButton(text: "ASSIGN RFID TAG", fontSize: 14, onPressed: () {
                        if (swipedID.isEmpty) {
                          ToastUtils.showErrorToast(context, "Please swipe the RFID Tag to assign");
                        } else if (title.isEmpty) {
                          ToastUtils.showErrorToast(context, "Please select an item to assign");
                        } else {
                          _newItemBloc.add(NewItemAssignEvent(title: title, rfid: swipedID));
                        }
                      },),),
                      SizedBox(width: 20,),
                      Expanded(child: AppButton(text: "CLEAR LIST", fontSize: 14, onPressed: () {
                        setState(() {
                          _subTitle = "Swipe the RFID Tag to check for associated item";
                          swipedID = "";
                          associatedID = "";
                          title = "";
                          type = "";
                          datum = "";
                        });
                      },),),
                    ],
                  ),
                )
              ],
            ),
            BlocBuilder<NewItemBloc, NewItemState>(
                builder: (context, state) {
                  if (state is NewItemLoadingState) {
                    return AppLoadingDialog(
                      text: "Wait...",
                    );
                  } else {
                    return Container();
                  }
                },
            )
          ],
        ),
      ),
    );
  }


  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search item...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
      onSubmitted: (value) {
        _newItemBloc.add(NewItemSearchEvent(query: value));
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
