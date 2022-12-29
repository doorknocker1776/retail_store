
import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:groceryapp/model/home_model.dart';
import 'package:groceryapp/model/cart_model.dart';

class ElectronicItems extends ChangeNotifier {
  // list of items on sale
  List _elecItems = [
    // [ itemName, itemPrice, imagePath, color ]
    ["IPhone", "42.33", "lib/images/iphone.png", Colors.orange],
    ["PS5", "9999.999", "lib/images/ps5.png", Colors.orange],
    ["PC", "9913", "lib/images/pc.png", Colors.orange],
    ["WashingMachine", "42.33", "lib/images/washingmachine.png", Colors.orange],
  ];
  get elecItems => _elecItems;

}
class FashionItems extends ChangeNotifier {
  List _fashItems = [
    // [ itemName, itemPrice, imagePath, color ]
    ["Belt", "4.99", "lib/images/belt.png", Colors.orange],
    ["Pants", "9.99", "lib/images/pants.png", Colors.orange],
    ["Jacket", "14.99", "lib/images/jacket.png", Colors.orange],
    ["Shoes", "42.33", "lib/images/shoes.png", Colors.orange],
  ];
  get fashItems => _fashItems;
}


class GroceryItems extends ChangeNotifier {
  List _groceryItems = [
    // [ itemName, itemPrice, imagePath, color ]
    ["Chicken", "4.99", "lib/images/chicken.png", Colors.orange],
    ["Banana", "9.99", "lib/images/banana.png", Colors.orange],
    ["Avocado", "14.99", "lib/images/avocado.png", Colors.orange],
    ["Water", "42.33", "lib/images/water.png", Colors.orange],
  ];

  get groceryItems => _groceryItems;
}
class NewItems extends ChangeNotifier{
List  _newItems = [
  // [ itemName, itemPrice, imagePath, color ]
  ["Car", "42.33", "lib/images/car.png", Colors.orange],
  ["EarPods", "9999.999", "lib/images/earpods.png", Colors.orange],
  ["Robot", "9913", "lib/images/robot.png", Colors.orange],
  ["NuclearWarHead", "42.33", "lib/images/nuke.png", Colors.orange],
];

get newItems => _newItems;


}