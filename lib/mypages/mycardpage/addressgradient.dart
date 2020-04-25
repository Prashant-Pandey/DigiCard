import '../../models/cardmodel.dart';
import 'package:flutter/material.dart';

class AddressGradient extends StatelessWidget {
  final TextStyle style = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  final CardModel valueToPass;

  AddressGradient(this.valueToPass);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
            colors: [Color(0xffFF5B95), Color(0xffF8556D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: RawMaterialButton(
        splashColor: Colors.redAccent, // splash color
        onPressed: () {},
        focusColor: Colors.blue, // button pressed
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.location_on, size: 50),
            ), // icon
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    valueToPass.address.addr1,
                    style: style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    valueToPass.address.addr2,
                    style: style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    valueToPass.address.city,
                    style: style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    valueToPass.address.state,
                    style: style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    valueToPass.address.zip.toString(),
                    style: style,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
