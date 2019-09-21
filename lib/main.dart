import 'dart:async';

import 'package:pezeshk_yar/Screen/LoginScreen.dart';
import 'package:pezeshk_yar/Screen/OTPScreen.dart';
import 'package:pezeshk_yar/Screen/SavedCodeScreen.dart';
import 'Package:pezeshk_yar/Screen/DescriptionScreen.dart';
import 'Constant/Constant.dart';
import 'Screen/AnimatedSplashScreen.dart';
import 'Screen/HomePage.dart';
import 'Screen/ImageSplashScreen.dart';
import 'Screen/SearchCodeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pezeshk_yar/Screen/IncomeCalculatorScreen.dart';


Future main() async {
  runApp(new MaterialApp(
    localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate,],
    supportedLocales: [Locale("fa", "IR"),],
    locale: Locale("fa", "IR"),
    title: 'PezeshkYar',
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      //brightness: Brightness.dark,
      primaryColor: Colors.blueGrey,
      //accentColor: Colors.blueGrey,
      primarySwatch: Colors.blueGrey,


      fontFamily: 'Shabnam',
      textTheme: TextTheme(
        headline: TextStyle(fontFamily: 'Shabnam'),
        title: TextStyle(fontFamily: 'Shabnam')
      ),
    ),
    home: new AnimatedSplashScreen(),
    routes: <String, WidgetBuilder>{
      HOME_SCREEN: (BuildContext context) => new HomeScreen(),
      IMAGE_SPLASH: (BuildContext context) => new ImageSplashScreen(),
      ANIMATED_SPALSH: (BuildContext context) => new AnimatedSplashScreen(),
      LOGIN_SCREEN: (BuildContext context) => new LoginScreen(),
      OTP_SCREEN: (BuildContext context) => new OtpPage(),
      SEARCH_SCREEN: (BuildContext context) => new SearchCode(),
      SAVED_SCREEN: (BuildContext context) => new SavedCode(),
      DESCRIPTION_SCREEN: (BuildContext context) => new Description(),
      INCOME_CALCULATOR_SCREEN: (BuildContext context) => new Calculator()

    },
  ));
}

