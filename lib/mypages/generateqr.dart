import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/roundiconbutton.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../bloc_navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter_share_file/flutter_share_file.dart';

class GenerateQR extends StatelessWidget with NavigationStates {
  final GlobalKey globalKey = new GlobalKey();
  String _valueString;

  GenerateQR.valueString(String valueString) {
    _valueString = valueString;
    print(_valueString);
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      print(pngBytes);

      final tempDir = await getTemporaryDirectory();
      print('Found File path: ${tempDir.path}');
      final file = await new File('${tempDir.path}/image.png').create();
      file.writeAsBytes(pngBytes).then((onValue) {
        FlutterShareFile.shareImage(tempDir.path, "image.png");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 25.0),
              child: RepaintBoundary(
                key: globalKey,
                child: Container(
                  color: Colors.white,
                  child: QrImage(
                    data: _valueString,
                    size: 300,
                  ),
                ),
              ),
            ),
            RoundIConButton(
              icondata: Icons.share,
              onPressed: _captureAndSharePng,
              colorStart: Colors.lightGreen,
              colorEnd: Colors.yellow,
            ),
            SizedBox(height: 25.0),
            RoundIConButton(
              icondata: Icons.arrow_back,
              onPressed: () {
                BlocProvider.of<NavigationBloc>(context).add(
                    new NavigationEvents.onlyEvent(
                        EventType.MyCardClickedEvent));
              },
              colorStart: Colors.lightGreen,
              colorEnd: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
