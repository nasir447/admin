import 'package:flutter/material.dart';
showAlertDialog(BuildContext context,String sms) {

  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Error!!"),
    content: Text("$sms"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void logoutAlertDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text("Message"),
        content:  Text("Are you sure you want to logout?"),
        actions: <Widget>[
           FlatButton(
            child:  Text("Logout"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
          FlatButton(
            child:  Text("okay"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}