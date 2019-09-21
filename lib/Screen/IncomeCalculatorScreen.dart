import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pezeshk_yar/Constant/Constant.dart';
import 'package:pezeshk_yar/Constant/globalVariables.dart' as globalVariables;


class Calculator extends StatefulWidget {
  @override
  CalculatorPage createState() => CalculatorPage();
}

class CalculatorPage extends State<Calculator> {
  TextEditingController _taxValueController = new TextEditingController();
  TextEditingController _overHeadLessController = new TextEditingController();
  TextEditingController _lessMakerValueController = new TextEditingController();
  TextEditingController _kRateController = new TextEditingController();
  TextEditingController _totalKValueController = new TextEditingController();

  double _finalValue = 0.0;
  String _lastFinalValue = "";

  int _KTarrif = 0;
  getGlobalVariables() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _firstAnswer = preferences.getBool('first');
    bool _secondAnswer = preferences.getBool('second');
    bool _thirdAnswer = preferences.getBool('third');
    bool _forthAnswer = preferences.getBool('forth');
    String _fifthAnswer = preferences.getString('fifth');
    String _sixthAnswer = preferences.getString('sixth');


    if(_firstAnswer != null){
      globalVariables.globalFirstAnswer = _firstAnswer;
    }
    if(_secondAnswer != null){
      globalVariables.globalSecondAnswer = _secondAnswer;

    }
    if(_thirdAnswer != null){
      globalVariables.globalThirdAnswer = _thirdAnswer;

    }
    if(_forthAnswer != null){
      globalVariables.globalForthAnswer = _forthAnswer;

    }
    if(_fifthAnswer != null){
      globalVariables.globalFifthAnswer = _fifthAnswer;

    }
    if(_sixthAnswer != null){
      globalVariables.globalSixthAnswer = _sixthAnswer;

    }

    print("this is first: " + globalVariables.globalFirstAnswer.toString());
    print("second: " + globalVariables.globalSecondAnswer.toString());
    print(globalVariables.globalThirdAnswer.toString());
    print(globalVariables.globalForthAnswer.toString());
    print(globalVariables.globalFifthAnswer);
    print(globalVariables.globalSixthAnswer);


    setState(() {

    });






  }

  calculateIncome(){
    if(_taxValueController.text.isEmpty || _lessMakerValueController.text.isEmpty || _overHeadLessController.text.isEmpty || _kRateController.text.isEmpty || _totalKValueController.text.isEmpty){
      return new Text("please fill all fields");
    }
    _finalValue = (double.parse(_totalKValueController.text)) * (double.parse(_kRateController.text));
    if(globalVariables.globalSixthAnswer == "دولتی"){
      _finalValue = 0.9 * _finalValue;
    }
    _finalValue = _finalValue * ((100 - (double.parse(_overHeadLessController.text)))/100);
    _finalValue = _finalValue * ((100 - (double.parse(_taxValueController.text)))/100);
    _finalValue = (_finalValue - (double.parse(_lessMakerValueController.text)));

    _lastFinalValue = _finalValue.toStringAsFixed(2);

    return _lastFinalValue;

  }

  handleDefaults() {
    double a = 0.0;
    double b = 0.0;
    if(_totalKValueController.text.isNotEmpty) {a = double.parse(_totalKValueController.text);}
    if(_kRateController.text.isNotEmpty) {b = double.parse(_kRateController.text);}
    if(globalVariables.globalSixthAnswer == "دولتی"){
      _kRateController.text = "95200.0";
    }
    if(globalVariables.globalSixthAnswer == "خصوصی"){
      _kRateController.text = "412000.0";
    }
    if(globalVariables.globalSixthAnswer == "خیریه"){
      _kRateController.text = "206000.0";
    }
//کسر بالاسری
    double c = 0.0;
    double _final = 0.0;
    _final = a * b * 0.9;


    if (globalVariables.globalSixthAnswer == "دولتی") {
      if (_final < 100000) {
        if(globalVariables.globalSecondAnswer){
          //80%
          c = 0.8;
        }else{
          if(globalVariables.globalFirstAnswer){
            //65%
            c = 0.65;
          }else{
            //45%
            c = 0.45;
          }
        }

      }
      if (100000 <= _final && _final < 200000) {
        if(globalVariables.globalSecondAnswer){
          //60%
          c = 0.60;
        }else{
          if(globalVariables.globalFirstAnswer){
            //55%
            c = 0.55;
          }else{
            //40%
            c = 0.40;
          }
        }

      }
      if (200000 <= _final && _final < 300000) {
        if(globalVariables.globalSecondAnswer){
          //50%
          c = 0.50;
        }else{
          if(globalVariables.globalFirstAnswer){
            //45%
            c = 0.45;
          }else{
            //35%
            c = 0.35;
          }
        }

      }
      if (300000 <= _final && _final < 400000){
        if(globalVariables.globalSecondAnswer){
          //40%
          c = 0.40;
        }else{
          if(globalVariables.globalFirstAnswer){
            //35%
            c = 0.35;
          }else{
            //30%
            c = 0.30;
          }
        }

      }
      if(400000 <= _final){
        if(globalVariables.globalSecondAnswer){
          //35%
          c = 0.35;
        }else{
          if(globalVariables.globalFirstAnswer){
            //30%
            c = 0.30;
          }else{
            //30%
            c = 0.30;
          }
        }

      }
      if(globalVariables.globalThirdAnswer){

        _taxValueController.text = '10.0';
      }else{
        _taxValueController.text = '20.0';
      }
      _overHeadLessController.text = (c*100).toString();

    }
    if(globalVariables.globalSixthAnswer == "خصوصی"){
      _taxValueController.text = "20.0";
    }




//    _final = _final * c;




//    c = c*100;
  }





  @override
  void initState() {

    super.initState();
    getGlobalVariables();
    handleDefaults();

  }

  //  @override





