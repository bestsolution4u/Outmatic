import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_theme.dart';

enum ToastType {SUCCESS, ERROR, INFO}

class ToastUtils {
  static int toastDuration = 2;

  static void showSuccessToast(BuildContext context, String msg) {
    FlutterToast(context).showToast(child: _getToastWidget(msg, ToastType.SUCCESS), gravity: ToastGravity.BOTTOM);
  }

  static void showErrorToast(BuildContext context, String msg) {
    FlutterToast(context).showToast(child: _getToastWidget(msg, ToastType.ERROR), gravity: ToastGravity.BOTTOM);
  }

  static void showInfoToast(BuildContext context, String msg) {
    FlutterToast(context).showToast(child: _getToastWidget(msg, ToastType.INFO), gravity: ToastGravity.BOTTOM);
  }

  static Widget _getToastWidget(String msg, ToastType type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(type == ToastType.SUCCESS ? Icons.check : type == ToastType.ERROR ? Icons.error_outline : Icons.info, color: AppTheme.primaryColor),
          SizedBox(
            width: 12.0,
          ),
          Text(msg, style: TextStyle(color: AppTheme.primaryColor)),
        ],
      ),
    );
  }
}