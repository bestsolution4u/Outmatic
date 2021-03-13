import 'package:flutter/material.dart';
import 'package:outmatic/config/image.dart';
import 'package:outmatic/config/preference_param.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/util/preference_helper.dart';
import 'package:outmatic/widget/bar/default_appbar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool isEnabled;

  @override
  void initState() {
    super.initState();
    isEnabled = PreferenceHelper.getBool(PreferenceParam.noNFC, false);
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
          DefaultAppBar(title: "Settings",),
          SizedBox(height: 40,),
          Image.asset(Images.Logo, width: MediaQuery.of(context).size.width),
          SizedBox(height: 40,),
          Container(
            width: double.infinity,
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            color: Colors.black,
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("NFC not supported", style: TextStyle(fontSize: 16, color: Colors.black),),
              SizedBox(width: 40,),
              Switch(
                value: isEnabled,
                onChanged: (value) {
                  setState(() {
                    isEnabled = value;
                    PreferenceHelper.setBool(PreferenceParam.noNFC, value);
                  });
                },
                activeTrackColor: AppTheme.primaryColor,
                activeColor: AppTheme.primaryDarkColor,
              )
            ],
          ),
          SizedBox(height: 30,),
          Container(
            width: double.infinity,
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
