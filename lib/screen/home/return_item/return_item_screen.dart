import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/application.dart';
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

class ReturnItemScreen extends StatefulWidget {
  @override
  _ReturnItemScreenState createState() => _ReturnItemScreenState();
}

class _ReturnItemScreenState extends State<ReturnItemScreen> {

  ReturnItemBloc _returnItemBloc;
  List<TagItemDetailModel> items = [];

  @override
  void initState() {
    super.initState();
    _returnItemBloc = BlocProvider.of<ReturnItemBloc>(context);
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      String rfid = StringUtil.parseRFID(onData.id);
      ToastUtils.showSuccessToast(context, rfid);
      _returnItemBloc.add(ReturnItemDetailEvent(rfid: rfid));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReturnItemBloc, ReturnItemState>(
        listener: (context, state) {
          if (state is ReturnItemFetchedState) {
            if (state.item != null) {
              setState(() {
                items.add(state.item);
                final ids = items.map((e) => e.nummer).toSet();
                items.retainWhere((element) => ids.remove(element.nummer));
              });
            }
          } else if (state is ReturnItemUpdatedState) {
            setState(() {
              items = state.items;
            });
          } else if (state is ReturnItemErrorState) {
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
              DefaultAppBar(title: "Return Item",),
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
                            Navigator.pushNamed(context, Routes.returnUPD,
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
                          /*if (items.length == 0) {
                            _returnItemBloc.add(ReturnItemDetailEvent(rfid: Application.rfidTest));
                          } else if (items.length == 1) {
                            _returnItemBloc.add(ReturnItemDetailEvent(rfid: Application.rfidTest2));
                          }*/

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
            BlocBuilder<ReturnItemBloc, ReturnItemState>(
              builder: (context, state) {
                if (state is ReturnItemLoadingState) {
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
