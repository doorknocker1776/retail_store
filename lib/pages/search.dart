import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import 'package:groceryapp/model/home_model.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'intro_screen.dart';
import "home_page.dart";
import"cart_page.dart";
import 'package:groceryapp/model/cart_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<CurvedNavigationBarState> _navigationBarKey =
  GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search"),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _navigationBarKey,
        height: 50,
        backgroundColor: Colors.white,
        color: Colors.blue,
        animationDuration: Duration(milliseconds: 450),
        onTap: (index) => Future.delayed(Duration(milliseconds: 550), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (index == 0) {
                  return HomePage();
                } else if (index == 1) {
                  return SearchPage();
                } else if (index == 2) {
                  return CartPage();
                }
                return IntroScreen();
              },
            ),
          );
        }),
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}//onpressed: