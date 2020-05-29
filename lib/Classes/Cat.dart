import 'dart:convert';

class ItemCategory{
  String catID;
  String catName;
  String catDesc;
  bool matched = false;
  String image;
  List<int> bytes;
  bool isClicked = false;

  ItemCategory({this.catID, this.catName, this.catDesc, this.image});

  void func(){
    if (image != null)
      bytes = Base64Decoder().convert(image);
  }
  /*bool isCatNaneValid(){
     if(!(catName.isEmpty()) == true)
      return true;
     return false;
   }*/

   factory ItemCategory.fromJson(Map <String, dynamic> json){
     return ItemCategory(
       catID: json['cat_id'] as String,
       catName: json['cat_name'] as String,
       catDesc: json['cat_desc'] as String
     );
   }
}
