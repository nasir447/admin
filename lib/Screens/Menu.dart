import 'package:Admin/Classes/FoodItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  List<FoodItem> items = [
    FoodItem(itemName: "Zinger Burger", itemDescription: "Chrispy chicken fillet with special Bar B Q Sause"),
    FoodItem(itemName: "Chicken Grilled Burger", itemDescription: "Grilled chicken fillet with Fries"),
    FoodItem(itemName: "Beef Burger", itemDescription: "Quarter Pounder with special Mustard Sause")
  ];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Color.fromRGBO(244, 75, 89, 1)),
        elevation: 0,
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        centerTitle: true,
        title: Text(
          "Menu",
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        brightness: Brightness.light,
      ),
      body: getAddressListview(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //Navigator.pushNamed(context, '/maps');
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.black,
      )
    );
  }

  ListView getAddressListview(){

    return(ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, index){
        return Card(
          color: Colors.grey[200],
          elevation: 2.0,
          child: ListTile(
          title: Text(items[index].itemName),
          subtitle: Text(items[index].itemDescription),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                setState(() {
                  items.removeAt(index);
                });
              },
            ),
          ),
        );
      }
    ));
  }
}
