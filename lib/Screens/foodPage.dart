import 'package:flutter/material.dart';
import 'package:Admin/Classes/FoodItem.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodPage extends StatefulWidget {
  FoodItem food = FoodItem();
  Future<List> cart;
  FoodPage({this.food, this.cart});
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        iconTheme: new IconThemeData(color: Color.fromRGBO(244, 75, 89, 1)),
        elevation: 0,
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        title: Text(
          "Menu",
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: <Widget>[
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.pink
                          )
                        ),
                        height: MediaQuery.of(context).size.height/3,
                        child: Card(child:Image.memory(widget.food.foodbytes)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Text(widget.food.foodName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:20.0),
                        child: Text("Rs"+widget.food.price,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Text(widget.food.foodDesc)
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}