import 'package:Admin/Classes/Cat.dart';
import 'package:Admin/Services/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDisplay extends StatefulWidget {

  ItemCategory category;

  CategoryDisplay({this.category});

  @override
  _CategoryDisplayState createState() => _CategoryDisplayState();
}

class _CategoryDisplayState extends State<CategoryDisplay> {

  Database db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding:false,
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Color.fromRGBO(244, 75, 89, 1)),
          elevation: 0,
          backgroundColor: Color.fromRGBO(246, 246, 246, 1),
          title: Text(
            "Category",
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: <Widget>[
           
          ],
        ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30.0, 10, 10, 30.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Category ID = ${widget.category.catID}" ,
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10),
              Text(
                "Category Name = ${widget.category.catName}",
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10),
              Text(
                "Category Description = ${widget.category.catDesc}",
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 30),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                color:   Colors.red,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Icon(Icons.delete_forever)
                  ],
                ),
                onPressed: () async {
                  print(await db.deleteCategory(widget.category.catID));
                  Navigator.pushNamed(context, '/categoryList');
                }),
            ],
          ),
        ),
      )
    );
  }
}