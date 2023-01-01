import 'package:flutter/material.dart';
import 'package:groceryapp/components/signup.dart';
import 'package:groceryapp/components/my_textfield.dart';
import 'package:groceryapp/components/square_tile.dart';
import 'package:groceryapp/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:animated_background/animated_background.dart";
import 'package:lottie/lottie.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bankaccountcontroller = TextEditingController();
  final bankaccountNamecontroller = TextEditingController();

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
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
      backgroundColor: Colors.orange,
      body: AnimatedBackground(
        vsync: this,
        behaviour: (BubblesBehaviour(
          options: BubbleOptions(bubbleCount: 15, growthRate: 25, popRate: 150),
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(110, 0, 110, 0),
                  child: Lottie.asset("lib/images/login.json"),
                ),
                // logo
                // let's create an account for you

                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: bankaccountcontroller,
                  hintText: 'Bank Account Number',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                MyTextField(
                  controller: bankaccountNamecontroller,
                  hintText: 'Bank Account Name',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                // sign in button
                MyButton(
                    text: "Sign Up",
                    onTap: () {
                      String bnk = bankaccountcontroller.text;
                      String password = passwordController.text;
                      String cpassword = confirmPasswordController.text;
                      String username = usernameController.text;
                      String bnkname = bankaccountNamecontroller.text;
                      List<String> banknames = [
                        "Chase",
                        "JP Morgan",
                        "Meezan",
                        "MCB",
                        "HBL",
                        "BOP"
                      ];
                      if (username.length < 5) {
                        child:
                        showErrorMessage(
                            "Username Must be longer than 5 Characters");
                      } else if ((RegExp(r'^[0-9]+$').hasMatch(username))) {
                        child:
                        showErrorMessage("Username cannot be all digits");
                      } else if (password == username) {
                        child:
                        showErrorMessage(
                            "Password cannot be the same as the username");
                      } else if (password != cpassword) {
                        child:
                        showErrorMessage("Error: Passwords do not match");
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(bnk)) {
                        child:
                        showErrorMessage(
                            "Error: Bank number must contain only numbers");
                      } else if (!(banknames.contains(bnkname))) {
                        child:
                        showErrorMessage("Error: Bank Name not supported");
                      } else {
                        Future<http.Response> response;
                        response = http.get((Uri.parse(
                            "http://10.0.2.2:5000/get_user?UserID=${usernameController.text}&Password=${passwordController.text}&Bank_Name=${bankaccountNamecontroller.text}&Account_No=${bankaccountcontroller.text}")));
                        response.then((http.Response res) {
                          final data = json.decode(res.body);
                          if (data['status'] == 'success') {
                            return Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return LoginPage();
                              },
                            ));
                          } else {
                            child:
                            showErrorMessage(
                                "Invalid Entry(s) or username taken.");
                          }
                        });
                      }
                    }),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.openSans(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                      ),
                      child: Text(
                        'Log in now',
                        style: GoogleFonts.openSans(
                            color: Color.fromARGB(255, 0, 119, 255)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
