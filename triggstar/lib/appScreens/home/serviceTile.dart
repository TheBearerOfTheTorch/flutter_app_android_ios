import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triggstar/models/dbUser.dart';

class ServiceTile extends StatelessWidget {
  final DBuser user;
  ServiceTile({this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Column(children: [
        Text(
          "Cleaning Services",
          style: GoogleFonts.openSans(color: Colors.white, fontSize: 28),
        ),
        SizedBox(
          height: 30,
        ),
        cardBuild("House Cleaning", "tap to book", FontAwesomeIcons.houseUser),
        SizedBox(
          height: 10,
        ),
        cardBuild("Carpet Cleaning", "tap to book", FontAwesomeIcons.accusoft),
        SizedBox(
          height: 10,
        ),
        cardBuild(
            "Warehouse Cleaning", "tap to book", FontAwesomeIcons.warehouse),
        SizedBox(
          height: 10,
        ),
        cardBuild(
            "Event Cleaning", "tap to book", Icons.event_available_outlined),
        SizedBox(
          height: 10,
        ),
        cardBuild("Bush Clearing", "tap to book", FontAwesomeIcons.weebly),
        SizedBox(
          height: 10,
        ),
        cardBuild("Post construction Cleaning", "tap to book",
            FontAwesomeIcons.exclamationTriangle),
        SizedBox(
          height: 10,
        ),
        cardBuild("Office cleaning Cleaning", "tap to book",
            FontAwesomeIcons.businessTime),
        SizedBox(
          height: 10,
        ),
        cardBuild("Post construction Cleaning", "tap to book",
            FontAwesomeIcons.exclamationTriangle),
        SizedBox(
          height: 10,
        ),
        cardBuild("Office cleaning Cleaning", "tap to book",
            FontAwesomeIcons.businessTime),
      ]),
    );
  }

  Widget cardBuild(String title, String subtitle, IconData icon) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
      child: ListTile(
        leading: FaIcon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
