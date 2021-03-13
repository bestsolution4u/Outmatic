import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/routes.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/util/string_utils.dart';
import 'package:outmatic/util/toasts.dart';
import 'package:outmatic/widget/bar/default_appbar.dart';
import 'package:outmatic/widget/bar/subtitle_bar.dart';
import 'package:outmatic/widget/button/app_button.dart';
import 'package:outmatic/widget/item/return_item_widget.dart';
import 'package:outmatic/widget/loading/app_loading.dart';

import '../../../app_bloc.dart';

class BatchScanScreen extends StatefulWidget {
  @override
  _BatchScanScreenState createState() => _BatchScanScreenState();
}

class _BatchScanScreenState extends State<BatchScanScreen> {

  BatchBloc _batchBloc;
  List<TagItemDetailModel> items = [];

  @override
  void initState() {
    super.initState();
    _batchBloc = BlocProvider.of<BatchBloc>(context);
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      String rfid = StringUtil.parseRFID(onData.id);
      ToastUtils.showSuccessToast(context, rfid);
      _batchBloc.add(BatchItemDetailEvent(rfid: rfid));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BatchBloc, BatchState>(
        listener: (context, state) {
          if (state is BatchItemFetchedState) {
            if (state.items != null) {
              setState(() {
                items.addAll(state.items);
                final ids = items.map((e) => e.nummer).toSet();
                items.retainWhere((element) => ids.remove(element.nummer));
              });
            }
          } else if (state is BatchUpdatedState) {
            String ids = "";
            items.forEach((element) {
              if (ids.isNotEmpty) {
                ids += ",";
              }
              ids += element.rfid_code;
            });
            items.clear();
            _batchBloc.add(BatchItemDetailEvent(rfid: ids));
          } else if (state is BatchErrorState) {
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
                DefaultAppBar(
                  title: "Batch Scan Item",
                ),
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
                      itemBuilder: (context, index) => ReturnItemWidget(item: items[index], index: index,),
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
                          text: "TOEWIJZEN",
                          fontSize: 14,
                          onPressed: () {
                            if (items.length > 0) {
                              Navigator.pushNamed(context, Routes.batchUPD,
                                  arguments: List<TagItemDetailModel>.from(items));
                            }
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
            BlocBuilder<BatchBloc, BatchState>(
              builder: (context, state) {
                if (state is BatchLoadingState) {
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
