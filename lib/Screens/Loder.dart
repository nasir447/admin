import 'package:flutter/material.dart';
import 'package:Admin/Screens/authenticate.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    callAuth();
    super.initState();
  }

  callAuth()async{
    await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>Authentication()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Image.asset("images/logo.jpeg"),
      ),
    );
  }
}
