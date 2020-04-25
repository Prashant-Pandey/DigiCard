import 'package:digi_card/common/utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/socialmediamodel.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import '../models/cardmodel.dart';
import 'dart:convert';
import 'dart:async';
import '../bloc_navigation/navigation_bloc.dart';
import '../common/roundiconbutton.dart';

import '../models/addressmodel.dart';
import 'package:flutter/material.dart';
import '../common/formfield.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class AddOrEditCard extends StatefulWidget with NavigationStates {
  dynamic editCardModel;
  String email;

  AddOrEditCard(dynamic editCardModel) {
    if (!(editCardModel is CardModel)) {
      this.editCardModel = null;
      email = editCardModel;
    } else
      this.editCardModel = editCardModel;
  }

  @override
  _AddOrEditCardState createState() => _AddOrEditCardState();
}

class _AddOrEditCardState extends State<AddOrEditCard> {
  var _firstname, _lastname, _position, _company, _phoneno, _email;
  AddressModel _address = new AddressModel();
  SocialMediaModel _socials = new SocialMediaModel();
  CardModel cardmodel;
  var listOfFormField;
  var listOfAddressField;
  var listOfMedia;

  final _formKey = GlobalKey<FormState>();
  final _addressformKey = GlobalKey<FormState>();
  final _socialsformKey = GlobalKey<FormState>();

  Future<http.Response> _saveCardRequest() async {
    String url = 'https://ssdi-team-mobility.appspot.com/user/updateCard';

    cardmodel = new CardModel(
        address: _address,
        firstname: _firstname,
        lastname: _lastname,
        email: _email,
        company: _company,
        phoneno: _phoneno,
        position: _position,
        socials: _socials);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String usertoken = sharedPreferences.getString("usertoken");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $usertoken"
    };
    var json = jsonEncode(cardmodel);

