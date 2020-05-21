import 'package:Admin/Services/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:Admin/Classes/user.dart';
import 'package:Admin/Widgets/alertDialog.dart';
import 'package:Admin/Screens/Home.dart';

class Login extends StatefulWidget {

  final Function toggleView;
  Login({ this.toggleView });


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Database db = Database();
  User user = User();
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: new IconThemeData(color:Colors.white,),
        backgroundColor:  Color.fromRGBO(244, 75, 89, 0.9),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Regester'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipPath(
                      child: Container(
                        color:  Color.fromRGBO(244, 75, 89, 0.7),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                      ),
                      clipper: WaveClipperOne(flip: true),
                    ),
                    ClipPath(
                      child: Container(
                        color:  Color.fromRGBO(244, 75, 89, 0.7),
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                      ),
                      clipper: WaveClipperOne(flip: true),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 0, bottom: 0,left: 15),
                      child: Text(
                        "Login",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50,color: Colors.white),
                      ),
                    ),

                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 30),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (email){
                          user.setEmail(email);
                        },
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink
                                )
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),


                      TextField(
                        onChanged: (Password){
                          user.ssetPassword(Password);
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink
                                )
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      InkWell(
                        onTap: ()async{
                          setState(() {
                            spinner = true;
                          });
                         User currentUser =   await db.login(user.getEmail(), user.getPassword());
                         setState(() {
                           spinner = false;
                         });

                         if(currentUser.matched==true){
                           Navigator.popUntil(context, ModalRoute.withName('/'));
                           Navigator.pushReplacement(
                               context,
                               MaterialPageRoute(
                                 builder: (context) =>Home(user: currentUser,),
                               ));
                         }
                         else{
                           spinner=false;
                           showAlertDialog(context,"Invalid credentials");
                         }

                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 80),
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            color:   Color.fromRGBO(244, 75, 89, 1),
                            margin: EdgeInsets.only(top: 20),
                            child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black)
                            ),

                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "images/fb.png",
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  "Login With facebook",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                )
                              ],
                            )
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}