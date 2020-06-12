import 'package:Admin/Classes/Customer.dart';
import 'package:Admin/Classes/OrderClass.dart';
import 'FoodItem.dart';

class OrderDisplayClass{
  OrderClass orderclass;
  Future<List> food;
  Customer customer;
  OrderDisplayClass({this.customer, this.food, this.orderclass});
}