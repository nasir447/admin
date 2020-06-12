import 'package:Admin/Classes/Customer.dart';
import 'package:Admin/Classes/OrderClass.dart';
import 'package:Admin/Classes/OrderDisplayClass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:Admin/Classes/FoodItem.dart';
import 'package:Admin/Services/Authentication.dart';

class OrderDisplay extends StatefulWidget {

  Customer customer;
  OrderClass order;

  OrderDisplay({this.order, this.customer});
  
  @override
  _OrderDisplayState createState() => _OrderDisplayState();
}

class _OrderDisplayState extends State<OrderDisplay> {

  Future<List> foodItem;
  Database db = Database();

  Future<List> getMenu(String orderID) async {
    var response = await db.getFood(orderID);
    var data = jsonDecode(response);
    List<FoodItem> listFood = List();
    for (var i in data) {
      FoodItem food = FoodItem(foodID: i["f_id"], foodName: i["f_name"], foodDesc: i["ingredients"], foodPrice: i["f_price"], discPrice: i["d_price"], catName: i["d_price"], quantity: i["quantity"], price: i["price"]);
      //print(food);
      //food.func();
      listFood.add(food);
    }
    return listFood;
  }

  @override
  void initState() {
    foodItem = getMenu(widget.order.orderID);
    //accepted = fillList("on the way");
    //delivered = fillList("delivered");
    //cancelled = fillList("cancel");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Color.fromRGBO(244, 75, 89, 1)),
          elevation: 0,
          backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        title: Text(
          "Manage Order",
          style: GoogleFonts.lato(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
              padding: EdgeInsets.all(10.0),
              child:  ListTile(
                title: Text("Order Details", style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("Customer Name:\t${widget.customer.username}\nOrder Number:\t${widget.order.orderID}\nDelivery Address:\t${widget.order.address}"),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(color: Colors.pink),
            SizedBox(height: 10.0),
            FutureBuilder(
                future: foodItem,
                builder: (BuildContext context,
                    AsyncSnapshot snapshot) {
                  if(!snapshot.hasData)
                    return Center(child: CircularProgressIndicator(),);
                  if(snapshot.hasData){
                    if(snapshot.data.length==0)
                      return Center(child: Text("Empty!"));
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length==null?0:snapshot.data.length,
                        itemBuilder: (context,index){
                          return Column(
                            children: <Widget>[

                              Container(
                                height: 50,
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  subtitle: Text(snapshot.data[index].quantity + "x\t" +  snapshot.data[index].foodName),
                                  trailing: Text("Rs. " + snapshot.data[index].price),
                                ),
                              ),
                              Divider(color: Colors.pink,)
                            ],
                          );
                        });
                  }
                }
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    subtitle: Text(
                      "Subtotal\nDelivery Fee"
                    ),
                    trailing: Text("0\n0"),
                  ),
                  Divider(color: Colors.pink,),
                  ListTile(
                    title: Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text("0"),
                  )
                ],
              ),
            )
          ]
        )
      ),
    );
  }
}