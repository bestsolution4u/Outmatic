import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/routes.dart';
import 'package:outmatic/model/batch_project_model.dart';
import 'package:outmatic/model/med_model.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/widget/bar/child_page_appbar.dart';
import 'package:outmatic/widget/button/app_button.dart';
import 'package:outmatic/widget/loading/app_loading.dart';

import '../../../app_bloc.dart';

class BatchScanUPDScreen extends StatefulWidget {

  final List<TagItemDetailModel> items;

  BatchScanUPDScreen({this.items});

  @override
  _BatchScanUPDScreenState createState() => _BatchScanUPDScreenState();
}

class _BatchScanUPDScreenState extends State<BatchScanUPDScreen> {

  BatchBloc _batchBloc;
  MedModel user;
  BatchProjectModel project;

  @override
  void initState() {
    super.initState();
    _batchBloc = BlocProvider.of<BatchBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BatchBloc, BatchState>(
        listener: (context, state) {
          if (state is BatchUpdatedState) {
            Navigator.pop(context);
            /*Navigator.pushReplacementNamed(context, Routes.batchStatus,
                arguments: widget.items);*/
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
                  title: "Batch Scan Items",
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
                buildText(Text(user != null ? user.fullname : "Algemeen", style: TextStyle(color: Colors.black, fontSize: 16),)),
                SizedBox(height: 10,),
                buildText(Row(
                  children: [
                    SizedBox(width: 60,),
                    Expanded(
                      child: AppButton(
                        text: "SELECTEER MEDEWERKER",
                        fontSize: 14,
                        onPressed: () async {
                          final med = await Navigator.pushNamed(context, Routes.batchMED);
                          if (med != null) {
                            setState(() {
                              user = med;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                )),
                SizedBox(height: 20,),
                buildText(Text("Project", style: TextStyle(color: AppTheme.primaryColor, fontSize: 14),)),
                SizedBox(height: 5,),
                buildText(Text(project != null ? project.name : "Werkplaats (ProjectNr = 5005)", style: TextStyle(color: Colors.black, fontSize: 16),)),
                SizedBox(height: 10,),
                buildText(Row(
                  children: [
                    SizedBox(width: 60,),
                    Expanded(
                      child: AppButton(
                        text: "SELECTEER PROJECT",
                        fontSize: 14,
                        onPressed: () async {
                          final prd = await Navigator.pushNamed(context, Routes.batchPRD);
                          if (prd != null) {
                            setState(() {
                              project = prd;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                )),
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
                            _batchBloc.add(BatchUpdateEvent(projectID: project.projectID, uid: user.uid, nodeDetails: query));
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

  Widget buildText(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }
}
