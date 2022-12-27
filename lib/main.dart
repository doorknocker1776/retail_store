//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:groceryapp/model/home_model.dart';
import 'package:groceryapp/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'pages/intro_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeModel()),
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroScreen(),
      ),
    );
  }
}