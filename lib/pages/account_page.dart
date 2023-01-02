import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'login_page.dart';
import 'package:groceryapp/pages/intro_screen.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'intro_screen.dart';
import 'home_page.dart';
import 'search.dart';
import "payment.dart" as payment;
import 'login_page.dart' as login;
import 'signup.dart';
import 'package:animated_background/animated_background.dart';

String _set() {
  s = "";
  if (isloggedin == true) {
    s = "Log Out";
  } else if (isloggedin == false) {
    s = "Log In";
  }
  return s;
}

String orders = "?";
String s = _set();
String username = "-";
String initials = username[0];

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Colors.orange,
        ),
        body: AnimatedBackground(
          vsync: this,
          behaviour: BubblesBehaviour(
              options:
                  BubbleOptions(bubbleCount: 5, growthRate: 5, popRate: 150)),
          child: Consumer<CartModel>(builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile icon
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.orange,
                    child: Text(
                      initials,
                      style: GoogleFonts.openSans(fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Name
                  Text(
                    username,
                    style: GoogleFonts.openSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Phone number
                  SizedBox(height: 8),
                  // Total orders
                  Text(
                    "Total orders: $orders",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Edit button
                  ElevatedButton(
                    onPressed: () {
                      username = "-";
                      isloggedin = false;
                      s = _set();
                      initials = username[0];
                      orders = "?";
                      Provider.of<CartModel>(context, listen: false).nukecart();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                    ),
                    child: Text(
                      s,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Recent purchases
                  Expanded(
                    child: ListView.builder(
                      itemCount: 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Order # $index"),
                          subtitle: Text("\PKR X"),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
