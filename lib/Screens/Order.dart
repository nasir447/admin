import 'dart:convert';
import 'package:Admin/Classes/Customer.dart';
import 'package:Admin/Screens/OrderDisplay.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Admin/Services/Authentication.dart';
import 'package:Admin/Classes/OrderClass.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../Widgets/alertDialog.dart';

class Order extends StatefulWidget {
  
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {

  Database db = Database();
  Future<List<OrderClass>> pending;
  Future<List<OrderClass>> accepted;
  Future<List<OrderClass>> delivered;
  Future<List<OrderClass>> cancelled;
  Customer customer;
  bool spinner = false;
 
  Future<List<OrderClass>> fillList(String status)async{
   String result =  await db.getOrder(status);
   var data = jsonDecode(result);
   List<OrderClass> temp=List();
   if(data==0)
     return temp;
   for(var i in data){
     if(i["status"] == status){
       temp.add(
           OrderClass(
             status: i["status"],
             bill: i["totalPrice"],
             date: i["date"],
             orderID: i["orderID"],
             address: i["address1"],
             customerID: i["cid1"]
           ));
     }
   }
   return temp;
  }

  void refresh(){
    pending = fillList("pending");
    accepted = fillList("on the way");
    delivered = fillList("delivered");
    cancelled = fillList("cancelled");
  }

  @override
  void initState() {
    try {
      pending = fillList("pending");
    }catch(e){
      print(e.toString());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Color.fromRGBO(244, 75, 89, 1)),
          elevation: 0,
          backgroundColor: Color.fromRGBO(246, 246, 246, 1),
          title: Text(
            "Manage Orders",
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: (){setState(() {
              refresh();
            });})
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Color.fromRGBO(244, 75, 89, 1),
              tabs: [
                Tab(
                  child: Text(
                  "Pending",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                ),
               Tab(child: Text(
                  "Accepted",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                ),
                Tab(child: Text(
                  "Delivered",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                ),
                Tab(child: Text(
                  "Cancelled",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                ),
              ],
          ),
        ),
        body: ModalProgressHUD(
            inAsyncCall: spinner,
            child: TabBarView(
            children: <Widget>[
              FutureBuilder(
                  future: pending = fillList("pending"),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    if(!snapshot.hasData)
                      return Center(child: CircularProgressIndicator(),);
                    if(snapshot.hasData){
                      if(snapshot.data.length==0)
                        return Center(child: Text("No orders yet!"));
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: () async {
                                      setState(() {
                                        spinner = true;
                                      });
                                      try{
                                        var result = await db.getCustomer(snapshot.data[index].customerID);
                                        String name = jsonDecode(result)['username'];
                                        String phone = jsonDecode(result)['phone'];
                                        customer = Customer(username: name, phone: phone);
                                      }catch(e){
                                        print(e.toString());
                                      }

                                      setState(() {
                                        spinner = false;
                                      });

                                      if(customer != null){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDisplay(order: snapshot.data[index], customer: customer,)));
                                      }
                                    },
                                    title: Text("Order# "+snapshot.data[index].orderID),
                                    subtitle: Text("Bill: "+snapshot.data[index].bill+"\nDate: "+snapshot.data[index].date+"\nCustomer ID: "+snapshot.data[index].customerID+"\nAddress:"+snapshot.data[index].address),
                                    trailing: Text("Status: \n"+snapshot.data[index].status),
                                  ),
                                ),
                                Divider(color: Colors.pink,)
                              ],
                            );
                          });
                    }
                  }
              ),
              FutureBuilder(
                  future: accepted = fillList("on the way"),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    if(!snapshot.hasData)
                      return Center(child: CircularProgressIndicator(),);
                    if(snapshot.hasData){
                      if(snapshot.data.length==0)
                        return Center(child: Text("No Past orders yet!"));
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: () async {

                                      setState(() {
                                        spinner = true;
                                      });

                                      try{
                                        var result = await db.getCustomer(snapshot.data[index].customerID);
                                        customer = Customer(username: jsonDecode(result)['username'], phone: jsonDecode(result)['phone']);
                                      }catch(e){
                                        showAlertDialog(context, "There was problem while gettin customer records");
                                      }

                                      setState(() {
                                        spinner = false;
                                      });

                                      if(customer != null ){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDisplay(order: snapshot.data[index], customer: customer,)));
                                      }
                                    },
                                    title: Text("Order#"+snapshot.data[index].orderID),
                                    subtitle: Text("Bill: "+snapshot.data[index].bill+"\nDate: "+snapshot.data[index].date+"\nCustomer ID: "+snapshot.data[index].customerID+"\nAddress:"+snapshot.data[index].address),
                                    trailing: Text("Status\n"+snapshot.data[index].status),
                                  ),
                                ),
                                Divider(color: Colors.pink,)
                              ],
                            );
                          });
                    }
                  }
              ),
              FutureBuilder(
                  future: delivered = fillList("delivered"),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    if(!snapshot.hasData)
                      return Center(child: CircularProgressIndicator(),);
                    if(snapshot.hasData){
                      if(snapshot.data.length==0)
                        return Center(child: Text("No Past orders yet!"));
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: () async {
                                      setState(() {
                                        spinner = true;
                                      });
                                      try{
                                        var result = await db.getCustomer(snapshot.data[index].customerID);
                                        customer = Customer(username: jsonDecode(result)['username'], phone: jsonDecode(result)['phone']);
                                      }catch(e){
                                        showAlertDialog(context, "There was problem while gettin customer records");
                                      }

                                      setState(() {
                                        spinner = false;
                                      });

                                      if(customer != null ){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDisplay(order: snapshot.data[index], customer: customer,)));
                                      }
                                    },
                                    title: Text("Order#"+snapshot.data[index].orderID),
                                    subtitle: Text("Bill: "+snapshot.data[index].bill+"\nDate: "+snapshot.data[index].date+"\nCustomer ID: "+snapshot.data[index].customerID+"\nAddress:"+snapshot.data[index].address),
                                    trailing: Text("Status\n"+snapshot.data[index].status),
                                  ),
                                ),
                                Divider(color: Colors.pink,)
                              ],
                            );
                          });
                    }
                  }
              ),
              FutureBuilder(
                  future: cancelled = fillList("cancelled"),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    if(!snapshot.hasData)
                      return Center(child: CircularProgressIndicator(),);
                    if(snapshot.hasData){
                      if(snapshot.data.length==0)
                        return Center(child: Text("No Past orders yet!"));
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: () async {
                                      setState(() {
                                        spinner = true;
                                      });
                                      try{
                                        var result = await db.getCustomer(snapshot.data[index].customerID);
                                        customer = Customer(username: jsonDecode(result)['username'], phone: jsonDecode(result)['phone']);
                                      }catch(e){
                                        showAlertDialog(context, "There was problem while gettin customer records");
                                      }

                                      setState(() {
                                        spinner = false;
                                      });

                                      if(customer != null ){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDisplay(order: snapshot.data[index], customer: customer,)));
                                      }
                                    },
                                    title: Text("Order#"+snapshot.data[index].orderID),
                                    subtitle: Text("Bill: "+snapshot.data[index].bill+"\nDate: "+snapshot.data[index].date+"\nCustomer ID: "+snapshot.data[index].customerID+"\nAddress:"+snapshot.data[index].address),
                                    trailing: Text("Status\n"+snapshot.data[index].status),
                                  ),
                                ),
                                Divider(color: Colors.pink,)
                              ],
                            );
                          });
                    }
                  }
              ),
            ],
          ),
        )
      ),
    );
  }
}
