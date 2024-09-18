import 'dart:async'; // To use Timer
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();

    // Automatically navigate to the chat screen after 3 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/chat');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Image.asset(
                  "assets/images/chatgpt.png", // Splash screen logo
                  height: 170,
                ),
              ),
            ),
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "ChatGPT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white), // Progress indicator for the splash
            ),
          ],
        ),
      ),
    );
  }
}
