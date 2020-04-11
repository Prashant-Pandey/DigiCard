import 'package:flutter/services.dart';

import '../../bloc_navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isDataAvailable = false;
  var _result_text;

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        _isDataAvailable = true;
        _result_text = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          _isDataAvailable = true;
          _result_text = "Camera Permission denied";
        });
      } else {
        setState(() {
          _isDataAvailable = true;
          _result_text = "Unknown errot: $ex";
        });
      }
    } on FormatException {
      setState(() {
        _isDataAvailable = true;
        _result_text = "Pressed Back button before scan";
      });
    } catch (ex) {
      setState(() {
        _isDataAvailable = true;
        _result_text = "Unknown errot: $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final bodyHeight = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Center(
        child: Column(
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
            Container(
              child: RaisedButton(onPressed: _scanQR, child: Text("scan")),
            )
          ],
        ),
      ),
    );
  }
}
