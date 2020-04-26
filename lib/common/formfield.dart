import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  FormFieldWidget(
      {Key key,
      @required this.hintText,
      @required this.isPassword,
      @required this.validator,
      this.keyBoardType,
      this.initialValue,
      this.labelColor,
      this.enabled,
      this.onSaved})
      : super(key: key);

  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final bool isPassword;
  final String hintText, initialValue;
  final Function validator;
  final Color labelColor;
  final keyBoardType;
  final onSaved;
  final bool enabled;

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 25.0),
      child: TextFormField(
          enabled: this.enabled != null ? this.enabled : true,
          initialValue: this.initialValue != null ? this.initialValue : "",
          obscureText: this.isPassword,
          style: style,
          validator: this.validator,
          keyboardType: this.keyBoardType,
          onSaved: this.onSaved,
          decoration: InputDecoration(
            labelText: this.hintText,
            labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: this.labelColor != null ? this.labelColor : Colors.grey,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red[600])),
            contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 10.0),
            //hintText: this.hintText,
            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          )),
    );
  }
}
