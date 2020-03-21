import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: LoginPage(),
        theme: ThemeData(
            primarySwatch: Colors.blue
        )
    );
  }
}

class FormFieldWidget extends StatelessWidget{

  FormFieldWidget({Key key, this.hintText: ""}): super(key: key);

  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: this.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

}

class LoginButton extends StatelessWidget{


  LoginButton({Key key, this.logintype: "Login"}): super(key: key);

  var logintype;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text(this.logintype,
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

  }

}

class HorizontalDivider extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),
      ),
      Text("OR"),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),
      ),
    ]);
  }

}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    final random = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Don't have an account?",
          textAlign: TextAlign.center,
          style: style.copyWith(
              fontSize: 19,
              color: Colors.black54),),
        SizedBox(width: 10.0),
        Material(
            elevation: 2.0,
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.redAccent,
            child: MaterialButton(
              minWidth: 10.0,
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              onPressed: () {},
              child: Text("Sign Up",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                    color: Colors.white,)),
            )
        ),
      ],
    );



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                      height : 155.0,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      )
                  ),
                  SizedBox(height: 45.0),
                  FormFieldWidget(hintText: "Email"),
                  SizedBox(height: 25.0),
                  FormFieldWidget(hintText: "Password"),
                  SizedBox(
                    height: 35.0,
                  ),
                  LoginButton(),
                  SizedBox(height: 15.0,),
                  HorizontalDivider(),
                  SizedBox(height: 15.0,),
                  LoginButton(logintype: "Sign in with LinkedIN"),
                  SizedBox(height: 35.0,),
                  random
                ],
              )
          ),
        ),
      ),
    );
  }
}