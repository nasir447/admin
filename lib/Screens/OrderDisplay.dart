import 'package:Admin/Classes/Customer.dart';
import 'package:Admin/Classes/OrderClass.dart';
import 'package:Admin/Widgets/alertDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:Admin/Classes/FoodItem.dart';
import 'package:Admin/Services/Authentication.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OrderDisplay extends StatefulWidget {

  Customer customer;
  OrderClass order;
  double price;

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
    widget.price = double.parse(widget.order.bill);
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
              decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color.fromRGBO(245, 245, 243, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 3.0,
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
              padding: EdgeInsets.all(10.0),
              child:  ListTile(
                title: AutoSizeText("Order Details", style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: AutoSizeText("Customer Name:     \t${widget.customer.username}\nOrder Number:         \t${widget.order.orderID}\nDelivery Address:    \t${widget.order.address}"),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(color: Colors.pink),
            SizedBox(height: 10.0),
            FutureBuilder(
                future: foodItem = getMenu(widget.order.orderID),
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
                                //height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                  //color: Colors.black,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: AutoSizeText(snapshot.data[index].quantity + "x\t" +  snapshot.data[index].foodName),
                                  trailing: AutoSizeText("Rs. " + snapshot.data[index].price),
                                ),
                              ),
                              Divider(color: Colors.red,)
                            ],
                          );
                        });
                  }
                }
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(8.0),
              child: foodItem == null ? Container() : Column(
                children: <Widget>[
                  ListTile(
                    title: AutoSizeText(
                      "Subtotal\nDelivery Fee"
                    ),
                    trailing: AutoSizeText("${widget.price}\n0"),
                  ),
                  Divider(color: Colors.pink,),
                  ListTile(
                    title: AutoSizeText(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: AutoSizeText("${widget.price}"),
                  )
                ],
              ),
            ),
            widget.order.status == "pending" ? Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: 60,
                  child: RaisedButton(
                    onPressed: () async {
                      var result = await db.statusAccept(widget.order.orderID);
                      print(result);
                      if(result == "Server Error!"){
                        showAlertDialog(context, result);
                      }
                      Navigator.pop(context);
                    },
                    color: Colors.green,
                    child: Text(
                      "Accept",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0,),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: 60,
                  child: RaisedButton(
                    onPressed: () async {
                      var result = await db.statusReject(widget.order.orderID);
                      print(result);
                      if(result == "Server Error!"){
                        showAlertDialog(context, result);
                      }
                      Navigator.pop(context);
                    },
                    color: Colors.red,
                    child: Text(
                      "Reject",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ) : Container()
          ]
        )
      ),
    );
  }
}