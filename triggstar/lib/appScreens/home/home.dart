import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triggstar/appScreens/home/cleaningService.dart';
import 'package:triggstar/models/dbUser.dart';
import 'package:triggstar/services/auth.dart';
import 'package:triggstar/services/database.dart';
import 'package:triggstar/shared/loading.dart';


class Home extends StatelessWidget {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoGreen = Color(0xff25bcbb);
  bool loading = false;

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return loading?Loading(): StreamProvider<List<DBuser>>.value(
        value: DatabaseService().users,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,backgroundColor: Colors.white38,
          actions: [
            Container(margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Row(children: [
                OutlinedButton.icon(onPressed: (){},
                    icon: Icon(Icons.menu,color: Colors.white), label: Text('')),
                SizedBox(width: 220,),
                OutlinedButton.icon(
                    icon: Icon(Icons.logout,color: Colors.white),label: Text(''),
                    onPressed: () async{
                      loading = true;
                      await _auth.signOut();
                    })
              ],),
            ),
          ],
        ),
        backgroundColor: secondaryColor,
        body:SingleChildScrollView(child: CleaningServices()),
      ),
    );
  }
}
