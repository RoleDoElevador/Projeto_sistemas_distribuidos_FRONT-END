import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class LoadingDialog {
    void showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: new Container(
            padding: const EdgeInsets.all(8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[ new CircularProgressIndicator()],
            ),
          ),
        ));
  }

  void dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}

