import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 280),
      child:Center(
          child: const SpinKitCircle(
            color: Colors.blue,
            size: 50.0,
          )
      ),
    );
  }
}
