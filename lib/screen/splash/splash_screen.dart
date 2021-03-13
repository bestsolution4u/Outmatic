import 'package:flutter/material.dart';
import 'package:outmatic/config/image.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.Background, width: double.infinity, height: double.infinity, fit: BoxFit.cover,),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Images.Logo, width: width * 2 / 3),
                SizedBox(height: 40,),
                Text('Verbinding maken...', style: Theme.of(context).textTheme.bodyText2,),
                SizedBox(height: 20,),
                SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(strokeWidth: 3, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}