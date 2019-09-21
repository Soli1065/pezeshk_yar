import 'package:flutter/material.dart';
import 'package:pezeshk_yar/Constant/Constant.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [

    ];

    return Scaffold(

        backgroundColor: Colors.white,
        body:ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[


                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 60.0),

                  child: Image(

                    image: AssetImage('assets/images/logo.png'),
                    height: 100.0,
                    width: 100.0,),
                ),//Image-logo

                Padding(padding:EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                    ],

                  ),

    ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 20.0, right: 16.0),
                  child: Text("شماره تلفن خود را وارد کنید ",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,),
                ),// Text-Enter Phone Number



                Row(
                  children: <Widget>[

                    Flexible(
                      child: new Container(
                      ),
                      flex: 1,
                    ),

                    Flexible(
                      child: new TextFormField(
                        textAlign: TextAlign.center,
                        autofocus: false,
                        enabled: false,
                        initialValue: "+98",
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                      flex: 3,
                    ),

                    Flexible(
                      child: new Container(
                      ),
                      flex: 1,
                    ),

                    Flexible(
                      child: new TextFormField(
                        textAlign: TextAlign.start,
                        autofocus: false,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                      flex: 9,
                    ),

                    Flexible(
                      child: new Container(
                      ),
                      flex: 1,
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: new Container (
                    width: 150.0,
                    height: 40.0,
                    child: new RaisedButton(onPressed: () {
                      Navigator.of(context).pushNamed(OTP_SCREEN);
                    },
                        child: Text("دریافت کد "),
                        textColor: Colors.white,
                        color: Colors.green,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))
                    ),
                  ),
                )
              ]
          )],)
    );
    // TODO: implement build
  }

}