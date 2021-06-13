import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowingToast {
  FToast fToast;
  BuildContext context;

  ShowingToast({
    this.context,
  });

  showSuccessToast(String textToBeDisplayed) {
    fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: Colors.green[900],
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            textToBeDisplayed,
            style: TextStyle(
              color: Colors.green[900],
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }
}
