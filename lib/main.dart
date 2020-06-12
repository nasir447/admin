import 'package:Admin/Screens/Category.dart';
import 'package:Admin/Screens/CategoryDisplay.dart';
import 'package:Admin/Screens/CategoryForms.dart';
import 'package:Admin/Screens/FoodForm.dart';
import 'package:Admin/Screens/Home.dart';
import 'package:Admin/Screens/Order.dart';
import 'package:Admin/Screens/SignIn.dart';
import 'package:Admin/Screens/authenticate.dart';
import 'package:flutter/material.dart';

void main() => runApp(Admin());

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Order(),
      routes: {
        '/home': (context) => Home(),
        '/foodform': (context) => FoodForm(),
        '/categoryList': (context) => Category(),
        '/login': (context) => Login(),
        '/category': (context) => CategoryForm(),
        '/categoryDisplay': (context) => CategoryDisplay(),
      },
    );
  }
}