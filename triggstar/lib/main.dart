import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triggstar/services/auth.dart';
import 'appScreens/wrapper.dart';
import 'models/user.dart';

void main()=>runApp(MyApp(),);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
        create: (_) => AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
      home: Wrapper(),
    ));
  }
}
