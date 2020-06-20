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
  String quantity;
  String price;
  int quantity1 = 1;
  int totalPrice;

  FoodItem({this.foodID, this.foodName, this.foodDesc, this.foodimage, this.foodPrice, this.discPrice, this.catName, this.price, this.quantity});

  void fName(String name){
    this.foodName = name;
  }
  void func(){
    if (foodimage != null)
      foodbytes = Base64Decoder().convert(foodimage);
  }
  
  String isNameValid(){
    if(foodName.isEmpty){
      return "Food Name is empty";
    } else{
        return "";
    }
  }

  String isDescValid(){
    if(foodName.isEmpty){
      return "Food Description is empty";
    } else{
        return "";
    }
  }

  String isCategoryValid(){
    if(catName.isEmpty){
      return "Category Name is empty";
    } else{
        return "";
    }
  }

  String foodPriceValid(){
    try{
      int price = int.parse(foodPrice);
      return "";
    } catch(e){
      return "Price should be in digits";
    }
  }

  void incQuantity(){
    quantity1++;
    totalPrice+=int.parse(price);
  }

  String discPriceValid(){
    try{
      int price = int.parse(discPrice);
      return "";
    } catch(e){
      return "Discount should be in digits";
    }
  }

}