import 'package:flutter/material.dart';

int wc = 0;
int ac = 0;
int bc = 0;
int cc = 0;

class CartModel extends ChangeNotifier {
  // list of items on sale

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

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
