import 'package:flutter/material.dart';
import 'package:pezeshk_yar/Constant/Constant.dart';
import 'package:pezeshk_yar/Constant/globalVariables.dart' as globalVariables;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userPhoneNumberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(

        //backgroundColor: Colors.blueGrey[200],

        body:
        Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover),
      ),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 40.0),
                    child: Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/image.jpg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
//Image-logo

                Card(
                  elevation: 20.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  color: Colors.white,
                  margin: EdgeInsets.only(
                    top: 40.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 20.0, right: 16.0),
                          child: Text(
                            "لطفا شماره تلفن خود را وارد نمایید  ",
                            style: TextStyle(
                                fontFamily: 'Shabnam',
                                fontSize: 18.0,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ), // Text-Enter Phone Number

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: new TextField(

                                controller: _userPhoneNumberController,
                                textAlign: TextAlign.end,
                                maxLines: 1,
                                autofocus: false,
                                enabled: true,
                                decoration: InputDecoration(
                                    hintText: '09121111111',
                                    suffixIcon: Icon(Icons.phone_iphone)),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(

                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontFamily: 'Shabnam',
                                ),
                              ),
                              flex: 5,
                            ),
                          ],
                        ), //phone-Entry
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: new FloatingActionButton(
                              onPressed: () {
                                globalVariables.userPhoneNumber = _userPhoneNumberController.text.toString();
                                print(globalVariables.userPhoneNumber);
                                Navigator.of(context).pushReplacementNamed(OTP_SCREEN);
                              },
                              elevation: 10.0,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            )),
                      ],
                    ),
                  ), //cardView
                ),

                new Container(),
              ]),
        ],
      ),
    ));
  }
}
