import 'package:flutter/material.dart';
import 'package:outmatic/util/app_theme.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool loading;
  final bool disableTouchWhenLoading;
  final double fontSize;

  AppButton({
    Key key,
    this.onPressed,
    this.text,
    this.loading = false,
    this.disableTouchWhenLoading = false,
    this.fontSize = 18
  }) : super(key: key);

  Widget _buildLoading() {
    if (!loading) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: 20,
      height: 20,
      child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(16),
        onPressed: disableTouchWhenLoading && loading ? null : onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .button.copyWith(fontSize: fontSize),
            ),
            _buildLoading()
          ],
        ),
      ),
    );
  }
}
