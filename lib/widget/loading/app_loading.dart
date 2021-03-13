import 'package:flutter/material.dart';

class AppLoadingDialog extends StatefulWidget {

  final String text;

  AppLoadingDialog({this.text = ""});

  @override
  _AppLoadingDialogState createState() => _AppLoadingDialogState();
}

class _AppLoadingDialogState extends State<AppLoadingDialog> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.6);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear, reverseCurve: Curves.linear);
    _controller.forward();
    _controller.repeat(reverse: true, max: 1, min: 0.6);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              alignment: Alignment.center,
              child: Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }
}