    var response =
        await http.post(Uri.encodeFull(url), headers: headers, body: json);
    return response;
  }

  @override
  void initState() {
    super.initState();
    listOfFormField = [
      {
        'text': "First Name",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'onSaved': (firstname) => _firstname = firstname,
        'validator': Utilities.validate,
        'labelColor': Colors.black,
        'initializer':
            widget.editCardModel != null ? widget.editCardModel.firstname : ""
      },
      {
        'text': "Last Name",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'onSaved': (lastname) => _lastname = lastname,
        'labelColor': Colors.black,
        'validator': Utilities.validate,
        'initializer':
            widget.editCardModel != null ? widget.editCardModel.lastname : ""
      },
      {
        'text': "Designation",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'onSaved': (position) => _position = position,
        'labelColor': Colors.black,
        'validator': Utilities.validate,
        'initializer':
            widget.editCardModel != null ? widget.editCardModel.position : ""
      },
      {
        'text': "Company",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'onSaved': (company) => _company = company,
        'labelColor': Colors.black,
        'validator': Utilities.validate,
        'initializer':
            widget.editCardModel != null ? widget.editCardModel.company : ""
      },
      {
        'text': "Phone",
        'validator': null,
        'keyboardType': TextInputType.number,
        'isObscure': false,
        'onSaved': (phoneno) => _phoneno = phoneno,
        'labelColor': Colors.black,
        'validator': (arg) {
          String result = Utilities.validate(arg);
          if (result != null) return result;

          return arg.length == 10 ? null : 'Enter Valid 10 Digit Number';
        },
        'initializer':
            widget.editCardModel != null ? widget.editCardModel.phoneno : ""
      },
      {
        'text': "Email",
        'validator': null,
        'keyboardType': TextInputType.emailAddress,
        'isObscure': false,
        'onSaved': (email) => _email = email,
        'labelColor': Colors.black,
        'validator': Utilities.validateEmail,
        'initializer': widget.editCardModel != null
            ? widget.editCardModel.email
            : widget.email,
        'enabled': false
      },
    ];

    listOfAddressField = [
      {
        'text': "Address 1",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
        'onSaved': (addr1) => _address.addr1 = addr1,
        'validator': Utilities.validate,
        'initializer': widget.editCardModel != null
            ? widget.editCardModel.address.addr1
            : ""
      },
      {
        'text': "Address 2",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
        'onSaved': (addr2) => _address.addr2 = addr2,
        'validator': Utilities.validate,
        'initializer': widget.editCardModel != null
            ? widget.editCardModel.address.addr2
            : ""
      },
      {
        'text': "City",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
        'onSaved': (city) => _address.city = city,
        'validator': Utilities.validate,
        'initializer': widget.editCardModel != null
            ? widget.editCardModel.address.city
            : ""
      },
      {
        'text': "State",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
        'onSaved': (state) => _address.state = state,
        'validator': Utilities.validate,
        'initializer': widget.editCardModel != null
            ? widget.editCardModel.address.state
            : ""
      },
      {
        'text': "Country",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
        'onSaved': (country) => _address.country = country,
        'validator': Utilities.validate,
        'initializer': widget.editCardModel != null
            ? widget.editCardModel.address.country
            : ""
      },
      {
        'text': "Zipcode",
        'validator': null,
        'keyboardType': TextInputType.number,
        'isObscure': false,
        'labelColor': Colors.black,
        'onSaved': (zip) => _address.zip = int.parse(zip),
        'validator': Utilities.validate,
        'initializer': widget.editCardModel != null
            ? widget.editCardModel.address.zip.toString()
            : ""
      }
    ];

    listOfMedia = [
      {
        'text': "LinkedIN",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
        'onSaved': (linkedin) => _socials.linkedin = linkedin,
        'initializer': widget.editCardModel != null
            ? widget.editCardModel.socials.linkedin
            : ""
      },
      {
        'text': "Facebook",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
        'onSaved': (facebook) => _socials.facebook = facebook,
        'initializer': widget.editCardModel != null
            ? widget.editCardModel.socials.facebook
            : ""
      },
      {
        'text': "Github",
        'validator': null,
        'keyboardType': TextInputType.text,
        'isObscure': false,
        'labelColor': Colors.black,
        'onSaved': (github) => _socials.github = github,
        'initializer': widget.editCardModel != null
            ? widget.editCardModel.socials.github
            : ""
      },
    ];
  }

  void savecard(BuildContext context) {
    if (_formKey.currentState.validate() &&
        _addressformKey.currentState.validate() &&
        _socialsformKey.currentState.validate()) {
      _formKey.currentState.save();
      _addressformKey.currentState.save();
      _socialsformKey.currentState.save();

      var future = _saveCardRequest();
      future.then((responsebody) {
        if (responsebody.statusCode == 201) {
          BlocProvider.of<NavigationBloc>(context).add(
              new NavigationEvents.onlyEvent(EventType.MyCardClickedEvent));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(25.0, 150.0, 25.0, 15.0),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ...listOfFormField.map((item) {
                        return FormFieldWidget(
                            enabled: item['enabled'],
                            hintText: item['text'],
                            isPassword: item['isObscure'],
                            validator: item['validator'],
                            keyBoardType: item['keyboardType'],
                            labelColor: item['labelColor'],
                            initialValue: item['initializer'],
                            onSaved: item['onSaved']);
                      }),
                      Container(
                        child: Form(
                          key: _addressformKey,
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
                                    initialValue: item['initializer'],
                                    onSaved: item['onSaved']);
                              }),
                            ],
                          )),
                        ),
                      ),
                      Container(
                        child: Form(
                          key: _socialsformKey,
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
                                    validator: null,
                                    keyBoardType: item['keyboardType'],
                                    labelColor: item['labelColor'],
                                    initialValue: item['initializer'],
                                    onSaved: item['onSaved']);
                              }),
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RoundIConButton(
                    icondata: Icons.save,
                    onPressed: () => savecard(context),
                    colorStart: Colors.lightGreen,
                    colorEnd: Colors.yellow,
                  ),
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
                ]),
          ],
        ),
      ),
    );
  }
}
