import 'package:Admin/Widgets/AddCatButton.dart';
import 'package:Admin/Widgets/AddFoodButton.dart';
import 'package:Admin/Widgets/BottomNavBar.dart';
import 'package:Admin/Widgets/MenuButton.dart';
import 'package:Admin/Widgets/OrderButton.dart';
import 'package:Admin/Widgets/RiderButton.dart';
import 'package:Admin/Widgets/Update.dart';
import 'package:Admin/Widgets/manageOrderButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Admin/Classes/user.dart';
class Home extends StatefulWidget {

  User user = User();
    Home({this.user});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          "Admin Dashbord",
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
        ],
      ),
      drawer: Drawer(

        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(widget.user.getName(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                accountEmail: Text(widget.user.getEmail(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 75, 89, 1)
                ),
              ),
              
              ListTile(
                onTap: () async{
                  //logoutAlertDialog(context);
                },
                trailing: Icon(Icons.cancel, color: Colors.red,),
                title: Text("Logout"),
              ),
            ],
          ),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 75, 89, 1)
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 120.0),
              MenuButton(),
              SizedBox(height: 30.0),
              AddCategory(),
              SizedBox(height: 30.0),
              AddFoodButton(),
              SizedBox(height: 30.0),
              ManageOrderButton(),
            ],
          )
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(),
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

