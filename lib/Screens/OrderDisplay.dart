import 'package:Admin/Classes/OrderDisplayClass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDisplay extends StatefulWidget {

  OrderDisplayClass orderdisplay;

  OrderDisplay({this.orderdisplay});
  
  @override
  _OrderDisplayState createState() => _OrderDisplayState();
}

class _OrderDisplayState extends State<OrderDisplay> {
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
                subtitle: Text("Customer Name:\t${widget.orderdisplay.customer.username}\nOrder Number:\t${widget.orderdisplay.orderclass.orderID}\nDelivery Address:\t${widget.orderdisplay.orderclass.address}"),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(color: Colors.pink),
            SizedBox(height: 10.0),
            FutureBuilder(
                future: widget.orderdisplay.food,
                builder: (BuildContext context,
                    AsyncSnapshot snapshot) {
                      print(snapshot.data.length.toString()+"*");
                  if(!snapshot.hasData)
                    return Center(child: CircularProgressIndicator(),);
                  if(snapshot.hasData){
                    if(snapshot.data.length==0)
                      return Center(child: Text("Empty!"));
                    return ListView.builder(
                        itemCount: 4,
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