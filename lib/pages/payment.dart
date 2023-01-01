import 'package:flutter/material.dart';
import 'package:groceryapp/components/signup.dart';
import 'package:groceryapp/components/my_textfield.dart';
import 'package:groceryapp/components/square_tile.dart';
import 'package:groceryapp/pages/cart_page.dart';
import 'package:groceryapp/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:animated_background/animated_background.dart";
import 'package:lottie/lottie.dart';
import 'package:groceryapp/model/cart_model.dart' as cart;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with TickerProviderStateMixin {
  // text editing controllers
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // error message to user
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 1000),
      backgroundColor: Colors.transparent,
      elevation: 0,
      //duration=_snack,
      content: Stack(children: [
        Container(
          padding: EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(children: [
            SizedBox(
                width: 330,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
                        child: Text(
                          "Oh snap!",
                          style: GoogleFonts.openSans(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
                        child: Text(message,
                            style: GoogleFonts.openSans(
                                fontSize: 14, color: Colors.white),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                )),
          ]),
        ),
        Positioned(
            bottom: 0,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(20)),
                child: SvgPicture.asset(
                  "lib/images/bubbles.svg",
                  height: 48,
                  width: 40,
                )))
      ]),
    ));
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 2000),
      backgroundColor: Colors.transparent,
      elevation: 0,
      //duration=_snack,
      content: Stack(children: [
        Container(
          padding: EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(children: [
            SizedBox(
                width: 330,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
                        child: Text(
                          "Payment Sucessful!",
                          style: GoogleFonts.openSans(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(42, 0, 0, 0),
                        child: Text(message,
                            style: GoogleFonts.openSans(
                                fontSize: 14, color: Colors.white),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                )),
          ]),
        ),
        Positioned(
            bottom: 0,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(20)),
                child: SvgPicture.asset(
                  "lib/images/bubbles.svg",
                  height: 48,
                  width: 40,
                )))
      ]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(110, 0, 110, 0),
                  child: Lottie.asset("lib/images/payment.json"),
                ),
                // logo
                Text(
                  'Verify Your Credentials to Confirm Payment.',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Payment button
                MyButton(
                    text: "Confirm Payment",
                    onTap: () {
                      String password = confirmPasswordController.text;
                      String username = usernameController.text;
                      if (username.length < 5) {
                        child:
                        showErrorMessage("Username Must be longer than 5");
                      } else if ((RegExp(r'^[0-9]+$').hasMatch(username))) {
                        child:
                        showErrorMessage("Username cannot be all digits");
                      } else if (password == username) {
                        child:
                        showErrorMessage(
                            "Error: Password cannot be the same as the username");
                      } else {
                        Future<http.Response> response;
                        response = http.get((Uri.parse(
                            "http://10.0.2.2:5000/pay?UserID=${usernameController.text}&Password=${confirmPasswordController.text}")));
                        response.then((http.Response res) {
                          final data = json.decode(res.body);
                          if (data['status'] == 'success') {
                            child:
                            showSuccessMessage(
                                "Payment Confirmed and Order Placed.");
                            Future<http.Response> response1;
                            List A = [];
                            for (int i = 0;
                                i < cart.CartModel().cartItems.length;
                                i++) {
                              A.add(cart.CartModel().cartItems[i][0]);
                            }
                            var x = json.encode(A);
                            response1 = http.get((Uri.parse(
                                "http://10.0.2.2:5000/Order?UserID=${usernameController.text}&Items=${x}")));
                            cart.CartModel().clearCart();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return CartPage();
                              },
                            ));
                          } else {
                            child:
                            showErrorMessage("Invalid Entry(s).");
                          }
                        });
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
