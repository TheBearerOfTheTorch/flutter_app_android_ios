import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triggstar/appScreens/authentication/LoginScreen.dart';
import 'package:triggstar/models/user.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    // return either the Home or Authenticate widget
    return user == null?LoginScreen():Home();
  }
}