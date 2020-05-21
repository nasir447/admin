import 'package:flutter/material.dart';
import 'package:Admin/Services/Authentication.dart';
import 'package:Admin/Classes/Cat.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Admin/Widgets/alertDialog.dart';
import 'package:Admin/Screens/Category.dart';
import 'dart:convert';
import 'dart:io';
import 'package:Admin/Screens/pr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class CategoryForm extends StatefulWidget {
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {

  File uploadimage;

  Future<void> chooseImage() async {
        var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
            uploadimage = choosedimage;
        });
  }

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

  Database db = Database();
  ItemCategory item = ItemCategory();
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: new IconThemeData(color:Colors.white,),
        backgroundColor:  Colors.white,
        centerTitle: true,
        title: Text(
          "Add A New Category",
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: <Widget>[

        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 0, bottom: 0,left: 15),
                    child: Text(
                      "Add A Category",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50,color: Colors.white),
                    ),
                  ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 30),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (name){
                          //user.setEmail(email);
                          item.catName = name;
                        },
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink
                                )
                            ),
                            labelText: "Category Name",
                            //errorText: item.isCatNaneValid() ? "" : "Invalid username",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      SizedBox(height:20.0),
                      TextField(
                        onChanged: (desc){
                          //item.ssetPassword(Password);
                          item.catDesc = desc;
                        },
                        decoration: InputDecoration(
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
                      uploadimage == null ? InkWell(
                        onTap: (){
                          chooseImage();
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
                        List<int> imageBytes = uploadimage.readAsBytesSync();
                        String baseimage = base64Encode(imageBytes);
                        item.image = baseimage;
                        print(baseimage);
                         db.setCategory(item.catName, item.catDesc, item.image);
                         setState(() {
                           spinner = false;
                         });
                        
                         String result = await db.checkCat();
                          if(result !="0"){
                            setState(() {
                              spinner=false;
                            });
                            if(result=="1")
                              showAlertDialog(context,"Category Already Exist");
                          }
                          else if(result == "0"){ 
                             setState(() {
                               spinner=false;
                             });
                             dynamic print = await db.createCategory();
                             showAlertDialog(context, print);
                             Navigator.pushReplacement(
                               context,
                               MaterialPageRoute(
                                 builder: (context) =>(Category())
                               ));
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