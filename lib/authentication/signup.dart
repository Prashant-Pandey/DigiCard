import '../sidebar/sidebarlayout.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './authbutton.dart';
import '../common/formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var listOfFormField;
  var _fname, _lname, _email, _pwd, _cpwd;
  SharedPreferences prefs;

  String _validateName(arg) {
    if (arg.isEmpty) return 'Field should not be empty';

    return null;
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

  _SignupState() {
    listOfFormField = [
      {
        'text': "Name",
        'validator': _validateName,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'onSaved': (fname) => _fname = fname,
      },
      {
        'text': "Last Name",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'onSaved': (lname) => _lname = lname
      },
      {
        'text': "Email",
        'validator': _validateEmail,
        'keyboardType': TextInputType.emailAddress,
        'isObscure': false,
        'onSaved': (email) => _email = email
      },
      {
        'text': "Password",
        'validator': _validateName,
        'keyboardType': TextInputType.text,
        'isObscure': true,
        'onSaved': (pwd) => _pwd = pwd,
      },
      {
        'text': "Confirm Password",
        'validator': _validateName,
        'keyboardType': TextInputType.text,
        'isObscure': true,
        'onSaved': (cpwd) => _cpwd = cpwd
      }
    ];
  }

  Future<Response> _SignUp() async {
    String url = 'https://ssdi-team-mobility.appspot.com/auth/register';
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map<String, String> json = {
      "email": _email,
      "password": _pwd,
      "first_name": _fname,
      "lname": _lname
    };

    var response = await http.post(Uri.encodeFull(url),
        headers: headers, body: jsonEncode(json));

    return response;
  }

  void onSignUpPress(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_pwd != _cpwd) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Same Passwords should be given"),
        ));
        return;
      }
      Future<Response> future = _SignUp();
      future.then((response) async {
        Map jsonMap = jsonDecode(response.body);
        if (response.statusCode == 401) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Invalid credentials"),
          ));
          return;
        }

        if (response.statusCode == 201) {
          prefs = await SharedPreferences.getInstance();
          prefs.setString('usertoken', jsonMap['token']);
          prefs.setString('_id', jsonMap['user']['_id']);
          prefs.setString('name', "${jsonMap['user']['first_name']}");
          prefs.setString('email', jsonMap['user']['email']);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SideBarLayout()),
              (Route<dynamic> route) => false);
          return;
        }
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Sign Up Error"),
        ));
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Sign Up Page'),
          centerTitle: true,
          backgroundColor: Colors.red[600],
        ),
        body: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ...listOfFormField.map((item) {
                        return FormFieldWidget(
                          hintText: item['text'],
                          isPassword: item['isObscure'],
                          validator: item['validator'],
                          keyBoardType: item['keyboardType'],
                          onSaved: item['onSaved'],
                        );
                      }).toList(),
                      SizedBox(height: 10.0),
                      AuthButton(
                          logintype: "Sign Up",
                          onButtonPress: () => onSignUpPress(context)),
                      SizedBox(height: 25.0),
                      AuthButton(
                          logintype: "Go Back",
                          onButtonPress: () => Navigator.pop(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
