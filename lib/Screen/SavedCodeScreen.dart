import 'package:flutter/material.dart';
import 'package:jalali_date/jalali_date.dart';
import 'package:pezeshk_yar/Screen/twopanels.dart';

import 'package:expandable/expandable.dart';

//import 'package:backdrop/backdrop.dart';
import 'package:pezeshk_yar/Constant/Constant.dart';
//import 'Database.dart';
//import 'CodeNewModel.dart';
import 'package:pezeshk_yar/Screen/CodeNewModel.dart';
import 'package:pezeshk_yar/Screen/Database.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SavedCode extends StatefulWidget {
  @override
  _SavedCodeState createState() => _SavedCodeState();
}

class _SavedCodeState extends State<SavedCode>
    with SingleTickerProviderStateMixin {
//  _ShowCodeDetails _showCodeDetails;









  List<CodeNew> _searchCodes = [];

  bool _searchFlag = false;


  PanelController _panelController = new PanelController();

  TabController _tabController;
  String _codeSumDay = '0';
  String _codeSumMonth = '0';
  String _codeSumRange = '0';

  double _sumOfTodayK = 0.0;
  double _sumOfMonthk = 0.0;
  double _sumOfAll = 0.0;

  String _sumOfAllFinal = " ";
  String _sumOfMonthFinal = " ";
  String _sumOfDayFinal = " ";

  TextEditingController _patientNameController = new TextEditingController();
  TextEditingController _caseNumberController = new TextEditingController();
  TextEditingController _codeIdController = new TextEditingController();
  TextEditingController _datePickerController = new TextEditingController();

  TextEditingController _toDateController = new TextEditingController();
  TextEditingController _fromDateController = new TextEditingController();
  PersianDatePickerWidget persianDatePicker0;
  PersianDatePickerWidget persianDatePicker1;
  bool _flagTodaySum;
  bool flagmonth = false;

  void _categoryCodes() async{
    var list = await DBProvider.db.getTodayCodeNews();
    int sum = 0;


  }

  void _displaySum() async {
    var list = await DBProvider.db.getAllCodeNews();
    var list1 = await DBProvider.db.getTodayCodeNews();
    var list2 = await DBProvider.db.getMonthCodeNews();
    _codeSumRange = list.length.toString();
    _codeSumDay = list1.length.toString();
    _codeSumMonth = list2.length.toString();

    List<CodeNew> _listToday = [];
    _listToday = list1;
    List<CodeNew> _listMonth = list2;
    List<CodeNew> _listAll = list;
    print('hello');
    print(_sumOfTodayK);
    if (_listToday.length == 0) {
      _sumOfDayFinal = "0.0";
    } else {
      _sumOfTodayK = 0.00;
      for (var i = 0; i < _listToday.length; i++) {
        double dayDouble = double.tryParse(_listToday[i].proRate);

        _sumOfTodayK = dayDouble + _sumOfTodayK;
        _sumOfDayFinal = _sumOfTodayK.toStringAsFixed(2);
      }
    }

    if (_listMonth.length == 0) {
      _sumOfMonthFinal = '0.0';
    } else {
      _sumOfMonthk = 0.00;
      for (var j = 0; j < _listMonth.length; j++) {
        double monthDouble = double.tryParse(_listMonth[j].proRate);
        _sumOfMonthk = monthDouble + _sumOfMonthk;
        _sumOfMonthFinal = _sumOfMonthk.toStringAsFixed(2);
      }
    }

    if (_listAll.length == 0) {
      _sumOfAllFinal = '0.0';
    } else {
      _sumOfAll = 0.00;
      for (var k = 0; k < _listAll.length; k++) {
        double allDouble = double.tryParse(_listAll[k].proRate);
        _sumOfAll = allDouble + _sumOfAll;
        _sumOfAllFinal = _sumOfAll.toStringAsFixed(2);
      }
    }

//    _sumOfAllFinal =  _sumOfAll.toString();
//    _sumOfAllFinal = _sumOfAllFinal.to

    setState(() {});
  }

  void _displayK() async {}

  void _getRightCodes() async{
//    var list =  DBProvider.db.getSearchedCodes(name, caseNum, codeId, toDate, fromDate);

  }


  @override
  void initState() {
    super.initState();

//    _showCodeDetails = _ShowCodeDetails();

    _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabIndex);
    _flagTodaySum = true;

    persianDatePicker0 = PersianDatePicker(
      controller: _fromDateController,
      onChange: (String oldText, String newText){
        oldText = newText;
      }
    ).init();

    persianDatePicker1 = PersianDatePicker(
        controller: _toDateController,
        onChange: (String oldText, String newText) {
          oldText = newText;
//          print(newText);
//          print(oldText);
        }).init();

    _displaySum();
  }

//  void callback(){
//    _displaySum();
//    initState();
//    build(context);
////    setState(() {});
//  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
//    _fromDateController.dispose();
//    _toDateController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //List<Widget> widgetList = [];

//    return MaterialApp(

//
//      debugShowChetheme: ThemeData(
////        brightness: Brightness.dark,
////        primaryColor: Color.fromRGBO(123, 202, 204, 10.0),
////        accentColor: Color.fromRGBO(123, 202, 204, 10.0)
//          ),ckedModeBanner: false,
//      home:
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(preferredSize: Size.fromHeight(135.0),
        child: AppBar(
          backgroundColor: Color.fromRGBO(123, 202, 204, 10.0),
          title: Text(
            "کدهای ذخیره شده",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Shabnam',
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.today,
                  color: Colors.white,
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "روزانه",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontFamily: 'Shabnam', color: Colors.white),
                    ),
                    new Container(
                      margin: EdgeInsets.only(right: 4.0, left: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: new Center(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(_codeSumDay),
                        ),
                      ),
                    ),
                  ],
                ),
