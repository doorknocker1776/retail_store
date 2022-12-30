import 'package:flutter/material.dart';
import 'package:groceryapp/components/signup.dart';
import 'package:groceryapp/components/my_textfield.dart';
import 'package:groceryapp/components/square_tile.dart';
import 'package:groceryapp/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:animated_background/animated_background.dart";
import 'package:lottie/lottie.dart';
import 'package:groceryapp/model/cart_model.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with TickerProviderStateMixin{
  // text editing controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bankaccountcontroller = TextEditingController();
  final bankaccountNamecontroller = TextEditingController();

  // error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      },
    );
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
              Padding(padding: EdgeInsets.fromLTRB(110, 0, 110, 0),
              child:
              Lottie.network("https://assets5.lottiefiles.com/packages/lf20_jcikwtux.json"),
                ),
                // logo
                // let's create an account for you


                // email textfield

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
                  onTap: (){
                    String bnk = bankaccountcontroller.text;
                    String password =  passwordController.text;
                    String cpassword = confirmPasswordController.text;
                    String email = emailController.text;
                    String username = usernameController.text;
                    String bnkname = bankaccountNamecontroller.text;
                    List<String> banknames = ["Chase", "JP Morgan"];
                    if(username.length < 5) {child: showErrorMessage("Username Must be longer than 5");}
                    else if((RegExp(r'^[0-9]+$').hasMatch(username))) {child: showErrorMessage("Username cannot be all digits");}
                    else if (password == username) {
                      child: showErrorMessage("Error: Password cannot be the same as the username");
                    } else if (password != cpassword) {
                      child: showErrorMessage("Error: Password and confirm password do not match");
                    }
                    else if(!RegExp(r'^[0-9]+$').hasMatch(bnk)) {
                      child: showErrorMessage("Error: Bank number must contain only numbers");}
                    else if(!(banknames.contains(bnkname))) {child: showErrorMessage("Error: Bank Name not supported");}

                  },

                ),

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
                      style: TextStyle(color: Colors.grey[700]),
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
                        style: TextStyle(color: Colors.blue),
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