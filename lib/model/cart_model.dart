import 'package:flutter/material.dart';

int wc = 0;
int ac = 0;
int bc = 0;
int cc = 0;

class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["IPhone 12 Pro Max", "42.33", "lib/images/iphone.png", Colors.orange],
    ["PS5", "9911199.999", "lib/images/ps5.png", Colors.orange],
    ["Desktop PC", "9913", "lib/images/pc.png", Colors.orange],
    [
      "Washing Machine",
      "42.33",
      "lib/images/washingmachine.png",
      Colors.orange
    ],
    ["Chicken", "30", "lib/images/chicken.png", Colors.redAccent]
  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;
  // add item to cart
  void addItemToCart(List item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
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
