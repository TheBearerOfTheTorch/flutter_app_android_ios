import 'package:flutter/material.dart';
import 'package:triggstar/appScreens/authentication/LoginScreen.dart';
import 'package:triggstar/appScreens/authentication/RegisterScreen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen();
    } else {
      return RegisterScreen();
    }
  }
}