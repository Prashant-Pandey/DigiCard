import 'package:shared_preferences/shared_preferences.dart';

import '../../models/socialmediamodel.dart';

import '../../models/addressmodel.dart';

import '../../models/cardmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../common/roundiconbutton.dart';

import '../../bloc_navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import './mycard_items.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'dart:io';

class MyCard extends StatefulWidget with NavigationStates {
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  AddressModel addressModel;
  CardModel mycardmodel;
  SocialMediaModel socialmediamodel;
  List<Map<String, Object>> list;
  bool isLoading = true;
  String email_id;

  @override
  void initState() {
    super.initState();
    list = [
      {"icon": Icons.edit, 'event': null},
      {"icon": Icons.keyboard_arrow_right, 'event': null}
    ];

    getMyCard().then((myCard) {
      setState(() {
        mycardmodel = myCard;
        list[0]['event'] =
            new NavigationEvents(EventType.AddOrEditCardEvent, myCard);
        isLoading = false;
      });
    });
  }

  Future<CardModel> getMyCard() async {
    String url = 'https://ssdi-team-mobility.appspot.com/user/getMyCard';

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String usertoken = sharedPreferences.getString("usertoken");
    String _id = sharedPreferences.getString("_id");
    email_id = sharedPreferences.getString('email');

    list[1]['event'] = new NavigationEvents(EventType.GenerateQREvent, _id);

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: "Bearer $usertoken"
    };
    var response = await http.get(Uri.encodeFull(url), headers: headers);
    if (response.statusCode == 200 &&
        jsonDecode(response.body)['address'] != null) {
      return new CardModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Widget getWidget() {
    if (isLoading)
      return Center(
          child: Text('Please wait its loading...',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));

    if (mycardmodel == null)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/no_data_found.png",
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 35),
          RoundIConButton(
              icondata: Icons.add_circle,
              colorStart: Colors.lightGreen,
              colorEnd: Colors.yellow,
              onPressed: () => BlocProvider.of<NavigationBloc>(context).add(
                  new NavigationEvents(
                      EventType.AddOrEditCardEvent, email_id))),
        ],
      );

    return Column(
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
                  child: MyCardItems(mycardmodel)),
            ],
          ),
        ),
        SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: getWidget()),
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
