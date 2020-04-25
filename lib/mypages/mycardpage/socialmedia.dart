import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatelessWidget {
  final valueToPass;

  SocialMedia(this.valueToPass);

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
            GestureDetector(
              onTap: () async {
                if (await canLaunch(valueToPass.socials.linkedin))
                  await launch(valueToPass.socials.linkedin);
                else
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Couldnt open the link"),
                  ));
              },
              child: FaIcon(
                FontAwesomeIcons.linkedin,
                color: Colors.white70,
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (await canLaunch(valueToPass.socials.facebook))
                  await launch(valueToPass.socials.facebook);
                else
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Couldnt open the link"),
                  ));
              },
              child: FaIcon(
                FontAwesomeIcons.facebookSquare,
                color: Colors.white70,
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (await canLaunch(valueToPass.socials.github))
                  await launch(valueToPass.socials.github);
                else
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Couldnt open the link"),
                  ));
              },
              child: FaIcon(
                FontAwesomeIcons.github,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
