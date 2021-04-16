import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triggstar/appScreens/home/serviceTile.dart';
import 'package:triggstar/models/dbUser.dart';

class CleaningServices extends StatefulWidget {
  @override
  _CleaningServicesState createState() => _CleaningServicesState();
}

class _CleaningServicesState extends State<CleaningServices> {

  @override
  Widget build(BuildContext context) {
    //final userss = Provider.of<List<DBuser>>(context);
    return ServiceTile();

  }
}

