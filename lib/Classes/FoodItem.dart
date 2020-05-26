import 'dart:convert';

class FoodItem{
  String foodID;
  String foodName;
  String foodDesc;
  String foodimage;
  String foodPrice;
  String discPrice;
  List<int> foodbytes;
  String catName;

  FoodItem({this.foodID, this.foodName, this.foodDesc, this.foodimage, this.foodPrice, this.discPrice});

  void fName(String name){
    this.foodName = name;
  }
  void func(){
    if (foodimage != null)
      foodbytes = Base64Decoder().convert(foodimage);
  }

}