import 'package:Admin/Classes/Cat.dart';
import 'package:Admin/Screens/CategoryDisplay.dart';
import 'package:Admin/Services/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Category extends StatefulWidget {

  final List<ItemCategory> category;

  Category({this.category});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  Database db = Database();
  
  bool burgerClicked = false;
  bool pizzaClicked = false;
  bool pakistaniClicked = false;
  bool italianClicked = false;
  bool beveragesClicked = false;
  bool dailyDealsClicked = false;
  bool dealsClicked = false;
  
  Future<List<ItemCategory>> getCategory()async{
    http.Response response= await db.getCategory();
    var data=jsonDecode(response.body);

    List<ItemCategory> listCategory = List();
    for(var i in data){
      ItemCategory item = ItemCategory(catID: i["cat_id"], catName: i["cat_name"], catDesc: i['cat_desc']);
      listCategory.add(item);
    }
    print(listCategory.length);
    return await listCategory;
  }

  void toggle(){
      burgerClicked = false;
      pizzaClicked = false;
      pakistaniClicked = false;
      italianClicked = false;
      beveragesClicked = false;
      dailyDealsClicked = false;
      dealsClicked = false;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          toggle();
        });
      },
      child: Scaffold(
          resizeToAvoidBottomPadding:false,
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        appBar: AppBar(
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //MySearchWidget(),
              Container(
                margin: EdgeInsets.only(top: 10,left: 5),
                padding: EdgeInsets.all(5),
                height: 120,
                child: FutureBuilder(
                  future: getCategory(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                    if(snapshot.data == null) {
                      return Text("Loading");
                    }
                    if(snapshot.data !=null){
                      if(snapshot.data.length == 0)
                        return Text("No category");
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context,int index){
                          return Column(
                            children: <Widget>[
                              InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>CategoryDisplay(category: snapshot.data[index],),
                               ));
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 80,
                                      height: 80,
                                      child: Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            side: BorderSide(
                                              color: Colors.grey
                                           //   color: dailyDealsClicked?Colors.red:Colors.grey,
                                            )),
                                        child: Icon(Icons.fastfood),
                                      ),
                                    ),
                                    Text(
                                      snapshot.data[index].catName,
                                      style: TextStyle(color: Colors.black,fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                            ],
                          );
                        }
                      );
                    }
                  }
                )
              ),
              SizedBox(height: 10.0),
              Center(
                child: IconButton(icon: Icon(Icons.add), onPressed: () =>   Navigator.pushNamed(context, '/category')
                 )
              ),
              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 170,
                      width: 300,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        elevation: 6,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color.fromRGBO(245, 245, 243, 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "images/food1.png",
                              width: 150,
                              height: 150,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2.5,
                            margin: EdgeInsets.only(top: 15),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    "Grill Burger",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 22),
                                  ),
                                  subtitle: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(top: 4),
                                      child: AutoSizeText(
                                        "Potato,Cheeze,Chicken",
                                        style: TextStyle(fontSize: 19),
                                        maxLines: 4,
                                      )),

                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width/4,
                                      top: MediaQuery.of(context).size.height/45
                                  ),
                                  child: Text("RS:300",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            height: 75,
                            width:  65,
                            child: Card(
                              color: Color.fromRGBO(245, 245, 243, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              elevation: 5,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 40,
                                    color: Colors.pinkAccent,
                                  ),
                                  onPressed: null
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 170,
                      width: 300,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        elevation: 6,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color.fromRGBO(245, 245, 243, 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "images/food1.png",
                              width: 150,
                              height: 150,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2.5,
                            margin: EdgeInsets.only(top: 15),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    "Grill Burger",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 22),
                                  ),
                                  subtitle: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(top: 4),
                                      child: AutoSizeText(
                                        "Potato,Cheeze,Chicken",
                                        style: TextStyle(fontSize: 19),
                                        maxLines: 4,
                                      )),

                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width/4,
                                      top: MediaQuery.of(context).size.height/45
                                  ),
                                  child: Text("RS:300",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            height: 75,
                            width:  65,
                            child: Card(
                              color: Color.fromRGBO(245, 245, 243, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              elevation: 5,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 40,
                                    color: Colors.pinkAccent,
                                  ),
                                  onPressed: null
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 170,
                      width: 300,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        elevation: 6,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color.fromRGBO(245, 245, 243, 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "images/food1.png",
                              width: 150,
                              height: 150,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2.5,
                            margin: EdgeInsets.only(top: 15),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    "Grill Burger",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 22),
                                  ),
                                  subtitle: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(top: 4),
                                      child: AutoSizeText(
                                        "Potato,Cheeze,Chicken",
                                        style: TextStyle(fontSize: 19),
                                        maxLines: 4,
                                      )),

                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width/4,
                                      top: MediaQuery.of(context).size.height/45
                                  ),
                                  child: Text("RS:300",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            height: 75,
                            width:  65,
                            child: Card(
                              color: Color.fromRGBO(245, 245, 243, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              elevation: 5,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 40,
                                    color: Colors.pinkAccent,
                                  ),
                                  onPressed: null
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 170,
                      width: 300,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        elevation: 6,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color.fromRGBO(245, 245, 243, 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "images/food1.png",
                              width: 150,
                              height: 150,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2.5,
                            margin: EdgeInsets.only(top: 15),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    "Grill Burger",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 22),
                                  ),
                                  subtitle: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(top: 4),
                                      child: AutoSizeText(
                                        "Potato,Cheeze,Chicken",
                                        style: TextStyle(fontSize: 19),
                                        maxLines: 4,
                                      )),

                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width/4,
                                      top: MediaQuery.of(context).size.height/45
                                  ),
                                  child: Text("RS:300",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            height: 75,
                            width:  65,
                            child: Card(
                              color: Color.fromRGBO(245, 245, 243, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              elevation: 5,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 40,
                                    color: Colors.pinkAccent,
                                  ),
                                  onPressed: null
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
class MyCart extends StatelessWidget {
  const MyCart({
    Key key,
    @required this.itemCount,
  }) : super(key: key);

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side:
            BorderSide(width: 8, color: Color.fromRGBO(245, 215, 218, 1))),
        color: Color.fromRGBO(244, 75, 89, 1),
        child: Center(
          child: Text(
            "$itemCount",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

