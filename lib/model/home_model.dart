import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:groceryapp/model/home_model.dart';
class HomeModel extends ChangeNotifier {
  // list of items on sale
  List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Electronics", "Browse Now", "lib/images/electronics.png", Colors.grey],
    ["Fashion", "Browse Now", "lib/images/fashion.png", Colors.grey],
    ["Groceries", "Browse Now", "lib/images/groceries.png", Colors.grey],
    ["New Arrivals", "Browse Now", "lib/images/newarrivals.png", Colors.grey],
  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

}
