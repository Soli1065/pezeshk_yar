import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pezeshk_yar/Constant/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pezeshk_yar/Constant/globalVariables.dart' as globalVariables;
import 'dart:async';
class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, checkLoggedIn);
  }

  Future checkLoggedIn() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _loggedIn = (preferences.getBool('logged')?? false);

    if(_loggedIn){
      Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
    } else {
      preferences.setBool('logged', true);
      Navigator.of(context).pushReplacementNamed(LOGIN_SCREEN);
    }
  }

  void navigationPage() {


  }

  @override
  void initState() {
    super.initState();


//    animationController = new AnimationController(
//        vsync: this, duration: new Duration(seconds: 4));
//    animation =
//        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
//
//    animation.addListener(() => this.setState(() {}));
//    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(123, 202, 204, 10.0),
      body: new Container(
        child: new Column(mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            new Card(
              margin: EdgeInsets.only(right: 50.0,left: 50.0,bottom: 20.0),
              elevation: 15.0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Row(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    new Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              image: DecorationImage(
                                  image: AssetImage('assets/images/image.jpg'),fit: BoxFit.fill),),
                          ),
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        " پزشک یار ",
                        style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.blue,
                            fontFamily: 'Shabnam'
                        ),
                      ),
                    ),


                  ],
                ),
              ),

//                child: new Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    new Text(" پزشک یار ",style: TextStyle(fontSize: 28.0,color: Colors.blue ,),),
//                    new Image.asset('assets/images/image.jpg',height: 80.0,width: 120.0,)
//                  ],
//                ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child:
                Padding(
                  padding: const EdgeInsets.all(18.0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //SpinKitWave(color: Colors.white, type: SpinKitWaveType.start),
                      SpinKitWave(color: Colors.white, type: SpinKitWaveType.center),
                      //SpinKitWave(color: Colors.white, type: SpinKitWaveType.end),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
//      Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//              image: AssetImage("assets/images/background.jpg"),
//              fit: BoxFit.cover,
//          ),
//        ),
//        child: Stack(
//          fit: StackFit.expand,
//          children: <Widget>[
//            new Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//
//                Padding(
//                    padding: EdgeInsets.only(
//                        bottom: 30.0),
//                    child:new Image.asset(
//                      'assets/images/logo.png',
//                      height: 50.0,width: 150.0,
//                      fit: BoxFit.scaleDown,)
//                )
//            ],),
//            new Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                new Image.asset(
//                  'assets/images/image.jpg',
//                  width: animation.value * 150,
//                  height: animation.value * 150,
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
    );
  }
}
