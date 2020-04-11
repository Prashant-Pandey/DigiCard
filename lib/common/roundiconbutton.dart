import 'package:flutter/material.dart';

class RoundIConButton extends StatelessWidget {
  final IconData icondata;
  final Function onPressed;
  final Color colorStart, colorEnd;

  RoundIConButton(
      {this.icondata, this.onPressed, this.colorStart, this.colorEnd});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(),
        shape: BoxShape.circle,
        gradient: LinearGradient(
            colors: [colorStart, colorEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: RawMaterialButton(
        onPressed: onPressed,
        splashColor: Colors.redAccent,
        child: Icon(
          icondata,
          size: 35,
        ),
      ),
    );
  }
}
