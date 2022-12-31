import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:groceryapp/model/home_model.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ElectronicItems extends ChangeNotifier {
  // list of items on sale
  List _ElecItems = [];

  // list of items on sale

  List _elecItems = [
    ["IPhone", "99999", "lib/images/iphone.png", Colors.grey],
    ["PS5", "149999", "lib/images/ps5.png", Colors.grey],
    ["PC", "199999", "lib/images/pc.png", Colors.grey],
    ["WashingMachine", "9999", "lib/images/washingmachine.png", Colors.grey],
    ["Smartwatch", "4999", "lib/images/smartwatch.png", Colors.grey],
    ["Tablet", "9999", "lib/images/tablet.png", Colors.grey],
    ["Laptop", "49999", "lib/images/laptop.png", Colors.grey],
    ["Television", "12999", "lib/images/television.png", Colors.grey],
  ];
  get elecItems => _elecItems;
}

class FashionItems extends ChangeNotifier {
  List _fashItems = [
    // [ itemName, itemPrice, imagePath, color ]
    ["Belt", "4.99", "lib/images/belt.png", Colors.grey],
    ["Pants", "9.99", "lib/images/pants.png", Colors.grey],
    ["Jacket", "14.99", "lib/images/jacket.png", Colors.grey],
    ["Shoes", "42.33", "lib/images/shoes.png", Colors.grey],
    ["T-shirt", "9.99", "lib/images/tshirt.png", Colors.grey],
    ["Hat", "14.99", "lib/images/hat.png", Colors.grey],
    ["Scarf", "19.99", "lib/images/scarf.png", Colors.grey],
    ["Gloves", "24.99", "lib/images/gloves.png", Colors.grey],
  ];
  get fashItems => _fashItems;
}

class GroceryItems extends ChangeNotifier {
  List _groceryItems = [
    // [ itemName, itemPrice, imagePath, color ]
    ["Chicken", "4.99", "lib/images/chicken.png", Colors.grey],
    ["Banana", "9.99", "lib/images/banana.png", Colors.grey],
    ["Avocado", "14.99", "lib/images/avocado.png", Colors.grey],
    ["Water", "42.33", "lib/images/water.png", Colors.grey],
    ["Eggs", "2.99", "lib/images/eggs.png", Colors.grey],
    ["Bread", "3.49", "lib/images/bread.png", Colors.grey],
    ["Milk", "3.99", "lib/images/milk.png", Colors.grey],
    ["Cheese", "4.99", "lib/images/cheese.png", Colors.grey],
  ];

  get groceryItems => _groceryItems;
}

class NewItems extends ChangeNotifier {
  List _newItems = [
    // [ itemName, itemPrice, imagePath, color ]
    ["Car", "42.33", "lib/images/car.png", Colors.grey],
    ["EarPods", "9999.999", "lib/images/earpods.png", Colors.grey],
    ["Robot", "9913", "lib/images/robot.png", Colors.grey],
    ["VRHeadset", "299.99", "lib/images/vrheadset.png", Colors.grey],
    ["SmartSpeaker", "149.99", "lib/images/smartspeaker.png", Colors.grey],
    ["SecuritySystem", "99.99", "lib/images/securitysystem.png", Colors.grey],
    ["NuclearWarHead", "42.33", "lib/images/nuke.png", Colors.grey],
    ["Drone", "499.99", "lib/images/drone.png", Colors.grey],
  ];

  get newItems => _newItems;
}
