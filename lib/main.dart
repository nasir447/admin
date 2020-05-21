import 'package:Admin/Screens/Category.dart';
import 'package:Admin/Screens/CategoryDisplay.dart';
import 'package:Admin/Screens/CategoryForms.dart';
import 'package:Admin/Screens/Home.dart';
import 'package:Admin/Screens/Menu.dart';
import 'package:Admin/Screens/SignIn.dart';
import 'package:Admin/Screens/Signup.dart';
import 'package:Admin/Screens/Update.dart';
import 'package:Admin/Screens/authenticate.dart';
import 'package:Admin/Screens/img.dart';
import 'package:flutter/material.dart';

void main() => runApp(Admin());

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: {
        '/home': (context) => Home(),
        '/menu': (context) => Menu(),
        '/update': (context) => Update(),
        '/categoryList': (context) => Category(),
        '/login': (context) => Login(),
        '/category': (context) => CategoryForm(),
        '/categoryDisplay': (context) => CategoryDisplay(),
      },
    );
  }
}