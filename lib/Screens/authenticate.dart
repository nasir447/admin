import 'package:flutter/material.dart';
import 'package:Admin/Screens/SignIn.dart';
import 'package:Admin/Screens/Signup.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(toggleView:  toggleView);
    } else {
      return SignUp(toggleView:  toggleView);
    }
  }
}