import '../../models/cardmodel.dart';
import 'package:flutter/material.dart';
import '../mycardpage/mycard_items.dart';

class HomePageCard extends StatelessWidget {
  final CardModel cardModel;

  HomePageCard(this.cardModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              child: MyCardItems(cardModel)),
        ],
      ),
    );
  }
}
