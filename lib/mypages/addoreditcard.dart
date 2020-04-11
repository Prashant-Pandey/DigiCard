import 'package:gradient_widgets/gradient_widgets.dart';

import '../common/roundiconbutton.dart';

import '../models/AddressModel.dart';

import '../bloc_navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import '../common/formfield.dart';

class AddOrEditCard extends StatefulWidget with NavigationStates {
  @override
  _AddOrEditCardState createState() => _AddOrEditCardState();
}

class _AddOrEditCardState extends State<AddOrEditCard> {
  var _name, _designation, _company, _phone, _email, _socialmedia;
  AddressModel _address;
  var listOfFormField;
  var listOfAddressField;
  var listOfMedia;

  final _formKey = GlobalKey<FormState>();
  final _addressformKey = GlobalKey<FormState>();

  _AddOrEditCardState() {
    listOfFormField = [
      {
        'text': "Full Name",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'onSaved': (name) => _name = name,
        'labelColor': Colors.black,
      },
      {
        'text': "Designation",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'onSaved': (designation) => _designation = designation,
        'labelColor': Colors.black,
      },
      {
        'text': "Company",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'onSaved': (company) => _company = company,
        'labelColor': Colors.black,
      },
      {
        'text': "Phone",
        'validator': null,
        'keyboardType': TextInputType.number,
        'isObscure': true,
        'onSaved': (phone) => _phone = phone,
        'labelColor': Colors.black,
      },
      {
        'text': "Email",
        'validator': null,
        'keyboardType': TextInputType.emailAddress,
        'isObscure': true,
        'onSaved': (email) => _email = email,
        'labelColor': Colors.black,
      },
    ];

    listOfAddressField = [
      {
        'text': "Apartment",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
      },
      {
        'text': "City",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
      },
      {
        'text': "State",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
      },
      {
        'text': "Country",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
      },
      {
        'text': "Zipcode",
        'validator': null,
        'keyboardType': TextInputType.number,
        'isObscure': false,
        'labelColor': Colors.black,
      }
    ];

    listOfMedia = [
      {
        'text': "LinkedIN",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
      },
      {
        'text': "Facebook",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
      },
      {
        'text': "Github",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(25.0, 70.0, 25.0, 15.0),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.grey,
                width: 3,
              ),
              gradient: LinearGradient(
                  colors: [Color(0xff42E695), Color(0xff3BB2B8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            height: 600,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ...listOfFormField.map((item) {
                    return FormFieldWidget(
                        hintText: item['text'],
                        isPassword: item['isObscure'],
                        validator: item['validator'],
                        keyBoardType: item['keyboardType'],
                        labelColor: item['labelColor'],
                        onSaved: item['onSaved']);
                  }),
                  Container(
                    child: (Column(
                      children: <Widget>[
                        GradientText(
                          'Address',
                          shaderRect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
                          gradient: Gradients.hersheys,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        ...listOfAddressField.map((item) {
                          return FormFieldWidget(
                              hintText: item['text'],
                              isPassword: item['isObscure'],
                              validator: item['validator'],
                              keyBoardType: item['keyboardType'],
                              labelColor: item['labelColor'],
                              onSaved: item['onSaved']);
                        }),
                      ],
                    )),
                  ),
                  Container(
                    child: (Column(
                      children: <Widget>[
                        GradientText(
                          'Social Media',
                          shaderRect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
                          gradient: Gradients.hersheys,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        ...listOfMedia.map((item) {
                          return FormFieldWidget(
                              hintText: item['text'],
                              isPassword: item['isObscure'],
                              validator: item['validator'],
                              keyBoardType: item['keyboardType'],
                              labelColor: item['labelColor'],
                              onSaved: item['onSaved']);
                        }),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
          RoundIConButton(
            icondata: Icons.save,
            onPressed: () {},
            colorStart: Color(0xff42E695),
            colorEnd: Color(0xff3BB2B8),
          ),
        ],
      ),
    );
  }
}
