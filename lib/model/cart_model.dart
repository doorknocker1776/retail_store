import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List _cartItems = [];

class CartModel extends ChangeNotifier {
  // list of items on sale

  // list of cart items

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
  double calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }

    return totalPrice;
  }

  void nukecart() {
    _cartItems = [];
  }

  double discount() {
    double totalPrice = 0;
    double discountt = 0;
    double inDouble = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
      if (totalPrice > 1000) {
        discountt = totalPrice * 0.05;
        String inString = discountt.toStringAsFixed(2);
        inDouble = double.parse(inString);
      }
    }
    return inDouble;
  }
}
