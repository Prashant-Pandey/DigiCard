import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './homepagecard.dart';
import '../../models/cardmodel.dart';

import '../../bloc_navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class HomePage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isDataAvailable = false;
  var _result_text;
  List<CardModel> listOfCardModels;
  bool isLoading = true;

  @override
  void initState() {
    listOfCardModels = [];
    Future<List<CardModel>> futurelist = _getSharedCards();
    futurelist.then((list) {
      setState(() {
        listOfCardModels.addAll(list);
        isLoading = false;
      });
    });
  }

  Widget getWidget() {
    if (isLoading)
      return Center(
          child: Text('Please wait its loading...',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));

    if (listOfCardModels.length == 0)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: _isDataAvailable
                    ? Text(_result_text)
                    : Image.asset(
                        "assets/no_data_found.png",
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      )),
            SizedBox(height: 35.0),
            Container(
              width: 300,
              height: 60,
              child: RaisedButton(
                  onPressed: () => _scanQR(context),
                  child: Text(
                    "scan",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      );

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(16, 100, 16, 16),
          width: 150,
          height: 60,
          child: RaisedButton(
              onPressed: () => _scanQR(context),
              child: Text(
                "scan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
        ),
        Container(
            height: 690,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return HomePageCard(listOfCardModels[index]);
              },
              itemCount: listOfCardModels.length,
            )),
      ],
    );
  }

  Future<CardModel> _setSharedCard(String qrResult) async {
    String url = 'https://ssdi-team-mobility.appspot.com/user/setSharedCard';

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String usertoken = sharedPreferences.getString("usertoken");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $usertoken",
    };

    Map<String, String> json = {
      "userID": qrResult,
    };

    var response = await http.post(Uri.encodeFull(url),
        headers: headers, body: jsonEncode(json));
    if (response.statusCode == 201) {
      return CardModel.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  void _scanQR(BuildContext context) async {
    try {
      String qrResult = await BarcodeScanner.scan();
      CardModel cardModel = await _setSharedCard(qrResult);
      setState(() {
        listOfCardModels.add(cardModel);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Camera Permission denied"),
        ));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Unknown errot: $ex"),
        ));
      }
    } on FormatException {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Pressed Back button before scan"),
      ));
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Unknown errot: $ex"),
      ));
    } finally {}
  }

  Future<List<CardModel>> _getSharedCards() async {
    String url = 'https://ssdi-team-mobility.appspot.com/user/getSharedCards';

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String usertoken = sharedPreferences.getString("usertoken");

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: "Bearer $usertoken"
    };
    var response = await http.get(Uri.encodeFull(url), headers: headers);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body).runtimeType);
      return (jsonDecode(response.body) as List)
          .map((data) => CardModel.fromJson(data))
          .toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getWidget());
  }
}
