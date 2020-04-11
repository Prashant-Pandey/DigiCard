import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
            colors: [Color(0xff42E695), Color(0xff3BB2B8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: RawMaterialButton(
        splashColor: Colors.redAccent, // splash color
        onPressed: () {},
        focusColor: Colors.blue, // button pressed
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.linkedin,
              color: Colors.white70,
            ),
            FaIcon(
              FontAwesomeIcons.facebookSquare,
              color: Colors.white70,
            ),
            FaIcon(
              FontAwesomeIcons.github,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
