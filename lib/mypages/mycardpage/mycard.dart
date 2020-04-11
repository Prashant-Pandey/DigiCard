import '../../models/socialmediamodel.dart';

import '../../models/addressmodel.dart';

import '../../models/cardmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/roundiconbutton.dart';

import '../../bloc_navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import './mycard_items.dart';
import 'dart:ui' as ui;
import 'dart:convert';

class MyCard extends StatefulWidget with NavigationStates {
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  AddressModel addressModel;
  CardModel mycardmodel;
  SocialMediaModel socialmediamodel;
  List<Map<String, Object>> list;

  @override
  void initState() {
    super.initState();

    addressModel = new AddressModel(
        street: "212 Barton Creek D",
        state: "NC",
        city: "Charlotte",
        country: "US",
        zipcode: "28262");

    mycardmodel = new CardModel(
        name: "Akhil",
        designation: "Software Engineer",
        company: "UNCC",
        email: "a@b.com",
        phone: "9804300626",
        address: addressModel,
        socialMediaModel: socialmediamodel);

    socialmediamodel =
        new SocialMediaModel(facebook: "", github: "", linkedin: "");

    list = [
      {
        "icon": Icons.edit,
        'event': new NavigationEvents.onlyEvent(EventType.AddOrEditCardEvent)
      },
      {"icon": Icons.delete, "onPressed": null},
      {
        "icon": Icons.keyboard_arrow_right,
        'event': new NavigationEvents(
            EventType.GenerateQREvent, jsonEncode(mycardmodel))
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(top: 35),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                            colors: [Colors.pink, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 5,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: MyCardItems()),
                ],
              ),
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ...list.map((item) {
                  return RoundIConButton(
                    icondata: item['icon'],
                    colorStart: Colors.lightGreen,
                    colorEnd: Colors.yellow,
                    onPressed: item['event'] != null
                        ? () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(item['event']);
                          }
                        : () => {},
                  );
                }).toList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
