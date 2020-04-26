import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color colorStart, colorEnd;
  final Function onPressed;

  CustomGradientButton(
      {this.iconData,
      this.text,
      this.colorStart,
      this.colorEnd,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
      margin: EdgeInsets.only(bottom: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
            colors: [colorStart, colorEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: RawMaterialButton(
        splashColor: Colors.redAccent, // splash color
        onPressed: onPressed,
        focusColor: Colors.blue, // button pressed
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
              child: Icon(iconData),
            ), // icon
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ), // text
          ],
        ),
      ),
    );
  }
}
