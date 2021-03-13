import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outmatic/config/image.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/widget/bar/default_appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String date = "", time = "";

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          time = DateFormat.jm().format(DateTime.now());
          date = DateFormat('MMMMEEEEd').format(DateTime.now());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppTheme.primaryDarkColor,
          ),
          DefaultAppBar(title: "Outmatic Materieel",),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    color: AppTheme.primaryColor,
                    child: Image.asset(Images.Logo, width: MediaQuery.of(context).size.width),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Text("Version: 1.0.0.0"),
                  SizedBox(height: 20,),
                  Text("http://82.196.13.181/"),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(width: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(time, style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.normal),),
                          SizedBox(height: 10,),
                          Text(date, style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.normal, letterSpacing: -1.5, height: 1))
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
