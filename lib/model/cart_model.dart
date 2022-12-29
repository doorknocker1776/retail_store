import 'package:flutter/material.dart';
import 'package:groceryapp/model/home_model.dart';
import 'package:groceryapp/model/cart_model.dart';
int wc=0;
int ac=0;
int bc=0;
int cc=0;

class CartModel extends ChangeNotifier {

  // list of cart items
  List _cartItems = [
    ["IPhone 12 Pro Max", "42.33"],
    ["PS5", "9999.999"],
    ["Desktop PC", "9913"],
    ["Washing Machine", "42.33"],
  ];

  get cartItems => _cartItems;


  // add item to cart
  void addItemToCart(List index) {
    _cartItems.add(index);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(List index) {

    _cartItems.removeAt(_cartItems.indexOf(index));
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
