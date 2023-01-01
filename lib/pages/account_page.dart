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
String username = "-";
String initials = username[0];

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.orange,
      ),

        body: Consumer<CartModel>(
        builder: (context, value, child) {
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
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(height: 16),
                // Name
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                // Phone number
                SizedBox(height: 8),
                // Total orders
                Text(
                  "Total orders: 0",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                // Edit button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          //YO WAHAJ MAKE EVERYTHING TO GUEST DETAILS HERE HARDCODDED STYLE!!!!
                          username = "-";
                          initials = username[0];
                          Provider.of<CartModel>(context, listen: false)
                              .nukecart();
                          return IntroScreen();
                        },
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                  child: Text(
                    "Log Out/Exit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Recent purchases
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
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
        }
    ));
  }
}

