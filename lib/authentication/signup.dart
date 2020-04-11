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

  Future<String> _makeGetRequest() async {
    String url = 'https://ssdi-team-mobility.appspot.com/auth/register';
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Map<String, String> json = {
      "email": _email,
      "password": _pwd,
      "first_name": _fname,
      "lname": _lname
    };

    var response = await http.post(Uri.encodeFull(url),
        headers: headers, body: jsonEncode(json));

    print(response.body);
    return response.body;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login Page'),
          centerTitle: true,
          backgroundColor: Colors.red[600],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
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
                            onButtonPress: () {
                              if (_formKey.currentState.validate()) {
                                print('success');
                                _formKey.currentState.save();
                                _makeGetRequest();
                              }
                            }),
                        SizedBox(height: 25.0),
                        AuthButton(
                            logintype: "Go Back",
                            onButtonPress: () => Navigator.pop(context)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
