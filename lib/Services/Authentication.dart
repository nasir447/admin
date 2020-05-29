import 'package:Admin/Classes/Cat.dart';
import 'package:Admin/Widgets/alertDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Admin/Classes/user.dart';

class Database{
  String _name;
  String _email;
  String _phone;
  String _password;
  String _url;
  String _catName;
  String _desc;
  String _catImg;
  String _foodName;
  String _foodDesc;
  String _foodimage;
  String _foodPrice;
  String _discPrice;
  int _catId;
  
  Database(){
    _name = null;
    _email = null;
    _password = null;
    _phone = null;
    _url = "https://vibrant-millions.000webhostapp.com/SignupAdmin.php";
  }
  void setDetails(String name,String email,String phone,String password){
    _name = name;
    _email = email;
    _phone=phone;
    _password=password;
  }

  Future<String> createAccount()async{
      http.Response response = await http.post(_url,
          body: {
            "name":_name,
            "email":_email,
            "password":_password,
            "phone":_phone,

          }
      );
      return response.body;
  }
  Future<String> req()async{
      http.Response response = await http.post(
          "https://vibrant-millions.000webhostapp.com/CheckAdmin.php",
          body: {
            "name":_name,
            "email":_email,
            "phone":_phone
          }
      );
      return  await response.body;
  }

  Future<String> checkCat()async{
      http.Response response = await http.post(
          "https://vibrant-millions.000webhostapp.com/CheckCat.php",
          body: {
            "name":_catName,
          }
      );
      return  await response.body;
  }

  Future<User> login(String email,String password)async{
      print(email + " " + password);
      http.Response response = await http.post(
          "https://vibrant-millions.000webhostapp.com/LoginAdmin.php",
          body: {
            "email" : email,
            "password": password,
          }
      );
      User user = User();
      if(response.body!='0') {
        user.setName(jsonDecode(response.body)['username']);
        user.setEmail(jsonDecode(response.body)['email']);
        user.matched=true;
      }
      else
        user.matched=false;
      return  await user;
  }

  Future<http.Response> getMenu(String cat_id)async{
    http.Response response = await http.post(
        "https://vibrant-millions.000webhostapp.com/getMenu.php",
      body: {
          "cat_id":cat_id
      }
    );
    return await response;
  }

  Future<http.Response> getCategory()async{
    http.Response response = await http.get(
        "https://vibrant-millions.000webhostapp.com/getCatogories.php"
    );
   return await response;
  }

  void setCategory(String name, String description, String img){
    _catName = name;
    _desc = description;
    _catImg = img;
  }

  void setFoodItem(String name, String description, String price, String discount, String cat_Name, String img){
    _catName = cat_Name;
    //print("Category Name" + cat_Name);
    _foodName = name;
    _foodDesc = description;
    _foodPrice = price;
    _discPrice = discount;
    _foodimage = img;
  }

  Future<String> createCategory()async{
      http.Response response = await http.post("https://vibrant-millions.000webhostapp.com/CatNewEntry.php",
          body: {
            "name":_catName,
            "desc":_desc,
            "img": _catImg,
          }
      );
      print(response.body);
      return response.body;
  }

  Future<String> createFood()async{
      http.Response response = await http.post("https://vibrant-millions.000webhostapp.com/createFood.php",
          body: {
            "name":_foodName,
            "desc":_foodDesc,
            "img": _foodimage,
            "price": _foodPrice,
            "discount": _discPrice,
            "cat_id": _catId.toString()
          }
      );
      print(response.body);
      return response.body;
  }

 Future<String> deleteCategory(String id)async{
      http.Response response = await http.post("https://vibrant-millions.000webhostapp.com/DeleteCategory.php",
          body: {
            "cat_id": id
          }
      );
      return response.body;
  } 

  Future<bool> getCat()async{
    //print(_catName);
    print("start getCat");
      http.Response response = await http.post(
          "https://vibrant-millions.000webhostapp.com/getCat.php",
          body: {
            "name": _catName,
          }
      );
      if(response.body == null || response.body == "null"){
        print("Category does not exist");
        print(response.body);
        return false;
      }
      else {
        var str = jsonDecode(response.body)['cat_id'];
        print(str + "*");
        _catId = int.parse(str);
        return true;
      }
      //return true;
  }
}