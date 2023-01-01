import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:groceryapp/model/home_model.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

Future<List> populate() async {
  List data1 = [];
  List X = [];
  Future<http.Response> response4 =
      http.get((Uri.parse("http://10.0.2.2:5000/populate")));
  response4.then((http.Response res) {
    final data = json.decode(res.body);
    for (int i = 0; i < data['status'].length; i++) {
      X.add([
        data['status'][i][0],
        '${data['status'][i][1]}',
        "lib/images/${data['status'][i][0].toLowerCase()}.png",
        Colors.grey
      ]);
    }
  });
  return X;
}

List populate1() {
  List data1 = [];
  List X = [];
  Future<http.Response> response4 =
      http.get((Uri.parse("http://10.0.2.2:5000/populate1")));
  response4.then((http.Response res) {
    final data = json.decode(res.body);
    for (int i = 0; i < data['status'].length; i++) {
      X.add([
        data['status'][i][0],
        '${data['status'][i][1]}',
        "lib/images/${data['status'][i][0].toLowerCase()}.png",
        Colors.grey
      ]);
    }
  });
  return X;
}

List populate2() {
  List data1 = [];
  List X = [];
  Future<http.Response> response4 =
      http.get((Uri.parse("http://10.0.2.2:5000/populate2")));
  response4.then((http.Response res) {
    final data = json.decode(res.body);
    for (int i = 0; i < data['status'].length; i++) {
      X.add([
        data['status'][i][0],
        '${data['status'][i][1]}',
        "lib/images/${data['status'][i][0].toLowerCase()}.png",
        Colors.grey
      ]);
    }
  });
  return X;
}

List populate3() {
  List data1 = [];
  List X = [];
  Future<http.Response> response4 =
      http.get((Uri.parse("http://10.0.2.2:5000/populate3")));
  response4.then((http.Response res) {
    final data = json.decode(res.body);
    for (int i = 0; i < data['status'].length; i++) {
      X.add([
        data['status'][i][0],
        '${data['status'][i][1]}',
        "lib/images/${data['status'][i][0].toLowerCase()}.png",
        Colors.grey
      ]);
    }
  });
  return X;
}

Future<List> _elecItems = populate();
List _groceryItems = populate1();
List _fashItems = populate2();
List _newItems = populate3();

class ElectronicItems extends ChangeNotifier {
  // list of items on sale
  get elecItems => _elecItems;
}

class FashionItems extends ChangeNotifier {
  get fashItems => _fashItems;
}

class GroceryItems extends ChangeNotifier {
  get groceryItems => _groceryItems;
}

class NewItems extends ChangeNotifier {
  get newItems => _newItems;
}
