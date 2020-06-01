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

  String discPriceValid(){
    try{
      int price = int.parse(discPrice);
      return "";
    } catch(e){
      return "Discount should be in digits";
    }
  }

}