//  void initState() {
//    super.initState();
//    getData();
//    if(_KTarrif != 0){
//      return;
//    }else{
//
//    }
//  } //  String dropdownValue = 'انتخاب کنید';



  getData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _sixthAnswer = sharedPreferences.getString('sixth');

    _sixthAnswer == "دولتی"?  _KTarrif = 95200 : _sixthAnswer == "خصوصی"? _KTarrif = 412000 : _sixthAnswer == "خیریه"? _KTarrif = 206000 : _KTarrif = 0;

  }


  void _openAddEntryDialog() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new AddEntryDialog();
        },
        fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    handleDefaults();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "محاسبه کارانه",
          maxLines: 1,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: Color.fromRGBO(123, 202, 204, 10),
      ),
      body: new Card(
        elevation: 10.0,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Row(
//                        children: <Widget>[
//                          new Text(" مقدار K: "),
//                          new TextField(
//                            controller: _totalKValueController,
//                            keyboardType: TextInputType.number,
//                          ),
//                        ],
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Row(
//                        children: <Widget>[
//                          new Text(" تعرفه k: "),
//                          new TextField(
//                            controller: _kRateController,
//                            keyboardType: TextInputType.number,
//                          ),
//                        ],
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: new TextField(),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Row(
//                        children: <Widget>[
//                          new Text(" میزان کسورات: "),
//                          new TextField(
//                            controller: _lessMakerValueController,
//                            keyboardType: TextInputType.number,
//                          ),
//                        ],
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Row(
//                        children: <Widget>[
//                          new Text(" کسر بالاسری: "),
//                          new TextField(
//                            controller: _overHeadLessController,
//                            keyboardType: TextInputType.number,
//                          ),
//                        ],
//                      ),
//                    ),

                    Card(elevation: 10.0,margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            new Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.assignment_turned_in,color: Colors.blue,),
                                    hintText: "مقدار K",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Shabnam',
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  controller: _totalKValueController,
                                  enabled: true,
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            new Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.assignment,color: Colors.blue,),
                                    hintText: "تعرفه K",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Shabnam',
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  controller: _kRateController,
                                  enabled: true,
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),



                            new Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.assessment,color: Colors.blue,),
                                    hintText: "کسر بالاسری (درصد)",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Shabnam',
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  controller: _overHeadLessController,
                                  enabled: true,
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),

                            new Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.assignment_late,color: Colors.blue,),
                                    hintText: "میزان مالیات (درصد)",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Shabnam',
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  controller: _taxValueController,
                                  enabled: true,
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            new Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.assignment_returned,color: Colors.blue,),
                                    hintText: "میزان کسورات (ریال)",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Shabnam',
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  controller: _lessMakerValueController,
                                  enabled: true,
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),



//                    new SizedBox(
//                      height: 30.0,
//                    ),

                    new Container(margin: EdgeInsets.all(8.0),
                      child: new Card(
                        elevation: 15.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Icon(
                                Icons.account_balance_wallet,
                                color: Colors.blue,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                "مقدار نهایی (ریال): ",
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(_lastFinalValue),
                            )
                          ],
                        ),
                      ),
                    ),

