import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/pages/login_page.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_background/animated_background.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: AnimatedBackground(
        vsync: this,
        behaviour: (RacingLinesBehaviour(
          numLines: 50,
        )),
        child: Column(
          children: [
            // big logo
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 0.0,
                top: 30,
                bottom: 40,
              ),
              child: Lottie.network(
                  "https://assets7.lottiefiles.com/packages/lf20_57TxAX.json"),
            ),

            Padding(
              padding:
                  const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 20),
              child: Text(
                'Welcome to E-Mart!',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 120),
              child: Text(
                'High Quality, At a Low Price',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 1),
            // get started button
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
