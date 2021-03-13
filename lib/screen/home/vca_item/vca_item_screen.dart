import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:intl/intl.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/util/string_utils.dart';
import 'package:outmatic/util/toasts.dart';
import 'package:outmatic/widget/bar/default_appbar.dart';
import 'package:outmatic/widget/bar/subtitle_bar.dart';
import 'package:outmatic/widget/button/app_button.dart';
import 'package:outmatic/widget/item/vca_item_widget.dart';
import 'package:outmatic/widget/loading/app_loading.dart';

import '../../../app_bloc.dart';

class VCAItemScreen extends StatefulWidget {
  @override
  _VCAItemScreenState createState() => _VCAItemScreenState();
}

class _VCAItemScreenState extends State<VCAItemScreen> {

  VCABloc _vcaBloc;
  List<TagItemDetailModel> items = [];

  @override
  void initState() {
    super.initState();
    _vcaBloc = BlocProvider.of<VCABloc>(context);
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      String rfid = StringUtil.parseRFID(onData.id);
      ToastUtils.showSuccessToast(context, rfid);
      _vcaBloc.add(VCADetailEvent(rfid: rfid));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VCABloc, VCAState>(
        listener: (context, state) {
          if (state is VCAItemFetchedState) {
            setState(() {
              items.add(state.item);
              final ids = items.map((e) => e.nummer).toSet();
              items.retainWhere((element) => ids.remove(element.nummer));
            });
          } else if (state is VCAUpdatedState) {
            String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
            setState(() {
              for (int i = 0; i < items.length; i++) {
                items[i].vca_datum = date;
              }
            });
          } else if (state is VCAErrorState) {
            String text = "";
            if (state.message.toLowerCase().contains("unauth")) {
              text = "Unauthenticated User. Please login";
            } else if (state.message.toLowerCase().contains("projecten_data")) {
              text = "No items assigned to this tag";
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
        backgroundColor: AppTheme.primaryColor,
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
                DefaultAppBar(title: "VCA Item",),
                SubTitleBar(
                  subTitle: "Status: Ready to Scan(Count #${items.length})",
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: items.length,
                      itemBuilder: (context, index) => VCAItemWidget(item: items[index], index: index,),
                      separatorBuilder: (context, index) => Container(width: double.infinity, height: 1, color: Colors.grey,),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: AppTheme.primaryColor,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: "UPDATE VCA",
                          fontSize: 14,
                          onPressed: () {
                            String query = "";
                            items.forEach((element) {
                              if (query.isNotEmpty) {
                                query += " OR ";
                              }
                              query += element.nummer;
                            });
                            _vcaBloc.add(VCAUpdateEvent(title: query));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: AppButton(
                          text: "CLEAR LIST",
                          fontSize: 14,
                          onPressed: () {
                            setState(() {
                              items.clear();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            BlocBuilder<VCABloc, VCAState>(
              builder: (context, state) {
                if (state is VCALoadingState) {
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
}