//                  icon: Icon(Icons.today),
//                  text: "روزانه",
              ),
              Tab(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "ماهانه",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontFamily: 'Shabnam', color: Colors.white),
                    ),
                    new Container(
                      margin: EdgeInsets.only(right: 4.0, left: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: new Center(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(_codeSumMonth),
                        ),
                      ),
                    ),
                  ],
                ),
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.calendar_view_day,
                  color: Colors.white,
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "همه کدها",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontFamily: 'Shabnam', color: Colors.white),
                    ),
                    new Container(
                      margin: EdgeInsets.only(right: 4.0, left: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: new Center(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(_codeSumRange),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Column(
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new Container(
                    height: 72.0,
                    margin: EdgeInsets.only(bottom: 2.0),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(78, 162, 162, 10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 2.0),
                              child: new Icon(
                                Icons.playlist_add_check,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: new Text(
                                " مجموع کل  K : ",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Shabnam'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: new Text(
                                      _sumOfDayFinal,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Shabnam',
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Icon(
                                Icons.today,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Text(
                                "امروز: ",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red[400],
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: new Text(
                                  PersianDate.fromDateTime(
                                      DateTime.parse(DateTime.now().toString()))
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                new Expanded(
                    flex: 8,
                    child: new Container(
                      child: new
                          //Today Saved codes List
                          Padding(
                        padding: const EdgeInsets.only(
                            right: 4.0, left: 4.0, top: 2.0, bottom: 4.0),
                        child: new FutureBuilder<List<CodeNew>>(
                          future: DBProvider.db.getTodayCodeNews(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<CodeNew>> snapshot) {
                            if (snapshot.hasData) {
                              return new ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  CodeNew item = snapshot.data[index];

//                                      for(var i = 0; i < snapshot.data.length; i++){
//                                        if(_flagTodaySum){
//                                          _sumOfTodayK = double.tryParse(item.proRate) + _sumOfTodayK;
//
//                                        }
//                                        _flagTodaySum = false;
//
//                                      }

//                                      _sumOfTodayK = double.tryParse(item.proRate) + _sumOfTodayK;

                                  return new Card(
                                    elevation: 8.0,
                                    child: new Container(
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

//                                          Container(margin: EdgeInsets.only(top: 4.0),
//                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                              children: <Widget>[
////                                                new Text(
////                                                  "کد شماره: " + item.codeId,
////                                                  textAlign: TextAlign.right,
////                                                  style: TextStyle(
////                                                      fontFamily: 'Shabnam'),
////                                                ),
//
//                                                new Container(margin: EdgeInsets.only(left: 8.0),
////                                                        child: Row(
////                                                          children: <Widget>[
////                                                            new Container(child: new IconButton(icon: Icon(Icons.keyboard_arrow_down,size: 30.0,color: Colors.blue,),
////                                                                onPressed: null),),
////
////                                                            new Container(decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
////                                                              child: Padding(
////                                                                padding: const EdgeInsets.all(8.0),
////                                                                child: new Text("1"),
////                                                              ),),
////
////
////
////                                                    ],
////                                                  ),
//                                                ),
//                                              ],
//                                            ),
//                                          ),
                                          _ShowCodeDetails(codeId: item.codeId, date: item.date,time: item.time,id: item.id, name: item.name,caseNum: item.caseNum,),

                                          Container(
                                              child: new _ShowMoreText(text: item.data)
//                                            new Text(
//                                              item.data,
//                                              textAlign: TextAlign.right,
//                                              style: TextStyle(fontFamily: 'Shabnam'),
//                                            ),
                                          ),
                                        ],
                                      ),
//                                      subtitle: Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceBetween,
//                                        children: <Widget>[
//                                          Container(
//                                            child: new Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                              children: <Widget>[
//
//
//                                                new Text(
//                                                  "تاریخ ثبت: " +
//                                                      item.time +
//                                                      " , " +
//                                                      item.date,
//                                                  textAlign: TextAlign.right,
//                                                  style: TextStyle(
//                                                      fontFamily: 'Shabnam'),
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//
//                                          Container(
//                                            child: IconButton(
//                                              icon: Icon(Icons.delete_forever),
//                                              onPressed: () async {
//                                                DBProvider.db
//                                                    .deleteCodeNew(item.id);
//                                                _displaySum();
//                                                setState(() {});
//                                              },
//                                            ),
//                                          ),
//                                        ],
//                                      ),
                                    ),
                                    margin: const EdgeInsets.all(4.0),
                                  );
                                },
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ))
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Column(
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new Container(
                    height: 72.0,
                    margin: EdgeInsets.only(bottom: 2.0),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(78, 162, 162, 10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 2.0),
                              child: new Icon(
                                Icons.playlist_add_check,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: new Text(
                                " مجموع کل K :",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Shabnam'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: new Text(
                                      _sumOfMonthFinal,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Shabnam',
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Icon(
                                Icons.today,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Text(
                                "امروز: ",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red[400],
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: new Text(
                                  PersianDate.fromDateTime(
                                      DateTime.parse(DateTime.now().toString()))
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                new Expanded(
                    flex: 8,
                    child: new Container(
                      child: //This month Saved codes
                          Padding(
                        padding: const EdgeInsets.only(
                            right: 4.0, left: 4.0, top: 2.0, bottom: 4.0),
                        child: new FutureBuilder<List<CodeNew>>(
                          future: DBProvider.db.getMonthCodeNews(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<CodeNew>> snapshot) {
                            if (snapshot.hasData) {
                              return new ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  CodeNew item = snapshot.data[index];
                                  return new Card(
                                    elevation: 8.0,
                                    child: new Container(
                                      child: Column(
                                        children: <Widget>[

//                                          Container(margin: EdgeInsets.only(left: 8.0),
//
//                                          ),
                                          _ShowCodeDetails(codeId: item.codeId,date: item.date,time: item.time,id: item.id,name: item.name, caseNum: item.caseNum,),

                                          Container(
                                            child: new _ShowMoreText(
                                              text: item.data,
                                            ),
                                          ),
                                        ],
                                      ),

                                    ),
                                    margin: const EdgeInsets.all(4.0),
                                  );
                                },
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ))
              ],
            ),
          ),

          new Container(
            child: new Column(
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new Container(
                    height: 72.0,
//                    margin: EdgeInsets.only(bottom: 2.0),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(78, 162, 162, 10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(mainAxisAlignment:  MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 2.0),
                              child: new Icon(
                                Icons.playlist_add_check,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: new Text(
                                " مجموع کل K :",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Shabnam'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: new Text(
                                      _sumOfAllFinal,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Shabnam',
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Icon(
                                Icons.today,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Text(
                                "امروز: ",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red[400],
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: new Text(
                                  PersianDate.fromDateTime(
                                      DateTime.parse(DateTime.now().toString()))
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                new Expanded(
                    flex: 8,
                    child: SlidingUpPanel(
                      renderPanelSheet: false,
                      controller: _panelController,
                      margin: EdgeInsets.only(top: 6.0),
                      maxHeight: 350.0,
                      minHeight: 50.0,
                      backdropEnabled: true,
                      panel: Container(
                        margin:
                            EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(123, 202, 204, 1.0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                        ),
                        child: SingleChildScrollView(
                          child: new Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    right: 10.0, left: 10.0, top: 10.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: new Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0,
                                              bottom: 2.0,
                                              right: 4.0,
                                              left: 4.0),
                                          child: new Text(
                                            "بر اساس تاریخ:  ",
                                            style: TextStyle(
                                                fontFamily: 'Shabnam',
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0,
                                              bottom: 2.0,
                                              left: 4.0,
                                              right: 4.0),
                                          child: new Icon(
                                            Icons.date_range,
                                            color: Colors.white,
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0,
                                              bottom: 2.0,
                                              left: 4.0,
                                              right: 4.0),
                                          child: new Container(
                                              width: 85.0,
                                              height: 25.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0)),
                                              child: TextField(
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText: 'انتخاب کنید',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                textAlign: TextAlign.center,
                                                enableInteractiveSelection:
                                                    false,
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());

                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return persianDatePicker0;
                                                      });
                                                },
                                                controller: _fromDateController,
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0,
                                              bottom: 2.0,
                                              left: 4.0,
                                              right: 4.0),
//                                          child: new IconButton(icon: Icon(Icons.cancel),color: Colors.white,onPressed: () {
//                                            _fromDateController = null;
//                                          },
//
//                                          ),
                                        ),



//                                        Column(
//                                          children: <Widget>[
//                                            new Container(child: PersianDatePickerWidget(),),
//                                            new TextField(
//                                              onTap: (){
//                                                FocusScope.of(context).requestFocus(new FocusNode());
//                                              },
//                                              enableInteractiveSelection: false,
//                                              controller: _datePickerController,
//                                            )
//                                          ],
//                                        ),

//                                        Padding(
//                                          padding: const EdgeInsets.only(
//                                              top: 2.0,
//                                              bottom: 2.0,
//                                              right: 4.0,
//                                              left: 4.0),
//                                          child: new Text(
//                                            "تا",
//                                            style: TextStyle(
//                                                fontFamily: 'Shabnam',
//                                                color: Colors.white),
//                                          ),
//                                        ),
//                                        Padding(
//                                          padding: const EdgeInsets.only(
//                                              top: 2.0,
//                                              bottom: 2.0,
//                                              right: 4.0,
//                                              left: 4.0),
//                                          child: new Icon(
//                                            Icons.date_range,
//                                            color: Colors.white,
//                                          ),
//                                        ),
//
//                                        Padding(
//                                          padding: const EdgeInsets.only(
//                                              top: 2.0,
//                                              bottom: 2.0,
//                                              left: 4.0,
//                                              right: 4.0),
//                                          child: Container(
//                                            height: 20.0,
//                                            width: 85.0,
//                                            child: TextField(
//                                              decoration: InputDecoration(
//                                                  hintText: 'انتخاب کنید',
//                                                  hintStyle: TextStyle(
//                                                      fontSize: 12.0)),
//                                              textAlign: TextAlign.center,
//                                              style: TextStyle(
//                                                  color: Colors.white,
//                                                  fontSize: 14.0),
//                                              enableInteractiveSelection: false,
//                                              onTap: () {
//                                                FocusScope.of(context)
//                                                    .requestFocus(
//                                                        new FocusNode());
//                                                showModalBottomSheet(
//                                                    context: context,
//                                                    builder:
//                                                        (BuildContext context) {
//                                                      return persianDatePicker1;
//                                                    });
//                                              },
//                                              controller: _toDateController,
//                                            ),
//                                          ),
//                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 10.0, left: 10.0),
                                  child: new TextField(
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.assignment_ind,
                                          color: Colors.white,
                                        ),
                                        hintText: "نام بیمار",
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Shabnam',
                                            fontSize: 16)),
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                  controller: _patientNameController,
//                                    enabled: true,
//                                    autofocus: false,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10.0, left: 10.0, right: 10.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: new TextField(
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.assignment,
                                          color: Colors.white,
                                        ),
                                        hintText: "شماره پرونده",
                                        hintStyle: TextStyle(
                                            fontFamily: 'Shabnam',
                                            color: Colors.white)),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                  controller: _caseNumberController,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: new TextField(
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.assignment_turned_in,
                                          color: Colors.white,
                                        ),
                                        hintText: "شماره کد",
                                        hintStyle: TextStyle(
                                            fontFamily: 'Shabnam',
                                            color: Colors.white)),
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    textAlign: TextAlign.right,
                                  controller: _codeIdController,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 10.0,
                                      left: 6.0,
                                      right: 6.0),
                                  child: new RaisedButton(
                                    onPressed: () async{
//                                      _getRightCodes();
                                    String name = _patientNameController.text.toString();
                                    String caseNum = _caseNumberController.text.toString();
                                    String codeId = _codeIdController.text.toString();
//                                    String toDate = _toDateController.text.toString();

                                      String yearDate = _fromDateController.text;

                                      String monthDate = _fromDateController.text;

                                      String dayDate = _fromDateController.text;



                                      if(_fromDateController.text.length > 0){

                                        yearDate = _fromDateController.text.substring(0,4);

                                        monthDate = _fromDateController.text.substring(5,8);

                                        dayDate = _fromDateController.text.substring(8,10);

                                        if(monthDate != '10'){
                                        if(monthDate != '11'){
                                          if(monthDate != '12'){

                                            monthDate = _fromDateController.text.substring(5,7);
                                            flagmonth = true;

                                          }
                                        }
                                      }

                                      if(flagmonth){

                                        dayDate = _fromDateController.text.substring(8,10);

                                      }else{

                                        dayDate = _fromDateController.text.substring(8,10);

                                      }

                                    }
                                    bool flagday = false;




//                                    String fromDate = _fromDateController.text.toString();
                                    print("year: " + yearDate);
                                    print("month: " + monthDate);
                                    print("day: " + dayDate);

                                    String allValues =  name;
                                    allValues += caseNum;
                                    allValues += codeId;
                                    allValues += yearDate;
//                                    allValues += toDate;
//                                    allValues += fromDate;
                                    print("allValues" + allValues);
                                    if(allValues.isEmpty){
                                      return;
                                    }

                                      var list = await DBProvider.db.getSearchedCodes(name, caseNum, codeId, yearDate, monthDate, dayDate);

                                      _searchCodes = list;
                                      _searchFlag = true;
                                      _panelController.close();
//                                      _displaySum();
                                      setState(() {});

                                    },
                                    elevation: 15.0,
                                    color: Colors.blue[400],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: new Center(
                                      child: new Text(
                                        "جستجو",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Shabnam'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      collapsed: GestureDetector( onTap: () {
                        _panelController.open();
                      },
                        child: new Container(

                          decoration: BoxDecoration(
                              color: Color.fromRGBO(123, 202, 204, 10.0),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),)),
//                                    height: header_height,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,

                                ),
                                new Text(
                                  "جستجوی پیشرفته",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                  textAlign: TextAlign.center,
                                ),
                                new Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      backdropTapClosesPanel: true,

                      body: new Container(margin: EdgeInsets.only(bottom: 250.0),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 6.0, left: 6.0, right: 6.0, bottom: 16.0),
                          child: _searchFlag ?

                                 new ListView.builder(
                                  itemCount: _searchCodes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    CodeNew item = _searchCodes[index];
                                    return new Card(
                                      elevation: 8.0,
                                      child: new Container(
                                        child: Column(
                                          children: <Widget>[

//                                            new Container(margin: EdgeInsets.only(left: 8.0)),


                                            _ShowCodeDetails(codeId: item.codeId,date: item.date,time: item.time,id: item.id,name: item.name,caseNum: item.caseNum,)

                                      ,    new Container(
                                      child: new _ShowMoreText(text: item.data),
                                    ),
                                          ],
                                        ),

                                      ),
                                      margin: const EdgeInsets.all(4.0),
                                    );
                                  },
                                )


                              :new FutureBuilder<List<CodeNew>>(

                            future: DBProvider.db.getAllCodeNews(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<CodeNew>> snapshot) {
                              if (snapshot.hasData) {
                                return new ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    CodeNew item = snapshot.data[index];
                                    return new Card(
                                      elevation: 8.0,
                                      child: new Container(
                                        child: Column(
                                          children: <Widget>[

//                                            new Container(margin: EdgeInsets.only(left: 8.0)),


                                            _ShowCodeDetails(codeId: item.codeId,date: item.date,time: item.time,id: item.id,name: item.name,caseNum: item.caseNum)

                                            ,new Container(
                                              child: new _ShowMoreText(text: item.data),
                                            ),
                                          ],
                                        ),

                                      ),
                                      margin: const EdgeInsets.all(4.0),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          )
                        ),
                      ),
                    ),
                ),

              ],
            ),
          ),

//          new BackdropPage(),

//          BackdropScaffold(
//
//            headerHeight: 40.0,
//            title: new Text("مشاهده کدها",style: TextStyle(fontSize: 14.0),),
//            backLayer:  new Container(margin: EdgeInsets.only(top: 4.0,right: 4.0,left: 4.0),
//            decoration: BoxDecoration(color: Color.fromRGBO(123, 202, 204, 1.0),
//              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),),
//            child: SingleChildScrollView(
//              child: new Column(
//                children: <Widget>[
//                  new Container(
////                      height: header_height,
//                    child: new Text(
//                      "جستجوی پیشرفته",
//                      style: TextStyle(color: Colors.white),
//                    ),
//                  ),
//
//
//
//                  Container(margin: EdgeInsets.only(right: 10.0,left: 10.0,top: 25.0),
//                    child: Padding(
//                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
//                      child: new Container(
//                        child: new Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Padding(
//                              padding: const EdgeInsets.only(
//                                  top: 2.0,
//                                  bottom: 2.0,
//                                  left: 4.0,
//                                  right: 4.0),
//                              child: new Icon(Icons.date_range,color: Colors.white,),
//                            ),
//
//                            Padding(
//                              padding: const EdgeInsets.only(
//                                  top: 2.0,
//                                  bottom: 2.0,
//                                  right: 4.0,
//                                  left: 4.0),
//                              child: new Text(
//                                "از",
//                                style:
//                                TextStyle(fontFamily: 'Shabnam',color: Colors.white),
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(
//                                  top: 2.0,
//                                  bottom: 2.0,
//                                  left: 4.0,
//                                  right: 4.0),
//                              child: new Container(
//                                decoration: BoxDecoration(
//                                    color: Colors.blue[200],
//                                    borderRadius:
//                                    BorderRadius.circular(4.0)),
//                                child: Padding(
//                                  padding: const EdgeInsets.all(2.0),
//                                  child: new Text(
//                                    PersianDate.fromDateTime(
//                                        DateTime.parse(
//                                            DateTime.now()
//                                                .toString()))
//                                        .toString(),style: TextStyle(color: Colors.white),),
//
//
////
//                                ),
//                              ),
//                            ),
//
////                                        Column(
////                                          children: <Widget>[
////                                            new Container(child: PersianDatePickerWidget(),),
////                                            new TextField(
////                                              onTap: (){
////                                                FocusScope.of(context).requestFocus(new FocusNode());
////                                              },
////                                              enableInteractiveSelection: false,
////                                              controller: _datePickerController,
////                                            )
////                                          ],
////                                        ),
//                            Padding(
//                              padding: const EdgeInsets.only(
//                                  top: 2.0,
//                                  bottom: 2.0,
//                                  right: 4.0,
//                                  left: 4.0),
//                              child: new Icon(
//                                Icons.date_range,color: Colors.white,
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(
//                                  top: 2.0,
//                                  bottom: 2.0,
//                                  right: 4.0,
//                                  left: 4.0),
//                              child: new Text(
//                                "تا",
//                                style:
//                                TextStyle(fontFamily: 'Shabnam',color: Colors.white),
//                              ),
//                            ),
//
//                            Padding(
//                              padding: const EdgeInsets.only(
//                                  top: 2.0,
//                                  bottom: 2.0,
//                                  left: 4.0,
//                                  right: 4.0),
//                              child: new Container(
//                                decoration: BoxDecoration(
//                                    color: Colors.blue[200],
//                                    borderRadius:
//                                    BorderRadius.circular(4.0)),
//                                child: Padding(
//                                  padding: const EdgeInsets.all(2.0),
//                                  child: new Text(
//                                      PersianDate.fromDateTime(
//                                          DateTime.parse(
//                                              DateTime.now()
//                                                  .toString()))
//                                          .toString(),style: TextStyle(color: Colors.white)),
//                                ),
//                              ),
//                            ),
//
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//
//
//                  Container(margin: EdgeInsets.only(left: 10.0,right: 10.0),
//                    child: Padding(
//                      padding: const EdgeInsets.only(top:10.0,right: 10.0,left: 10.0),
//                      child: new TextField(
//                        decoration: InputDecoration(
//                            suffixIcon: Icon(Icons.assignment_ind,color: Colors.white,),
//                            hintText: "نام بیمار",
//                            hintStyle:
//                            TextStyle(color: Colors.white,fontFamily: 'Shabnam',fontSize: 16)),
//                        textAlign: TextAlign.right,
//                        maxLines: 1,
////                                  controller: _patientNameController,
////                                    enabled: true,
////                                    autofocus: false,
//                      ),
//                    ),
//                  ),
//                  Container(margin: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
//                    child: Padding(
//                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
//                      child: new TextField(
//                        decoration: InputDecoration(
//                            suffixIcon: Icon(Icons.assignment,color: Colors.white,),
//                            hintText: "شماره پرونده",
//                            hintStyle:
//                            TextStyle(fontFamily: 'Shabnam',color: Colors.white)),
//                        keyboardType: TextInputType.number,
//                        textAlign: TextAlign.right,
//                        maxLines: 1,
////                                  controller: _caseNumberController,
//                      ),
//                    ),
//                  ),
//                  Container(margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
//                    child: Padding(
//                      padding: const EdgeInsets.only(left:10.0, right: 10.0),
//                      child: new TextField(
//                        decoration: InputDecoration(
//                            suffixIcon:
//                            Icon(Icons.assignment_turned_in,color: Colors.white,),
//                            hintText: "شماره کد",
//                            hintStyle:
//                            TextStyle(fontFamily: 'Shabnam',color: Colors.white)),
//                        keyboardType: TextInputType.number,
//                        maxLines: 1,
//                        textAlign: TextAlign.right,
////                                  controller: _codeIdController,
//                      ),
//                    ),
//                  ),
//                  Container(margin: EdgeInsets.only(top: 40.0),
//                    child: Padding(
//                      padding: const EdgeInsets.only(
//                          top: 2.0,
//                          bottom: 10.0,
//                          left: 6.0,
//                          right: 6.0),
//                      child: new RaisedButton(
//                        onPressed: () {},
//                        elevation: 15.0,
//                        color: Colors.blue,
//                        shape: RoundedRectangleBorder(
//                            borderRadius:
//                            BorderRadius.circular(10.0)),
//                        child: new Center(
//                          child: new Text(
//                            "جستجو",
//                            textAlign: TextAlign.center,
//                            maxLines: 1,
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontFamily: 'Shabnam'),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//
//
//
//            frontLayer: new Container(
//              color: Colors.white,
//              child: Padding(
//                padding: const EdgeInsets.all(6.0),
//                child: new FutureBuilder<List<CodeNew>>(
//                  future: DBProvider.db.getAllCodeNews(),
//                  builder: (BuildContext context,
//                      AsyncSnapshot<List<CodeNew>> snapshot) {
//                    if (snapshot.hasData) {
//                      return new ListView.builder(
//                        itemCount: snapshot.data.length,
//                        itemBuilder: (BuildContext context, int index) {
//                          CodeNew item = snapshot.data[index];
//                          return new Card(
//                            elevation: 8.0,
//                            child: new ListTile(
//                              title: new Text(
//                                item.data,
//                                textAlign: TextAlign.right,
//                                style: TextStyle(fontFamily: 'Shabnam'),
//                              ),
//                              subtitle: Row(
//                                mainAxisAlignment:
//                                MainAxisAlignment.start,
//                                children: <Widget>[
//                                  Container(
//                                    child: new Column(mainAxisAlignment: MainAxisAlignment.end,
//                                      children: <Widget>[
//                                        new Text(
//                                          "کد شماره: " + item.codeId,
//                                          textAlign: TextAlign.right,
//                                          style: TextStyle(
//                                              fontFamily: 'Shabnam'),
//                                        ),
//                                        new Text(
//                                          "تاریخ ثبت: " +
//                                              item.time +
//                                              " , " +
//                                              item.date,
//                                          textAlign: TextAlign.right,
//                                          style: TextStyle(
//                                              fontFamily: 'Shabnam'),
//                                        ),
//                                        new Text("نام بیمار: " +
//                                            item.name,
//                                          textAlign: TextAlign.right,
//                                          style: TextStyle(
//                                              fontFamily: 'Shabnam'),),
//                                        new Text("شماره پرونده: " +
//                                            item.caseNum,
//                                          textAlign: TextAlign.right,
//                                          style: TextStyle(
//                                              fontFamily: 'Shabnam'),),
//                                      ],
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    width: 60.0,
//                                  ),
//                                  Container(
//                                    child: IconButton(
//                                      icon: Icon(Icons.delete_forever),
//                                      onPressed: () async {
//                                        DBProvider.db
//                                            .deleteCodeNew(item.id);
////                                              _displaySum();
//                                        setState(() {});
//                                      },
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                            margin: const EdgeInsets.all(4.0),
//                          );
//                        },
//                      );
//                    } else {
//                      return Center(child: CircularProgressIndicator());
//                    }
//                  },
//                ),
//              ),
//            ),
//          ),

          //Range Saved codes
          //listview part
//          Padding(
//            padding: const EdgeInsets.all(0.0),
//            child: Column(
//              children: <Widget>[
//                new Expanded(
//                  flex: 1,
//                  child: new Container(
//                    height: 50.0,
//                    margin: EdgeInsets.only(bottom: 2.0),
//                    decoration: BoxDecoration(
//                        color: Color.fromRGBO(78, 162, 162, 10.0)),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      mainAxisSize: MainAxisSize.max,
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.only(right: 8.0, left: 4.0),
//                          child: new Icon(
//                            Icons.playlist_add_check,
//                            color: Colors.white,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(right: 8.0),
//                          child: new Text(
//                            " مجموع کل  K : ",
//                            textAlign: TextAlign.right,
//                            style: TextStyle(
//                                color: Colors.white, fontFamily: 'Shabnam'),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.all(2.0),
//                          child: Container(
//                              decoration: BoxDecoration(
//                                  color: Colors.red[400],
//                                  borderRadius: BorderRadius.circular(4.0)),
//                              child: Padding(
//                                padding: const EdgeInsets.all(2.0),
//                                child: new Text(
//                                  _sumOfAllFinal,
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                    color: Colors.white,
//                                    fontFamily: 'Shabnam',
//                                  ),
//                                ),
//                              )),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//                new Expanded(
//                  flex: 3,
//                  child: Padding(
//                    padding: const EdgeInsets.only(
//                        left: 4.0, right: 4.0, top: 2.0, bottom: 4.0),
//                    child: new Container(
//                      child: new FutureBuilder<List<CodeNew>>(
//                        future: DBProvider.db.getAllCodeNews(),
//                        builder: (BuildContext context,
//                            AsyncSnapshot<List<CodeNew>> snapshot) {
//                          if (snapshot.hasData) {
//                            return new ListView.builder(
//                              itemCount: snapshot.data.length,
//                              itemBuilder: (BuildContext context, int index) {
//                                CodeNew item = snapshot.data[index];
//                                return new Card(
//                                  elevation: 8.0,
//                                  child: new ListTile(
//                                    title: new Text(
//                                      item.data,
//                                      textAlign: TextAlign.right,
//                                      style: TextStyle(fontFamily: 'Shabnam'),
//                                    ),
//                                    subtitle: Row(
//                                      mainAxisAlignment:
//                                      MainAxisAlignment.start,
//                                      children: <Widget>[
//                                        Container(
//                                          child: new Column(
//                                            children: <Widget>[
//                                              new Text(
//                                                "کد شماره: " + item.codeId,
//                                                textAlign: TextAlign.right,
//                                                style: TextStyle(
//                                                    fontFamily: 'Shabnam'),
//                                              ),
//                                              new Text(
//                                                "تاریخ ثبت: " +
//                                                    item.time +
//                                                    " , " +
//                                                    item.date,
//                                                textAlign: TextAlign.right,
//                                                style: TextStyle(
//                                                    fontFamily: 'Shabnam'),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                        SizedBox(
//                                          width: 70.0,
//                                        ),
//                                        Container(
//                                          child: IconButton(
//                                            icon: Icon(Icons.delete_forever),
//                                            onPressed: () async {
//                                              DBProvider.db
//                                                  .deleteCodeNew(item.id);
//                                              _displaySum();
//                                              setState(() {});
//                                            },
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  margin: const EdgeInsets.all(4.0),
//                                );
//                              },
//                            );
//                          } else {
//                            return Center(child: CircularProgressIndicator());
//                          }
//                        },
//                      ),
//                    ),
//                  ),
//                ),
//                new Expanded(
//                    flex: 6,
//                    child: Padding(
//                      padding: const EdgeInsets.only(
//                          bottom: 2.0, right: 2.0, left: 2.0, top: 0.0),
//                      child: new Card(
//                        elevation: 20.0,
//                        color: Colors.white,
//                        child: new Container(
//                          decoration: BoxDecoration(
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(8.0))),
//                          child: new Column(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.end,
//                            children: <Widget>[
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: new TextField(
//                                  decoration: InputDecoration(
//                                      suffixIcon: Icon(Icons.assignment_ind),
//                                      hintText: "نام بیمار",
//                                      hintStyle:
//                                          TextStyle(fontFamily: 'Shabnam')),
//                                  textAlign: TextAlign.right,
//                                  maxLines: 1,
//                                  controller: _patientNameController,
//                                  enabled: true,
//                                  autofocus: false,
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: new TextField(
//                                  decoration: InputDecoration(
//                                      suffixIcon: Icon(Icons.assignment),
//                                      hintText: "شماره پرونده",
//                                      hintStyle:
//                                          TextStyle(fontFamily: 'Shabnam')),
//                                  keyboardType: TextInputType.number,
//                                  textAlign: TextAlign.right,
//                                  maxLines: 1,
//                                  controller: _caseNumberController,
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: new TextField(
//                                  decoration: InputDecoration(
//                                      suffixIcon:
//                                          Icon(Icons.assignment_turned_in),
//                                      hintText: "شماره کد",
//                                      hintStyle:
//                                          TextStyle(fontFamily: 'Shabnam')),
//                                  keyboardType: TextInputType.number,
//                                  maxLines: 1,
//                                  textAlign: TextAlign.right,
//                                  controller: _codeIdController,
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(2.0),
//                                child: new Container(
//                                  child: new Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            top: 2.0,
//                                            bottom: 2.0,
//                                            left: 4.0,
//                                            right: 4.0),
//                                        child: new Container(
//                                          decoration: BoxDecoration(
//                                              color: Colors.blue[200],
//                                              borderRadius:
//                                                  BorderRadius.circular(4.0)),
//                                          child: Padding(
//                                            padding: const EdgeInsets.all(2.0),
//                                            child: new Text(
//                                                PersianDate.fromDateTime(
//                                                        DateTime.parse(
//                                                            DateTime.now()
//                                                                .toString()))
//                                                    .toString()),
//                                          ),
//                                        ),
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            top: 2.0,
//                                            bottom: 2.0,
//                                            right: 4.0,
//                                            left: 4.0),
//                                        child: new Text(
//                                          "تا",
//                                          style:
//                                              TextStyle(fontFamily: 'Shabnam'),
//                                        ),
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            top: 2.0,
//                                            bottom: 2.0,
//                                            left: 4.0,
//                                            right: 4.0),
//                                        child: new Icon(Icons.date_range),
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            top: 2.0,
//                                            bottom: 2.0,
//                                            left: 4.0,
//                                            right: 4.0),
//                                        child: new Container(
//                                          decoration: BoxDecoration(
//                                              color: Colors.blue[200],
//                                              borderRadius:
//                                                  BorderRadius.circular(4.0)),
//                                          child: Padding(
//                                            padding: const EdgeInsets.all(2.0),
//                                            child: new Text(
//                                                PersianDate.fromDateTime(
//                                                        DateTime.parse(
//                                                            DateTime.now()
//                                                                .toString()))
//                                                    .toString()),
//                                          ),
//                                        ),
//                                      ),
//
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            top: 2.0,
//                                            bottom: 2.0,
//                                            right: 4.0,
//                                            left: 4.0),
//                                        child: new Text(
//                                          "از",
//                                          style:
//                                              TextStyle(fontFamily: 'Shabnam'),
//                                        ),
//                                      ),
////                                        Column(
////                                          children: <Widget>[
////                                            new Container(child: PersianDatePickerWidget(),),
////                                            new TextField(
////                                              onTap: (){
////                                                FocusScope.of(context).requestFocus(new FocusNode());
////                                              },
////                                              enableInteractiveSelection: false,
////                                              controller: _datePickerController,
////                                            )
////                                          ],
////                                        ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            top: 2.0,
//                                            bottom: 2.0,
//                                            right: 4.0,
//                                            left: 4.0),
//                                        child: new Icon(
//                                          Icons.date_range,
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(
//                                    top: 2.0,
//                                    bottom: 10.0,
//                                    left: 6.0,
//                                    right: 6.0),
//                                child: new RaisedButton(
//                                  onPressed: () {},
//                                  elevation: 15.0,
//                                  color: Colors.blue,
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius:
//                                          BorderRadius.circular(10.0)),
//                                  child: new Center(
//                                    child: new Text(
//                                      "جستجو",
//                                      textAlign: TextAlign.center,
//                                      maxLines: 1,
//                                      style: TextStyle(
//                                          color: Colors.white,
//                                          fontFamily: 'Shabnam'),
//                                    ),
//                                  ),
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
//                    ))
//              ],
//            ),
//          ),
        ],
      ),
//          floatingActionButton: _searchRangeButton(),
    );

    // implement build
  }

//
//  DefaultTabController(
//  length: 3,
//  child: Scaffold(
//  appBar: AppBar(
//  textTheme: TextTheme(
//  title: TextStyle(fontFamily: 'Shabnam', fontSize: 16.0)),
//  brightness: Brightness.light,
//  elevation: 10.0,
//  backgroundColor: Color.fromRGBO(123, 202, 204, 10.0),
//  bottom: TabBar(
//  controller: _tabController,
//  tabs: [
//  Tab(
//  icon: Icon(
//  Icons.calendar_view_day,
//  color: Colors.white,
//  ),
//  child: new Row(
//  mainAxisAlignment: MainAxisAlignment.center,
//  children: <Widget>[
//  new Container(
//  margin: EdgeInsets.only(right: 4.0, left: 4.0),
//  decoration: BoxDecoration(
//  color: Colors.red[300],
//  borderRadius: BorderRadius.circular(5.0)),
//  child: new Center(
//  child: Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: Text(_codeSumRange),
//  ),
//  ),
//  ),
//  new Text(
//  "بازه دلخواه",
//  textAlign: TextAlign.center,
//  style: TextStyle(
//  fontFamily: 'Shabnam', color: Colors.white),
//  ),
//  ],
//  ),
//  ),
//  Tab(
//  child: new Row(
//  mainAxisAlignment: MainAxisAlignment.center,
//  children: <Widget>[
//  new Container(
//  margin: EdgeInsets.only(right: 4.0, left: 4.0),
//  decoration: BoxDecoration(
//  color: Colors.red[300],
//  borderRadius: BorderRadius.circular(5.0)),
//  child: new Center(
//  child: Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: Text(_codeSumMonth),
//  ),
//  ),
//  ),
//  new Text(
//  "ماهانه",
//  textAlign: TextAlign.center,
//  style: TextStyle(
//  fontFamily: 'Shabnam', color: Colors.white),
//  ),
//  ],
//  ),
//  icon: Icon(
//  Icons.calendar_today,
//  color: Colors.white,
//  ),
//  ),
//  Tab(
//  icon: Icon(
//  Icons.today,
//  color: Colors.white,
//  ),
//  child: new Row(
//  mainAxisAlignment: MainAxisAlignment.center,
//  children: <Widget>[
//  new Container(
//  margin: EdgeInsets.only(right: 4.0, left: 4.0),
//  decoration: BoxDecoration(
//  color: Colors.red[300],
//  borderRadius: BorderRadius.circular(5.0)),
//  child: new Center(
//  child: Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: Text(_codeSumDay),
//  ),
//  ),
//  ),
//  new Text(
//  "روزانه",
//  textAlign: TextAlign.center,
//  style: TextStyle(
//  fontFamily: 'Shabnam', color: Colors.white),
//  ),
//  ],
//  ),
////                  icon: Icon(Icons.today),
////                  text: "روزانه",
//  ),
//  ],
//  ),
//  title: Text(
//  'کدهای ذخیره شده',
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam',
//  color: Colors.white,
//  ),
//  ),
//  ),
//  body: new TabBarView(
//  controller: _tabController,
//  children: [
//  //Range Saved codes
//  //listview part
//  Padding(
//  padding: const EdgeInsets.all(0.0),
//  child: Column(
//  children: <Widget>[
//  new Expanded(
//  flex: 1,
//  child: new Container(
//  height: 50.0,
//  margin: EdgeInsets.only(bottom: 2.0),
//  decoration: BoxDecoration(
//  color: Color.fromRGBO(78, 162, 162, 10.0)),
//  child: Row(
//  mainAxisAlignment: MainAxisAlignment.end,
//  crossAxisAlignment: CrossAxisAlignment.center,
//  mainAxisSize: MainAxisSize.max,
//  children: <Widget>[
//  Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: Container(
//  decoration: BoxDecoration(
//  color: Colors.red[200],
//  borderRadius: BorderRadius.circular(4.0)),
//  child: Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: new Text(
//  _sumOfAllFinal,
//  textAlign: TextAlign.center,
//  style: TextStyle(
//  color: Colors.white,
//  fontFamily: 'Shabnam',
//  ),
//  ),
//  )),
//  ),
//  Padding(
//  padding: const EdgeInsets.only(right: 8.0),
//  child: new Text(
//  " :k مجموع کل  ",
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  color: Colors.white, fontFamily: 'Shabnam'),
//  ),
//  ),
//  Padding(
//  padding:
//  const EdgeInsets.only(right: 4.0, left: 4.0),
//  child: new Icon(
//  Icons.playlist_add_check,
//  color: Colors.white,
//  ),
//  ),
//  ],
//  ),
//  ),
//  ),
//  new Expanded(
//  flex: 3,
//  child: Padding(
//  padding: const EdgeInsets.only(
//  left: 4.0, right: 4.0, top: 2.0, bottom: 4.0),
//  child: new Container(
//  child: new FutureBuilder<List<CodeNew>>(
//  future: DBProvider.db.getAllCodeNews(),
//  builder: (BuildContext context,
//      AsyncSnapshot<List<CodeNew>> snapshot) {
//  if (snapshot.hasData) {
//  return new ListView.builder(
//  itemCount: snapshot.data.length,
//  itemBuilder:
//  (BuildContext context, int index) {
//  CodeNew item = snapshot.data[index];
//  return new Card(
//  elevation: 8.0,
//  child: new ListTile(
//  leading: IconButton(
//  icon: Icon(Icons.delete_forever),
//  onPressed: () async {
//  DBProvider.db
//      .deleteCodeNew(item.id);
//  _displaySum();
//  setState(() {});
//  },
//  ),
//  title: new Text(
//  item.codeId + " :کد شماره ",
//  textAlign: TextAlign.right,
//  style:
//  TextStyle(fontFamily: 'Shabnam'),
//  ),
//  subtitle: new Column(
//  crossAxisAlignment:
//  CrossAxisAlignment.end,
//  children: <Widget>[
//  new Text(
//  item.data,
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
//  new Text(
//  item.date + " :تاریخ ثبت ",
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
////                                            new Text(item.day + "/" + item.month + "/" + item.year + " " + item.time),
////                                            new Text(item.date),
//  new Text(item.time + " :زمان ثبت ",textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Shabnam'),),
//  new Text(
//  " نام بیمار: " + item.name,
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
//  new Text(
//  item.caseNum + " :شماره پرونده ",
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
//  new Text(
//  item.proRate + " :ضریب حرفه ای  ",
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
//
////                                new Text(
////                                  item.techRate + ":ضریب فنی ",
////                                  textAlign: TextAlign.right,
////                                  style: TextStyle(fontFamily: 'Shabnam'),
////                                ),
////                                new Text(
////                                  item.valueRate + " :ضریب ارزشی ",
////                                  textAlign: TextAlign.right,
////                                  style: TextStyle(fontFamily: 'Shabnam'),
////                                ),
//  ],
//  ),
//  ),
//  margin: const EdgeInsets.all(4.0),
//  );
//  },
//  );
//  } else {
//  return Center(
//  child: CircularProgressIndicator());
//  }
//  },
//  ),
//  ),
//  ),
//  ),
//  new Expanded(
//  flex: 6,
//  child: Padding(
//  padding: const EdgeInsets.only(bottom:2.0,right: 2.0,left: 2.0,top: 0.0),
//  child: new Card(
//  elevation: 20.0,
//  color: Colors.white,
//  child: new Container(
//  decoration: BoxDecoration(
//  borderRadius:
//  BorderRadius.all(Radius.circular(8.0))),
//  child: new Column(
//  crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.end,
//  children: <Widget>[
//  Padding(
//  padding: const EdgeInsets.all(8.0),
//  child: new TextField(
//  decoration: InputDecoration(
//  suffixIcon: Icon(Icons.assignment_ind),
//  hintText: "نام بیمار",hintStyle: TextStyle(fontFamily: 'Shabnam')),
//  textAlign: TextAlign.right,
//  maxLines: 1,
//  controller: _patientNameController,
//  enabled: true,
//  autofocus: false,
//
//  ),
//  ),
//  Padding(
//  padding: const EdgeInsets.all(8.0),
//  child: new TextField(
//  decoration: InputDecoration(
//  suffixIcon: Icon(Icons.assignment),
//  hintText: "شماره پرونده",hintStyle: TextStyle(fontFamily: 'Shabnam')
//  ),
//  keyboardType: TextInputType.number,
//  textAlign: TextAlign.right,
//  maxLines: 1,
//  controller: _caseNumberController,
//  ),
//  ),
//  Padding(
//  padding: const EdgeInsets.all(8.0),
//  child: new TextField(
//  decoration: InputDecoration(
//  suffixIcon:
//  Icon(Icons.assignment_turned_in),
//  hintText: "شماره کد",hintStyle: TextStyle(fontFamily: 'Shabnam')
//  ),
//  keyboardType: TextInputType.number,
//  maxLines: 1,
//  textAlign: TextAlign.right,
//  controller: _codeIdController,
//  ),
//  ),
//  Padding(padding: const EdgeInsets.all(2.0),
//  child: new Container(
//  child: new Row(mainAxisAlignment: MainAxisAlignment.center,
//  children: <Widget>[
//  Padding(
//  padding: const EdgeInsets.only(top: 2.0,bottom: 2.0,left: 4.0,right: 4.0),
//  child: new Container(
//  decoration: BoxDecoration(color: Colors.blue[200],borderRadius: BorderRadius.circular(4.0)),
//  child: Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: new Text(PersianDate.fromDateTime(DateTime.parse(DateTime.now().toString())).toString()),
//  ),
//  ),
//  ),
//  Padding(
//  padding: const EdgeInsets.only(top: 2.0,bottom: 2.0,right: 4.0,left: 4.0),
//  child: new Text("تا",style: TextStyle(fontFamily: 'Shabnam'),),
//  ),
//  Padding(
//  padding: const EdgeInsets.only(top: 2.0,bottom: 2.0,left: 4.0,right: 4.0),
//  child: new Icon(Icons.date_range),
//  ),
//  Padding(
//  padding: const EdgeInsets.only(top: 2.0,bottom: 2.0, left: 4.0,right: 4.0),
//  child: new Container(
//  decoration: BoxDecoration(color: Colors.blue[200],borderRadius: BorderRadius.circular(4.0)),
//  child: Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: new Text(PersianDate.fromDateTime(DateTime.parse(DateTime.now().toString())).toString()),
//  ),
//  ),
//  ),
//
//
//  Padding(
//  padding: const EdgeInsets.only(top: 2.0, bottom: 2.0,right: 4.0,left: 4.0),
//  child: new Text("از",style: TextStyle(fontFamily: 'Shabnam'),),
//  ),
////                                        Column(
////                                          children: <Widget>[
////                                            new Container(child: PersianDatePickerWidget(),),
////                                            new TextField(
////                                              onTap: (){
////                                                FocusScope.of(context).requestFocus(new FocusNode());
////                                              },
////                                              enableInteractiveSelection: false,
////                                              controller: _datePickerController,
////                                            )
////                                          ],
////                                        ),
//  Padding(
//  padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 4.0,left: 4.0),
//  child: new Icon(Icons.date_range,),
//  )
//
//  ],
//  ),
//  ),),
//  Padding(padding: const EdgeInsets.only(top: 2.0, bottom: 10.0, left: 6.0,right: 6.0),
//  child: new RaisedButton(
//  onPressed: () {},
//  elevation: 15.0,
//  color: Colors.blue,
//  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//  child: new Center(
//  child: new Text("جستجو",textAlign: TextAlign.center,maxLines: 1,style: TextStyle(color: Colors.white,fontFamily: 'Shabnam'),),
//  ),
//  ),)
//
//  ],
//  ),
//  ),
//  ),
//  ))
//  ],
//  ),
//  ),
//
//  Padding(
//  padding: const EdgeInsets.all(0.0),
//  child: new Column(
//  children: <Widget>[
//  new Expanded(
//  flex: 1,
//  child: new Container(
//  height: 50.0,
//  margin: EdgeInsets.only(bottom: 2.0),
//  decoration: BoxDecoration(
//  color: Color.fromRGBO(78, 162, 162, 10.0)),
//  child: Row(
//  mainAxisAlignment: MainAxisAlignment.end,
//  crossAxisAlignment: CrossAxisAlignment.center,
//  mainAxisSize: MainAxisSize.max,
//  children: <Widget>[
//  Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: Container(
//  decoration: BoxDecoration(
//  color: Colors.red[200],
//  borderRadius: BorderRadius.circular(4.0)),
//  child: Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: new Text(
//  _sumOfMonthFinal,
//  textAlign: TextAlign.center,
//  style: TextStyle(
//  color: Colors.white,
//  fontFamily: 'Shabnam',
//  ),
//  ),
//  )),
//  ),
//  Padding(
//  padding: const EdgeInsets.only(right: 8.0),
//  child: new Text(
//  " :k مجموع کل  ",
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  color: Colors.white, fontFamily: 'Shabnam'),
//  ),
//  ),
//  Padding(
//  padding:
//  const EdgeInsets.only(right: 4.0, left: 4.0),
//  child: new Icon(
//  Icons.playlist_add_check,
//  color: Colors.white,
//  ),
//  ),
//  ],
//  ),
//  ),
//  ),
//  new Expanded(
//  flex: 9,
//  child: new Container(
//  child: //This month Saved codes
//  Padding(
//  padding: const EdgeInsets.only(
//  right: 4.0, left: 4.0, top: 2.0, bottom: 4.0),
//  child: new FutureBuilder<List<CodeNew>>(
//  future: DBProvider.db.getMonthCodeNews(),
//  builder: (BuildContext context,
//      AsyncSnapshot<List<CodeNew>> snapshot) {
//  if (snapshot.hasData) {
//  return new ListView.builder(
//  itemCount: snapshot.data.length,
//  itemBuilder:
//  (BuildContext context, int index) {
//  CodeNew item = snapshot.data[index];
//  return new Card(
//  elevation: 8.0,
//  child: new ListTile(
//  leading: IconButton(
//  icon: Icon(Icons.delete_forever),
//  onPressed: () async {
//  DBProvider.db
//      .deleteCodeNew(item.id);
//  _displaySum();
//  setState(() {});
//  },
//  ),
//  title: new Text(
//  item.codeId + " :کد شماره ",
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
//  subtitle: new Column(
//  children: <Widget>[
//  new Text(
//  item.data,
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
//  new Text(
//  item.date + " :زمان ثبت ",
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
//  ],
//  ),
//  ),
//  margin: const EdgeInsets.all(4.0),
//  );
//  },
//  );
//  } else {
//  return Center(
//  child: CircularProgressIndicator());
//  }
//  },
//  ),
//  ),
//  ))
//  ],
//  ),
//  ),
//
//  Padding(
//  padding: const EdgeInsets.all(0.0),
//  child: new Column(
//  children: <Widget>[
//  new Expanded(
//  flex: 1,
//  child: new Container(
//  height: 50.0,
//  margin: EdgeInsets.only(bottom: 2.0),
//  decoration: BoxDecoration(
//  color: Color.fromRGBO(78, 162, 162, 10.0)),
//  child: Row(
//  mainAxisAlignment: MainAxisAlignment.end,
//  crossAxisAlignment: CrossAxisAlignment.center,
//  mainAxisSize: MainAxisSize.max,
//  children: <Widget>[
//  Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: Container(
//  decoration: BoxDecoration(
//  color: Colors.red[200],
//  borderRadius: BorderRadius.circular(4.0)),
//  child: Padding(
//  padding: const EdgeInsets.all(2.0),
//  child: new Text(
//  _sumOfDayFinal,
//  textAlign: TextAlign.center,
//  style: TextStyle(
//  color: Colors.white,
//  fontFamily: 'Shabnam',
//  ),
//  ),
//  )),
//  ),
//  Padding(
//  padding: const EdgeInsets.only(right: 8.0),
//  child: new Text(
//  " :k مجموع کل  ",
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  color: Colors.white, fontFamily: 'Shabnam'),
//  ),
//  ),
//  Padding(
//  padding:
//  const EdgeInsets.only(right: 4.0, left: 4.0),
//  child: new Icon(
//  Icons.playlist_add_check,
//  color: Colors.white,
//  ),
//  ),
//  ],
//  ),
//  ),
//  ),
//  new Expanded(
//  flex: 9,
//  child: new Container(
//  child: new
//  //Today Saved codes List
//  Padding(
//  padding: const EdgeInsets.only(
//  right: 4.0, left: 4.0, top: 2.0, bottom: 4.0),
//  child: new FutureBuilder<List<CodeNew>>(
//  future: DBProvider.db.getTodayCodeNews(),
//  builder: (BuildContext context,
//      AsyncSnapshot<List<CodeNew>> snapshot) {
//  if (snapshot.hasData) {
//  return new ListView.builder(
//  itemCount: snapshot.data.length,
//  itemBuilder:
//  (BuildContext context, int index) {
//  CodeNew item = snapshot.data[index];
////                                      for(var i = 0; i < snapshot.data.length; i++){
////                                        if(_flagTodaySum){
////                                          _sumOfTodayK = double.tryParse(item.proRate) + _sumOfTodayK;
////
////                                        }
////                                        _flagTodaySum = false;
////
////                                      }
//
////                                      _sumOfTodayK = double.tryParse(item.proRate) + _sumOfTodayK;
//
//  return new Card(
//  elevation: 8.0,
//  child: new ListTile(
//  leading: IconButton(
//  icon: Icon(Icons.delete_forever),
//  onPressed: () async {
//  DBProvider.db
//      .deleteCodeNew(item.id);
//  _displaySum();
//  setState(() {});
//  },
//  ),
//  title: new Text(
//  item.codeId + " :کد شماره ",
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
//  subtitle: new Column(
//  children: <Widget>[
//  new Text(
//  item.data,
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
//  new Text(
//  item.date + " :زمان ثبت ",
//  textAlign: TextAlign.right,
//  style: TextStyle(
//  fontFamily: 'Shabnam'),
//  ),
//  ],
//  ),
//  ),
//  margin: const EdgeInsets.all(4.0),
//  );
//  },
//  );
//  } else {
//  return Center(
//  child: CircularProgressIndicator());
//  }
//  },
//  ),
//  ),
//  ))
//  ],
//  ),
//  ),
//
//  ],
//  ),
////          floatingActionButton: _searchRangeButton(),
//  ),
//  ),

//  Widget _searchRangeButton() {
//    return Container(
//      alignment: Alignment(-0.75, 0.9),
//      child: _tabController.index == 0
//          ? FloatingActionButton(
//              shape: StadiumBorder(),
//              onPressed: null,
//              backgroundColor: Color.fromRGBO(123, 202, 204, 10.0),
//              child: Icon(
//                Icons.calendar_today,
//                size: 20.0,
//              ),
//            )
//          : null,
//    );
//    /*
//        : FloatingActionButton(
//      shape: StadiumBorder(),
//      onPressed: null,
//      backgroundColor: Colors.redAccent,
//      child: Icon(
//        Icons.edit,
//        size: 20.0,
//      ),
//    );
//      */
//  }
}

//class BackdropPage extends StatefulWidget {
//  @override
//  State createState() => new _BackdropPageState();
//}
//
//class _BackdropPageState extends State<BackdropPage>
//    with SingleTickerProviderStateMixin {
//  AnimationController controller;
//
//  @override
//  void initState() {
//    super.initState();
//    controller = new AnimationController(
//        vsync: this, duration: new Duration(milliseconds: 100), value: 1.0);
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    controller.dispose();
//  }
//
//  bool get isPanelVisible {
//    final AnimationStatus status = controller.status;
//    return status == AnimationStatus.completed ||
//        status == AnimationStatus.forward;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: Container(
//            child: new Text(
//          "مشاهده کدها",
//          style: TextStyle(fontSize: 16.0),
//          textAlign: TextAlign.right,
//        )),
//        elevation: 0.0,
//        backgroundColor: Color.fromRGBO(78, 162, 162, 10.0),
//        leading: Container(
//          margin: EdgeInsets.only(top: 20.0),
//          child: new IconButton(
//            onPressed: () {
//              controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
//            },
//            icon: new AnimatedIcon(
//              size: 30,
//              icon: AnimatedIcons.menu_arrow,
//              progress: controller.view,
//            ),
//          ),
//        ),
//      ),
//      body: new TwoPanels(
//        controller: controller,
//      ),
//    );
//  }
//}

//
//new Expanded(
//flex: 1,
//child: new Container(
//height: 50.0,
//margin: EdgeInsets.only(bottom: 2.0),
//decoration: BoxDecoration(
//color: Color.fromRGBO(78, 162, 162, 10.0)),
//child: Row(
//mainAxisAlignment: MainAxisAlignment.start,
//crossAxisAlignment: CrossAxisAlignment.center,
//mainAxisSize: MainAxisSize.max,
//children: <Widget>[
//Padding(
//padding: const EdgeInsets.only(right: 8.0, left: 4.0),
//child: new Icon(
//Icons.playlist_add_check,
//color: Colors.white,
//),
//),
//Padding(
//padding: const EdgeInsets.only(right: 8.0),
//child: new Text(
//" مجموع کل  K : ",
//textAlign: TextAlign.right,
//style: TextStyle(
//color: Colors.white, fontFamily: 'Shabnam'),
//),
//),
//Padding(
//padding: const EdgeInsets.all(2.0),
//                          child: Container(
//                              decoration: BoxDecoration(
//                                  color: Colors.red[400],
//                                  borderRadius: BorderRadius.circular(4.0)),
//                              child: Padding(
//                                padding: const EdgeInsets.all(2.0),
//                                child: new Text(
//                                  _sumOfAllFinal,
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                    color: Colors.white,
//                                    fontFamily: 'Shabnam',
//                                  ),
//                                ),
//                              )),
//),
//],
//),
//),
//),


class _ShowMoreText extends StatefulWidget{
  final String text;

  _ShowMoreText({@required this.text});

  @override
  _ShowMoreTextState createState() => new _ShowMoreTextState();

}

class _ShowMoreTextState extends State<_ShowMoreText> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
        children: <Widget>[
          new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
          new InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  flag ? "نمایش بیشتر" : "نمایش کمتر",
                  style: new TextStyle(color: Colors.blue,fontSize: 10.0),
                ),
//                new Icon(flag ? Icons.add : Icons.minimize,color: Colors.blue,),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }
}


const loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";


class _ShowCodeDetails extends StatefulWidget{
  final String codeId;
  final String date;
  final String time;
  final int id;
  final String name;
  final String caseNum;
//  Function callback;


  _ShowCodeDetails({@required this.codeId,this.date,this.time,this.id,this.name,this.caseNum});

  @override
  _ShowCodeDetailsI  createState() => new _ShowCodeDetailsI();


}


class _ShowCodeDetailsI extends State<_ShowCodeDetails> {
  String codeid;
  String date;
  String time;
  int id;
  String name;
  String caseNum;

//  _SavedCodeState parent;
//  _ShowCodeDetailsI(this.parent);


  @override
  void initState() {
    super.initState();

    codeid  = widget.codeId;
    date = widget.date;
    time = widget.time;
    id = widget.id;
    name = widget.name;
    caseNum = widget.caseNum;
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
          scrollOnExpand: false,
          scrollOnCollapse: true,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(

                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      tapHeaderToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: true,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      header: Padding(
                          padding: EdgeInsets.only(right: 8.0,left: 2.0,top: 4.0,bottom: 4.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("کد شماره: " + widget.codeId,style: TextStyle(color: Colors.blue),
//                                style: Theme.of(context).textTheme.body2,
                              ),
//                              new Container(decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
//                                child: Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: new Text("1"),
//                                ),),
                            ],
                          )
                      ),
//                      collapsed: Text("نمایش جزئیات",style: TextStyle(color: Colors.blue),),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: new Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[


                                    new Text(
                                      "تاریخ ثبت: " +
                                          widget.time +
                                          " , " +
                                          widget.date,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: 'Shabnam'),
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(width: 120.0,child: new Text("ن.ب: " + widget.name ,textAlign: TextAlign.right,)),
                                        Container(width: 120.0,child: new Text("ش.پ: " + widget.caseNum,textAlign: TextAlign.right,)),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.delete_forever),
                                  onPressed: () async {
                                    DBProvider.db
                                        .deleteCodeNew(widget.id);
//                                    _displaySum();
//                                    this.widget.callback();
//                                    _SavedCodeState _page = new _SavedCodeState();
//                                    _page.callback();

//                                  this.parent.setState( () {} );
//                                    setState(() {});


//                                  Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context){
//                                    return new SavedCode();
//                                  }));

                                  Navigator.of(context).pushReplacementNamed(SAVED_SCREEN);

                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0,top: 4.0),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            crossFadePoint: 0,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}



