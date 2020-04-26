import 'package:http/http.dart';

import '../sidebar/sidebarlayout.dart';

import './signup.dart';
import 'package:flutter/material.dart';
import '../common/formfield.dart';
import './authbutton.dart';
import './info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../common/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _email, _pwd;
  SharedPreferences prefs;

  void navigate(BuildContext context, Widget widget) {
    if (widget is Signup)
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Signup()));
    else
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SideBarLayout()),
          (Route<dynamic> route) => false);
  }

  Future<Response> _makeGetRequest() async {
    String url = 'https://ssdi-team-mobility.appspot.com/auth/login';
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map<String, String> json = {
      "email": _email,
      "password": _pwd,
    };

    var response = await http.post(Uri.encodeFull(url),
        headers: headers, body: jsonEncode(json));
    return response;
  }

  void onLoginPress(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Future<Response> future = _makeGetRequest();
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
          navigate(context, SideBarLayout());
          return;
        }
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Login Error"),
        ));
      });
    }
  }

  _showDialog() async {
    GlobalKey<FormState> _emailformkey = new GlobalKey(),
        _pswdformkey = new GlobalKey(),
        _tokenformkey = new GlobalKey();

    TextEditingController emailController = new TextEditingController(),
        pswdController = new TextEditingController(),
        tokenController = new TextEditingController();

    var email = await showDialog<String>(
      context: context,
      builder: (context) => _SystemPadding(
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: Form(
                  key: _emailformkey,
                  child: TextFormField(
                    autofocus: true,
                    controller: emailController,
                    validator: Utilities.validateEmail,
                    decoration: new InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  if (_emailformkey.currentState.validate()) {
                    Navigator.of(context).pop(emailController.text.toString());
                  }
                })
          ],
        ),
      ),
    );

    var issuccess = await showDialog<String>(
      context: context,
      builder: (context) => _SystemPadding(
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                child: TextFormField(
                  enabled: false,
                  autofocus: true,
                  initialValue: email,
                  validator: Utilities.validateEmail,
                  decoration: new InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              Form(
                key: _pswdformkey,
                child: TextFormField(
                  autofocus: true,
                  controller: pswdController,
                  validator: Utilities.validate,
                  decoration: new InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),
              Form(
                key: _tokenformkey,
                child: TextFormField(
                  autofocus: true,
                  controller: tokenController,
                  validator: Utilities.validate,
                  decoration: new InputDecoration(
                    labelText: 'Token',
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  if (_tokenformkey.currentState.validate() &&
                      _pswdformkey.currentState.validate()) {
                    Navigator.of(context).pop(emailController.text.toString());
                  }
                })
          ],
        ),
      ),
    );
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
      body: Builder(
        builder: (context) => Container(
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
                            validator: Utilities.validateEmail,
                            onSaved: (email) => _email = email),
                        FormFieldWidget(
                          hintText: "Password",
                          isPassword: true,
                          keyBoardType: TextInputType.text,
                          validator: Utilities.validate,
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
                            _showDialog();
                          },
                        ),
                      ),
                    ],
                  ),
                  AuthButton(
                    logintype: "Login",
                    onButtonPress: () => onLoginPress(context),
                  ),
                  SizedBox(
                    height: 65.0,
                  ),
                  Info(() => navigate(context, Signup())),
                ],
              )),
        ),
      ),
    );
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        duration: const Duration(milliseconds: 300), child: child);
  }
}
