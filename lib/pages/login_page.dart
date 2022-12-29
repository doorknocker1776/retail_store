import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/components/my_button.dart';
import 'package:groceryapp/components/my_textfield.dart';
import 'package:groceryapp/components/square_tile.dart';
import 'package:groceryapp/pages/intro_screen.dart';
import 'package:groceryapp/pages/signup.dart';
import 'package:lottie/lottie.dart';
import "home_page.dart";
import "signup.dart";
import "package:animated_background/animated_background.dart";
import 'package:groceryapp/model/cart_model.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body:
      AnimatedBackground(
        vsync: this,
        behaviour: BubblesBehaviour(
        options: BubbleOptions(
          bubbleCount:5,
          growthRate: 25,
          popRate: 150
        )
        ),
        child: Center(
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
                  fontWeight: FontWeight.bold
                ),
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
                  children:
                  [
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
                        style: GoogleFonts.openSans
                          (color: Colors.black),
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

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700],
                      fontSize: 15
                    ),
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
                      style: TextStyle(color: Colors.blue[800]),
                    ),
                  )

                ],
              ),
          ],
        ),
      ),
      ),
    );
  }
}