//                    new SizedBox(
//                      height: 30.0,
//                    ),

                    Container(
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new RaisedButton(
                            onPressed: () {
                              calculateIncome();
                              setState(() {});
                            },
                            padding: EdgeInsets.all(8.0),
                            color: Colors.blue,
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            child: new Text(
                              "محاسبه کارانه",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          new SizedBox(
                            width: 20.0,
                          ),
                          new RaisedButton(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.blue,
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            child: new Text(
                              "ثبت داده های پیش فرض",
                              maxLines: 1,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _openAddEntryDialog();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddEntryDialog extends StatefulWidget {
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  bool isCommonDoctor = globalVariables.globalFirstAnswer;
  bool isFullTime = globalVariables.globalSecondAnswer;
  bool isSientificMember = globalVariables.globalThirdAnswer;
  bool isFellowShip = globalVariables.globalForthAnswer;

  String _dropdownValue = globalVariables.globalFifthAnswer;
  String _dropdownValue1 =  globalVariables.globalSixthAnswer;

  final List<String> _dropdownValuesSkill = [
    "مغز و اعصاب",
    "جراحی مغز و اعصاب",
    "اعصاب و روان(روانپزشک)",
    "گوش و حلق و بینی",
    "چشم پزشک",
    "دندانپزشک",
    "متخصص داخلی",
    "متخصص قلب و عروق",
    "جراحی قلب",
    "جراحی",
    "کلیه و مجاری ادراری",
    "پوست و مو",
    "زنان و زایمان",
    "ارتوپدی",
    "اطفال",
    "طب اورژانس",
    "طب فیزیکی و توانبخشی",
    "طب ورزشی",
    "طب کار",
    "رادیولوژی",
    "عفونی و گرمسیری",
    "پرتو درمانی",
    "پزشکی هسته ای",
    "آسم و آلرژی",
    "آسیب شناسی",
    "پزشکی قانونی و مسمومیت ها"
  ];

  final List<String> _dropdownValuesOrganization = ["دولتی", "خصوصی", "خیریه"];


  @override
  void initState() {
    super.initState();
//    getSavedValues();

//    getGlobalVariables();
  }

  removeValues()async{

  }

  getSavedValues() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _firstAnswer = preferences.getBool('first');
    bool _secondAnswer = preferences.getBool('second');
    bool _thirdAnswer = preferences.getBool('third');
    bool _forthAnswer = preferences.getBool('forth');
    String _fifthAnswer = preferences.getString('fifth');
    String _sixthAnswer = preferences.getString('sixth');


    if(isCommonDoctor == null){
      isCommonDoctor = false;
    }else{
      isCommonDoctor = _firstAnswer;
    }
    if(isFullTime == null){
      isFullTime = false;
    }else{
      isFullTime = _secondAnswer;

    }
    if(isSientificMember == null){
      isSientificMember = false;
    }else{
      isSientificMember = _thirdAnswer;

    }

    if(isFellowShip == null){
      isFellowShip = false;
    }else{
      isFellowShip = _forthAnswer;

    }

    if(_dropdownValue.isEmpty){
      _dropdownValue = "انتخاب کنید";
    }else{
      _dropdownValue = _fifthAnswer;

    }

    if(_dropdownValue1.isEmpty){
      _dropdownValue1 = "انتخاب کنید";
    }else{
      _dropdownValue1 = _sixthAnswer;

    }
//    _dropdownValue1 = _sixthAnswer;
//    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
//    setState(() {});
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(123, 202, 204, 10.0),
        title: const Text(
          'داده های ورودی',
          style: TextStyle(fontSize: 16.0),
        ),
        actions: [
//          new FlatButton(
//              onPressed: () {
//                //TODO: Handle save
//              },
//              child: new Text('ذخیره',
//                  style: Theme
//                      .of(context)
//                      .textTheme
//                      .subhead
//                      .copyWith(color: Colors.white))),
        ],
      ),
      body: Container(
        child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.all(8.0),
        elevation: 10.0,
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "لطفا به سوالات زیر پاسخ دهید",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                )),

            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
//                          SizedBox(width: 10.0,),
                  Container(
                      margin: EdgeInsets.only(left: 4.0),
                      child: new Text(
                        "پزشک عمومی هستید؟",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.right,
                      )),
//                          SizedBox(width: 50.0,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("خیر"),
                        new Switch(
                          value: isCommonDoctor,
                          onChanged: (value) {
                            setState(() {
                              isCommonDoctor = value;
                            });
                          },
                          activeTrackColor: Colors.lightBlue,
                          activeColor: Colors.blue,
                        ),
                        new Text("بله"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
//                          SizedBox(width: 10.0,),
                  Container(
                      margin: EdgeInsets.only(left: 4.0),
                      child: new Text(
                        "فعالیت تمام وقت دارید؟",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.right,
                      )),
//                          SizedBox(width: 40.0,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("خیر"),
                        new Switch(
                          value: isFullTime,
                          onChanged: (value) {
                            setState(() {
                              isFullTime = value;
                            });
                          },
                          activeTrackColor: Colors.lightBlue,
                          activeColor: Colors.blue,
                        ),
                        new Text("بله"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
//                          SizedBox(width: 10.0,),
                  Container(
                      margin: EdgeInsets.only(left: 4.0),
                      child: new Text(
                        "عضو هیئت علمی هستید؟",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.right,
                      )),
//                          SizedBox(width: 30.0,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("خیر"),
                        new Switch(
                          value: isSientificMember,
                          onChanged: (value) {
                            setState(() {
                              isSientificMember = value;
                            });
                          },
                          activeTrackColor: Colors.lightBlue,
                          activeColor: Colors.blue,
                        ),
                        new Text("بله"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
//                          SizedBox(width: 10.0,),
                  Container(
                      margin: EdgeInsets.only(left: 4.0),
                      child: new Text(
                        "فوق تخصص ویا فلوشیپ؟",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.right,
                      )),
//                          SizedBox(width: 30.0,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("خیر"),
                        new Switch(
                          value: isFellowShip,
                          onChanged: (value) {
                            setState(() {
                              isFellowShip = value;
                            });
                          },
                          activeTrackColor: Colors.lightBlue,
                          activeColor: Colors.blue,
                        ),
                        new Text("بله"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text("عنوان تخصص: "),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: DropdownButton<String>(
                        value: _dropdownValue,
                        elevation: 10,
                        underline: Container(height: 2,color: Colors.blue,),
                        onChanged: (String newValue) {
                          setState(() {
                            _dropdownValue = newValue;
                          });
                        },
                        items: <String>["انتخاب کنید","مغز و اعصاب",
                          "جراحی مغز و اعصاب",
                          "اعصاب و روان(روانپزشک)",
                          "گوش و حلق و بینی",
                          "چشم پزشک",
                          "دندانپزشک",
                          "متخصص داخلی",
                          "متخصص قلب و عروق",
                          "جراحی قلب",
                          "جراحی",
                          "کلیه و مجاری ادراری",
                          "پوست و مو",
                          "زنان و زایمان",
                          "ارتوپدی",
                          "اطفال",
                          "طب اورژانس",
                          "طب فیزیکی و توانبخشی",
                          "طب ورزشی",
                          "طب کار",
                          "رادیولوژی",
                          "عفونی و گرمسیری",
                          "پرتو درمانی",
                          "پزشکی هسته ای",
                          "آسم و آلرژی",
                          "آسیب شناسی",
                          "پزشکی قانونی و مسمومیت ها"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )



//                          DropdownButton(
////                            value: _dropdownValue,
//                            items: _dropdownValuesSkill
//                                .map((value) => DropdownMenuItem(
//                                      child: Text(value),
//                                      value: value,
//                                    ))
//                                .toList(),
//                            onChanged: (String value) {},
//                            isExpanded: false,
//                            hint: Text(
//                              "انتخاب کنید",
//                              textAlign: TextAlign.center,
//                            ),
//                          ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: new Text("نوع مرکز ارائه خدمت: ")),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  DropdownButton<String>(
                    value: _dropdownValue1,
                    elevation: 10,
                    underline: Container(height: 2,color: Colors.blue,),
                    onChanged: (String newValue) {
                      setState(() {
                        _dropdownValue1 = newValue;
                      });
                    },
                    items: <String>["انتخاب کنید",
                      "دولتی", "خصوصی", "خیریه"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )






//                        DropdownButton<String>(
////                          value: _dropdownValue1,
//                          onChanged: (String newValue) {
//                            setState(() {
//                              _dropdownValue1 = newValue;
//                            });
//                          },
//                          items: _dropdownValuesOrganization
//                              .map((value) => DropdownMenuItem(
//                                    child: Text(value),
//                                    value: value,
//                                  ))
//                              .toList(),
//
//                          isExpanded: false,
//                          hint: Text("انتخاب کنید"),
//                        ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: new RaisedButton(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(
                  'ذخیره اطلاعات',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  addFirstQuestion();
                  addSecondQuestion();
                  addThirdQuestion();
                  addForthQuestion();
                  addFifthQuestion();
                  addSixthQuestion();
                  Navigator.of(context).popAndPushNamed(INCOME_CALCULATOR_SCREEN);
//                  setState(() {});


                },

              ),
            ),
          ],
        ),
      ),
      ),
    );
  }





  addFirstQuestion() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('first', isCommonDoctor);
  }
  addSecondQuestion() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('second', isFullTime);
  }
  addThirdQuestion() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('third', isSientificMember);
  }
  addForthQuestion() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('forth', isFellowShip);
  }
  addFifthQuestion() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('fifth', _dropdownValue);
  }
  addSixthQuestion() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('sixth', _dropdownValue1);
  }





}
