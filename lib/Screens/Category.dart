import 'dart:io';

import 'package:Admin/Classes/Cat.dart';
import 'package:Admin/Classes/FoodItem.dart';
import 'package:Admin/Screens/CategoryDisplay.dart';
import 'package:Admin/Screens/foodPage.dart';
import 'package:Admin/Services/Authentication.dart';
import 'package:Admin/Widgets/alertDialog.dart';
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
  Future<List> category;
  Future<List> menu;
  bool isCategoryLoaded=false;
  String selectedMenu;
  String selectedCategory;
  List<FoodItem> cart = List();

  @override
  initState(){
    category = getCategory();
    buildFood();
    super.initState();
  }

  void buildFood(){
      menu = getMenu();
  }

  void rebuild(){
    category = getCategory();
    menu = getMenu();
  }

  void addInCart(FoodItem food){
      int flag = 0;
      if(cart.length== 0 || cart==null){
        cart.add(food);
      }
      else{
        for(FoodItem i in cart){
          if(i.foodName == food.foodName) {
            i.incQuantity();
            flag=1;
          }
        }
        if(flag==0)
        cart.add(food);
      }
  }

  Future<List> getMenu() async {
    var response = await db.getMenu(selectedMenu);
    var data = jsonDecode(response.body);
    List<FoodItem> listFood = List();
    for (var i in data) {
      FoodItem food = FoodItem(foodID: i["f_id"], foodName: i["f_name"], foodDesc: i["ingredients"], foodimage: i["f_img"], foodPrice: i["f_price"], discPrice: i["d_price"]);
      print(food.foodName);
      food.func();
      listFood.add(food);
    }
    return listFood;
  }


  
  bool burgerClicked = false;
  bool pizzaClicked = false;
  bool pakistaniClicked = false;
  bool italianClicked = false;
  bool beveragesClicked = false;
  bool dailyDealsClicked = false;
  bool dealsClicked = false;
  
  Future<List<ItemCategory>> getCategory()async{
    http.Response response = await db.getCategory();
    var data = jsonDecode(response.body);
    print(data);
    List<ItemCategory> listCategory = List();
    for(var i in data){
      ItemCategory item = ItemCategory(catID: i["cat_id"], catName: i["cat_name"], catDesc: i['cat_desc'], image: i['cat_img']);
      item.func();
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
    return Scaffold(
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
           IconButton(icon: Icon(Icons.search,size: 30,), onPressed: (){
               //addInCart();
               showSearch(context: context, delegate: DataSearch(menu));
            }),
          ],
        ),
        body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
              rebuild();
          });
          await Future.delayed(Duration(seconds: 2));

        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //MySearchWidget(),
              Container(
                margin: EdgeInsets.only(top: 10,left: 5),
                padding: EdgeInsets.all(5),
                height: 120,
                child: FutureBuilder<List>(
                      future: category,
                      builder: (BuildContext context,
                          AsyncSnapshot<List> snapshot) {
                        if(!snapshot.hasData)
                          return Text("Loading....");
                           if(snapshot.hasData){
                              if(snapshot.data.length==0)
                                return Text("No Category");
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          if(selectedMenu==snapshot.data[index].catID)
                                            return;
                                          selectedMenu = snapshot.data[index].catID;
                                          print(selectedMenu);
                                          snapshot.data[index].isClicked = true;
                                          for (int i = 0; i < snapshot.data.length; ++i) {
                                            if (i == index)
                                              continue;
                                            snapshot.data[i].isClicked = false;
                                          }
                                          setState(() {
                                              buildFood();
                                          });
                                        },
                                        onLongPress: (){
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>(CategoryDisplay(category: snapshot.data[index],))
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
                                                    borderRadius: BorderRadius
                                                        .circular(50),
                                                    side: BorderSide(
                                                      color: snapshot
                                                          .data[index].isClicked
                                                          ? Colors.red
                                                          : Colors.grey,
                                                    )),
                                                  child: Container(
                                                    width:50,
                                                    height:50,
                                                    margin:EdgeInsets.only(top: 5),
                                                    child:  ListTile(
                                                      title: Image.memory(snapshot.data[index].bytes,)
                                                      ),
                                                    )
                                              ),
                                            ),
                                            Text(
                                              snapshot.data[index].catName,
                                              style: TextStyle(
                                                  color: snapshot.data[index]
                                                      .isClicked
                                                      ? Colors.red
                                                      : Colors.black,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                    ],
                                  ),
                                );
                              }
                          );
                        }
                      }
                  )
              ),
              FutureBuilder<List>(
                  future: menu,
                  builder: (BuildContext context,
                      AsyncSnapshot<List> snapshot) {
                    print(snapshot.hasData);
                    if(selectedMenu=="")
                      return Text("Select the category");
                    if(snapshot.hasData && snapshot.connectionState==ConnectionState.waiting)
                      return Text("Loading...");
                    if(!snapshot.hasData && snapshot.connectionState==ConnectionState.done)
                      return Text("No product!");
                    if(!snapshot.hasData)
                      return Text("Loading.....");
                    if(snapshot.hasData){
                      return Container(
                        height: snapshot.data.length.toDouble() * 200,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          addAutomaticKeepAlives: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          height: 170,
                                          width: MediaQuery.of(context).size.width/1.5,
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
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(top: 10, left: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  color: Color.fromRGBO(245, 245, 243, 1),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      offset: Offset(0.0, 1.0),
                                                      blurRadius: 3.0,
                                                    ),
                                                  ],
                                                ),
                                                child: Image.memory(snapshot.data[index].foodbytes,),
                                                  width: MediaQuery.of(context).size.width/3,
                                                  height: 150,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                margin: EdgeInsets.only(top: 15),
                                                child: Column(
                                                  children: <Widget>[
                                                    ListTile(
                                                      title: AutoSizeText(snapshot.data[index].foodName,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 22
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                      subtitle: Container(
                                                          width: MediaQuery.of(context).size.width,
                                                          margin: EdgeInsets.only(top: 4),
                                                          child: AutoSizeText(
                                                            snapshot.data[index].foodDesc,
                                                            style: TextStyle(
                                                                fontSize: 19
                                                            ),
                                                            maxLines: 3,
                                                          )
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.width / 5, top: MediaQuery.of(context).size.height / 45
                                                      ),
                                                      child: Text(
                                                        "Rs "+snapshot.data[index].foodPrice,
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
                                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/70),
                                                height: 75,
                                                width: MediaQuery.of(context).size.width/8,
                                                child: Card(
                                                  color: Color.fromRGBO(245, 245, 243, 1),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  elevation: 5,
                                                  child: IconButton(
                                                      icon: Icon(
                                                        Icons.delete_sweep,
                                                        size: 25,
                                                        color: Colors.pinkAccent,),
                                                      onPressed: ()async{
                                                        var result = await db.deleteFood(snapshot.data[index].foodID);
                                                        result == "0" ? showAlertDialog(context, "Food could not be deleted.")
                                                        : sucessDialog(context, "Food Deleted Succesfully");
                                                      }
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
                              );
                            }
                        ),
                      );
                    }
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate {
//  bool flag = false;
  List<FoodItem> searchMenu = List();
  Future<List> searchMenu1;
  Database db = Database();

  Future<List<String>> getSearchMenu() async {
    String str = await db.getMenuForSearch();
    var data = jsonDecode(str);
    int index = 0;
    List<String> searchMenu1 = List();
    for (var i in data) {
      FoodItem food = FoodItem(foodName: i["f_name"], foodDesc: i["ingredients"], foodPrice: i['f_price'], foodimage: i["f_img"]);
      searchMenu1.add(food.foodName+index.toString());
      food.foodID=i["f_id"];
      food.func();
      searchMenu.add(food);
      index++;
    }

  return searchMenu1;
  }
  Future<List> cart;
  DataSearch(Future<List> cart){
    this.cart=cart;
    searchMenu1 = getSearchMenu();
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(icon: Icon(Icons.clear,color: Colors.red,),onPressed: (){
        query="";
      },)
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(icon: Icon(Icons.arrow_back,color: Colors.red,),onPressed: (){
      close(context, null);
    },)
    ;
  }
  @override
  Widget buildResults(BuildContext context) {
    return null;
  }
//    return Container(
//      child: Text(len),
//    );
//  }
//  @override
//  Widget buildSuggestions(BuildContext context) {
//      return FutureBuilder(
//        future: searchMenu1,
//          builder: (context, snapshot){
//              if(!snapshot.data)
//                return CircularProgressIndicator();
//              for(var i in snapshot.data){
//                print(i);
//              }
//               if(snapshot.data){
//                if(query.isEmpty)
//                  return Center(child: Text("Food is waiting"),);
//                  return Center(child: Text("Loaded is waiting"),);
//

              //}
//          },
//      );
//
//
//  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggest1=List();
    List<String> suggestFood = List();
    int myIndex;
    return FutureBuilder(
      future: searchMenu1,
        builder: (context,snapshot){
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          if(snapshot.hasData) {
            suggestFood = snapshot.data;
            suggest1= suggestFood.where((name)=>name.startsWith(query)).toList();
            if (query.isEmpty)
              return Center(child: Text("Search Food"),);
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    FoodPage(food: searchMenu[myIndex], cart: cart,)));
              },
              child: ListView.builder(itemBuilder: (context, index) {

                print("hello:"+snapshot.connectionState.toString());
                myIndex = int.parse(suggest1[index].substring(
                    suggest1[index].length - 1, suggest1[index].length));
                return ListTile(
                  title: Text(suggest1[index]),
                  leading: Container(width: 80,
                      child: Image.memory(searchMenu[myIndex].foodbytes)),
                  subtitle: Text("Rs" + searchMenu[myIndex].price),
                );
              },
                itemCount: suggest1.length,
              ),
            );
          }
    });
  }
}

