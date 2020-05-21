import 'package:Admin/Classes/Cat.dart';
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
  int _catID;
  String _catName;
  String _desc;
  String _catImg;
  
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

  Future<String> createCategory()async{
      http.Response response = await http.post("https://vibrant-millions.000webhostapp.com/CatNewEntry.php",
          body: {
            "name":_catName,
            "desc":_desc,
            "img": "abc",
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
}