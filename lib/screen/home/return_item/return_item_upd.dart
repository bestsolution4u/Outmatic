import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/routes.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/widget/bar/child_page_appbar.dart';
import 'package:outmatic/widget/button/app_button.dart';
import 'package:outmatic/widget/loading/app_loading.dart';

import '../../../app_bloc.dart';

class ReturnItemUPDScreen extends StatefulWidget {

  List<TagItemDetailModel> items;

  ReturnItemUPDScreen({this.items});

  @override
  _ReturnItemUPDScreenState createState() => _ReturnItemUPDScreenState();
}

class _ReturnItemUPDScreenState extends State<ReturnItemUPDScreen> {

  ReturnItemBloc _returnItemBloc;

  @override
  void initState() {
    super.initState();
    _returnItemBloc = BlocProvider.of<ReturnItemBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReturnItemBloc, ReturnItemState>(
        listener: (context, state) {
          if (state is ReturnItemUpdatedState) {
            Navigator.pop(context);
            /*Navigator.pushReplacementNamed(context, Routes.returnStatus,
                arguments: state.items);*/
          } else if (state is ReturnItemErrorState) {
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
                  title: "Return Items",
                  onBack: () => Navigator.pop(context),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Return Items", style: TextStyle(fontSize: 18),)
                  ],
                ),
                SizedBox(height: 30,),
                buildText(Text("Medewerker", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),)),
                SizedBox(height: 5,),
                buildText(Text("Algemeen", style: TextStyle(color: Colors.black, fontSize: 16),)),
                SizedBox(height: 20,),
                buildText(Text("Project", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),)),
                SizedBox(height: 5,),
                buildText(Text("Werkplaats", style: TextStyle(color: Colors.black, fontSize: 16),)),
                SizedBox(height: 20,),
                buildText(Text("Datum", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),)),
                SizedBox(height: 5,),
                buildText(Text(DateFormat('yyyy-MM-dd').format(DateTime.now()), style: TextStyle(color: Colors.black, fontSize: 16),)),
                Expanded(
                  child: Container(),
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
                            String query = "";
                            widget.items.forEach((element) {
                              if (query.isNotEmpty) {
                                query += ",";
                              }
                              query += element.nummer;
                            });
                            _returnItemBloc.add(ReturnItemUpdateEvent(nodeTitle: query));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: AppButton(
                          text: "HERSTEL",
                          fontSize: 14,
                          onPressed: () => Navigator.pop(context),
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

  Widget buildText(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }
}
