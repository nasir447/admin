import 'package:Admin/Widgets/BottomNavBar.dart';
import 'package:Admin/Widgets/CategoryUpdate.dart';
import 'package:Admin/Widgets/UpdateButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Color.fromRGBO(244, 75, 89, 1)),
        elevation: 0,
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        centerTitle: true,
        title: Text(
          "Update",
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 150.0),
            CategoryUpdateButton(),
            SizedBox(height: 50.0),
            UpdateButton(),
          ]
        )
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}