import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final Function onSignUp;
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Info(this.onSignUp);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have an account?",
          textAlign: TextAlign.center,
          style: style.copyWith(fontSize: 19, color: Colors.black54),
        ),
        SizedBox(width: 10.0),
        Material(
            elevation: 2.0,
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.redAccent,
            child: MaterialButton(
              minWidth: 10.0,
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              onPressed: onSignUp,
              child: Text("Sign Up",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                    color: Colors.white,
                  )),
            )),
      ],
    );
  }
}
