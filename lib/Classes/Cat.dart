class ItemCategory{
  String catID;
  String catName;
  String catDesc;
  bool matched = false;

  ItemCategory({this.catID, this.catName, this.catDesc});

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
