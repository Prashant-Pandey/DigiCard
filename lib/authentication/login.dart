import '../sidebar/sidebarlayout.dart';

import './signup.dart';
import 'package:flutter/material.dart';
import '../common/formfield.dart';
import './authbutton.dart';
import './horizontaldivider.dart';
import './info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _email, _pwd;

  void navigate(BuildContext context, Widget widget) {
    if (widget is Signup)
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Signup()));
    else
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SideBarLayout()));
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Future<String> _makeGetRequest() async {
    String url = 'https://ssdi-team-mobility.appspot.com/auth/register';
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Map<String, String> json = {
      "email": _email,
      "password": _pwd,
    };

    var response = await http.post(Uri.encodeFull(url),
        headers: headers, body: jsonEncode(json));
    return response.body;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    )),
                SizedBox(height: 45.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      FormFieldWidget(
                          hintText: "Email",
                          isPassword: false,
                          keyBoardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                          onSaved: (email) => _email = email),
                      FormFieldWidget(
                        hintText: "Password",
                        isPassword: true,
                        keyBoardType: TextInputType.text,
                        validator: (arg) {
                          if (arg.isEmpty) return 'Field should not be empty';
                          return null;
                        },
                        onSaved: (pwd) => _pwd = pwd,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        child: Text(
                          "Forgot Password?",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          print('Hello');
                        },
                      ),
                    ),
                  ],
                ),
                AuthButton(
                    logintype: "Login",
                    onButtonPress: () {
                      if (_formKey.currentState.validate()) {
                        print('success');
                        _formKey.currentState.save();
                        Future<String> future = _makeGetRequest();
                        future.then((response) {
                          navigate(context, SideBarLayout());
                        });
                      }
                    }),
                SizedBox(
                  height: 15.0,
                ),
                HorizontalDivider(),
                SizedBox(
                  height: 15.0,
                ),
                AuthButton(
                    logintype: "Sign in with LinkedIN", onButtonPress: null),
                SizedBox(
                  height: 35.0,
                ),
                Info(() => navigate(context, Signup())),
              ],
            )),
      ),
    );
  }
}
