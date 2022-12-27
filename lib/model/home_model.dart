import 'package:flutter/material.dart';
int wc=0;
int ac=0;
int bc=0;
int cc=0;

class HomeModel extends ChangeNotifier {
  // list of items on sale
  List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Electronics", "Browse Now", "lib/images/electronics.png", Colors.green],
    ["Textile", "Browse Now", "lib/images/banana.png", Colors.yellow],
    ["Groceries", "Browse Now", "lib/images/chicken.png", Colors.brown],
    ["Water", "1.00", "lib/images/water.png", Colors.blue],
  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
