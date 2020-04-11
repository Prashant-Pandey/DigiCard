import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  AuthButton({Key key, @required this.logintype, @required this.onButtonPress})
      : super(key: key);

  final String logintype;
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final Function onButtonPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: onButtonPress,
        child: Text(this.logintype,
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
