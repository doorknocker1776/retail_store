import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/components/my_button.dart';
import 'package:groceryapp/components/my_textfield.dart';
import 'package:groceryapp/components/square_tile.dart';
import 'package:groceryapp/pages/intro_screen.dart';
import 'package:groceryapp/pages/signup.dart';
import 'package:lottie/lottie.dart';
import "home_page.dart";
import "package:animated_background/animated_background.dart";
import 'package:groceryapp/model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:groceryapp/pages/account_page.dart' as ac;
import "signup.dart" as signup;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

bool isloggedin = false;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      duration: Duration(milliseconds: 1000),
      backgroundColor: Colors.transparent,
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
                width: 300,
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
                                fontSize: 16, color: Colors.white),
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

  // sign user in method
  void signUserIn() {
    Future<http.Response> response;
    response = http.get((Uri.parse(
        "http://10.0.2.2:5000/login?UserID=${usernameController.text}&Password=${passwordController.text}")));
    response.then((http.Response res) {
      final data = json.decode(res.body);
      if (data['status'] == 'success') {
        ac.username = usernameController.text;
        isloggedin = true;
        return Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ));
      } else {
        child:
        showErrorMessage("Error! Incorrect Credentials.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: AnimatedBackground(
          vsync: this,
          behaviour: BubblesBehaviour(
              options:
                  BubbleOptions(bubbleCount: 5, growthRate: 25, popRate: 150)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),

                  const SizedBox(height: 50),

                  // welcome back, you've been missed!
                  Text(
                    'Welcome back, you\'ve been missed!',
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 25),

                  // username textfield
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

                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          ),
                          child: Text(
                            'Continue as guest',
                            style: GoogleFonts.openSans(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                    onTap: signUserIn,
                  ),

                  const SizedBox(height: 70),

                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: GoogleFonts.openSans(
                            color: Colors.grey[700], fontSize: 15),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterPage(onTap: null);
                            },
                          ),
                        ),
                        child: Text(
                          'Register now',
                          style: GoogleFonts.openSans(color: Colors.blue[800]),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
