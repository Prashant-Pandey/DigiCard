import './gradientbutton.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import './addressgradient.dart';
import './socialmedia.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCardItems extends StatelessWidget {
  final TextStyle style =
      TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.w800);

  final valueToPass;

  MyCardItems(this.valueToPass);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GradientText(
          '${valueToPass.firstname} ${valueToPass.lastname}',
          shaderRect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
          gradient: Gradients.coldLinear,
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.work,
                size: 30,
                color: Colors.black,
              ),
            ),
            GradientText(
              '${valueToPass.position}, ${valueToPass.company}',
              shaderRect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
              gradient: Gradients.coldLinear,
              style: TextStyle(
                  fontSize: 25.0, fontWeight: FontWeight.w800, fontFamily: ""),
            ),
          ],
        ),
        SizedBox(height: 5),
        Divider(
            height: 10,
            thickness: 1,
            color: Colors.white.withOpacity(0.7),
            endIndent: 32),
        SizedBox(height: 15),
        CustomGradientButton(
            iconData: Icons.call,
            text: valueToPass.phoneno,
            colorStart: Color(0xff6DC8F3),
            colorEnd: Color(0xff73A1F9),
            onPressed: () async {
              if (await canLaunch("tel:1234567"))
                await launch("tel:${valueToPass.phoneno}");
              else
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Couldnt call the number"),
                ));
            }),
        CustomGradientButton(
            iconData: Icons.mail,
            text: valueToPass.email,
            colorStart: Color(0xffFFB157),
            colorEnd: Color(0xffFFA057),
            onPressed: () async {
              if (await canLaunch("mailto:${valueToPass.email}"))
                await launch("mailto:${valueToPass.email}");
              else
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Couldnt call the number"),
                ));
            }),
        AddressGradient(this.valueToPass),
        SocialMedia(this.valueToPass),
      ],
    );
  }
}
