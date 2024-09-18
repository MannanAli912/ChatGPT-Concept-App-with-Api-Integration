import 'package:chatbot/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'screens/mulipleScreens.dart'; // Assuming slider.dart is a screen for carousel/slider
import 'package:chatbot/accounts/Create_account.dart';
import 'package:chatbot/accounts/verify_number.dart';
import 'package:chatbot/accounts/user_name.dart';
import 'package:chatbot/accounts/phone_number.dart';
import 'package:chatbot/chatgpt.dart'; // Assuming chatgpt.dart is related to the chatbot
import 'package:chatbot/screens/Welcome_Screen.dart';
// Your new chat screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatGPT App',
      theme: ThemeData(fontFamily: 'NunitoSans'),
      home: WelcomeScreen(), // Starting point of the app
      routes: {
        '/carousel': (context) => MyCarousel(),
        '/createAccount': (context) => Create_Account(),
        '/details': (context) => Details(),
        'phone': (context) => CountryCodeSelector(),
        'verify': (context) => Verify(),
        'final screen': (context) => Landing(),
        '/chat': (context) => MockBot(), // Navigate to chat screen
      },
    );
  }
}
