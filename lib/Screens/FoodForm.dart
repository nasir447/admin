import 'package:Admin/Classes/FoodItem.dart';
import 'package:flutter/material.dart';
import 'package:Admin/Services/Authentication.dart';
import 'package:Admin/Classes/Cat.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Admin/Widgets/alertDialog.dart';
import 'package:Admin/Screens/Category.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class FoodForm extends StatefulWidget {
  @override
  _FoodFormState createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {

  File uploadimage;
  List<int> imageBytes;
  String error1, error2, error3, error4, error5;

  Future<void> chooseImage() async {
      var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
          uploadimage = choosedimage;
      });
      imageBytes = uploadimage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      item.foodimage = baseimage;
      if (item.foodimage.length > 8000000){
        showAlertDialog(context, "Image is too Large. Choose Another.");
        uploadimage = null;
        item.foodimage = null;
      }
  }

  /*Future<List<FoodItem>> getCategory()async{
    http.Response response= await db.getCategory();
    var data=jsonDecode(response.body);

    List<FoodItem> menu = List();

    for(var i in data){
      FoodItem item = FoodItem(foodID: i["food_id"], foodName: i["food_name"], foodDesc: i['food_desc']);
      item.func();
      menu.add(item);
    }
    print(menu.length);
    return await menu;
  }*/

  Database db = Database();
  FoodItem item = FoodItem();
  bool spinner = false;
  final _key =GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: new IconThemeData(color:Colors.white,),
        backgroundColor:  Colors.white,
        centerTitle: true,
        title: Text(
          "Add A New food Item",
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: <Widget>[

        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            //height: MediaQuery.of(context).size.height * 2,
            //width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 0, bottom: 0,left: 15),
                    child: Text(
                      "Add A Food Item",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50,color: Colors.black),
                    ),
                  ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 30),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (name){
                          //user.setEmail(email);
                          item.foodName = name;
                          var error = item.isNameValid();
                          setState(() {
                            error1 = error;
                          });
                        },
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink
                                )
                            ),
                            labelText: "Food Item Name",
                            errorText: error1,
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      SizedBox(height:20.0),
                      TextFormField(
                        onChanged: (desc){
                          //item.ssetPassword(Password);
                          item.foodDesc = desc;
                          var error = item.isDescValid();
                          setState(() {
                            error2 = error;
                          });
                        },
                        decoration: InputDecoration(
                          errorText: error2,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink
                                )
                            ),
                            labelText: "Discription",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      SizedBox(height:20.0),
                      TextFormField(
                        onChanged: (foodPrice){
                          //item.ssetPassword(Password);
                          item.foodPrice = foodPrice;
                          var error = item.foodPriceValid();
                          setState(() {
                            error3 = error;
                          });
                        },
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink
                                )
                            ),
                            labelText: "Food Price",
                            errorText: error3,
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      SizedBox(height:20.0),
                      TextField(
                        onChanged: (discPrice){
                          //item.ssetPassword(Password);
                          item.discPrice = discPrice;
                          var error = item.discPriceValid();
                          setState(() {
                            error4 = error;
                          });
                        },
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink
                                )
                            ),
                            labelText: "Discount",
                            errorText: error4,
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      SizedBox(height:20.0),
                      TextField(
                        onChanged: (catName){
                          //item.ssetPassword(Password);
                          item.catName = catName;
                          var error = item.isCategoryValid();
                          setState(() {
                            error5 = error;
                          });
                        },
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink
                                )
                            ),
                            labelText: "Category Name",
                            errorText: error5,
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      SizedBox(height:20.0),
                      uploadimage == null ? InkWell(
                        onTap: (){
                          chooseImage();
                        },
                        child: Container(
                          //margin: EdgeInsets.only(top: 80),
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
                                  "CHOOSE IMAGE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                )
                            ),
                          ),
                        ),
                      ) : Container(  //show image here after choosing image
                            child:uploadimage == null? 
                               Container(): //if uploadimage is null then show empty container
                               Container(   //elese show image here
                                  child: SizedBox( 
                                     height:150,
                                     child:Image.file(uploadimage) //load image from file
                                  )
                               )
                        ),
                      InkWell(
                        onTap: ()async{
                          setState(() {
                            spinner = true;
                          });
                         db.setFoodItem(item.foodName, item.foodDesc, item.foodPrice, item.discPrice, item.catName, item.foodimage);
                         setState(() {
                           spinner = false;
                         });
                        
                         var result = await db.getCat();
                          if(result ==false){
                            setState(() {
                              spinner=false;
                            });
                            await showAlertDialog(context,"Category Doesent Exist");
                            /*Navigator.pushReplacement(
                               context,
                               MaterialPageRoute(
                                 builder: (context) =>(Category())
                               ));*/
                            //Navigator.pop(context);

                          }
                          else if(result == true){ 
                             setState(() {
                               spinner=false;
                             });
                             String print = await db.createFood();
                             //showAlertDialog(context, print);
                             Navigator.pushReplacement(
                               context,
                               MaterialPageRoute(
                                 builder: (context) =>(Category())
                               ));
                            }
                        },
                        child: uploadimage == null || item.foodName == "" || item.foodDesc == "" || item.foodPrice == "" || item.discPrice == "" || item.catName == ""? Container()
                        : Container(
                          
                          margin: EdgeInsets.only(top: 80),
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            color:   Color.fromRGBO(244, 75, 89, 1),
                            //margin: EdgeInsets.only(top: 20),
                            child: Center(
                                child: Text(
                                  "ADD",
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