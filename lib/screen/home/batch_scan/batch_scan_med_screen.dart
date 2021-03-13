import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/model/med_model.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/widget/bar/subtitle_bar.dart';
import 'package:outmatic/widget/item/med_item.dart';

import '../../../app_bloc.dart';

class BatchScanMEDScreen extends StatefulWidget {
  @override
  _BatchScanMEDScreenState createState() => _BatchScanMEDScreenState();
}

class _BatchScanMEDScreenState extends State<BatchScanMEDScreen> {

  BatchBloc _batchBloc;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";
  List<MedModel> users = [];

  @override
  void initState() {
    super.initState();
    _batchBloc = BlocProvider.of<BatchBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BatchBloc, BatchState>(
        listener: (context, state) {
          if (state is BatchMEDFetchedState) {
            if (state.users != null) {
              setState(() {
                users = state.users;
              });
            } else {
              setState(() {
                users.clear();
              });
            }
          } else if (state is BatchErrorState) {
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
        },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          centerTitle: false,
          leading: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(32),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(Icons.arrow_back, color: Colors.white,),
              ),
            ),
          ),
          title: _isSearching ? _buildSearchField() : Text("Zoek Medewerker", style: TextStyle(
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
                  subTitle: "Selecteer Medewerker",
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: users.length,
                      itemBuilder: (context, index) => MedItemWidget(user: users[index], onPress: () {
                        ModalRoute.of(context).didPop(null);
                        Navigator.pop(context, users[index]);
                      }),
                      separatorBuilder: (context, index) => Container(width: double.infinity, height: 1, color: Colors.grey,),
                    ),
                  ),
                ),
              ],
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
        hintText: "Search medewerker...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          _batchBloc.add(BatchMedSearchEvent(query: value));
        }
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
