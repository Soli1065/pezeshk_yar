import 'package:flutter/material.dart';
//import 'package:pezeshk_yar/Constant/Constant.dart';
import 'package:jalali_date/jalali_date.dart';
import 'dart:async';
import 'dart:convert';

//import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

//import 'Database.dart';
//import 'CodeNewModel.dart';
import 'package:date_format/date_format.dart';
import 'package:pezeshk_yar/Screen/CodeNewModel.dart';
import 'package:pezeshk_yar/Screen/Database.dart';

class SearchCode extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

// ignore: camel_case_types
class _searchState extends State<SearchCode> {

  int _mostUsedCodesNum = 0;
  bool _showMostUsedCodesFlag = true;
  bool _notShowNullView = true;
  List<CodeNew> _nullList = [];

  TextEditingController controller = new TextEditingController();

  TextEditingController _textPatientName = new TextEditingController();
  TextEditingController _textCaseNumber = new TextEditingController();

  bool _showToastFlag = false;

  int _searchResultNumber = 0;


  String tempCodeId = "";
  String tempData = "";
  String tempDate = "";
  String tempDay = "";
  String tempMonth = "";
  String tempYear = "";
  int tempId;
  String tempTime = "";
  String tempPatientName = "";
  String tempCaseNumber = "";
  bool tempBlocked = false;
  String tempProRate = "";
//  String tempTechRate = "";
//  String tempValueRate = "";


  Future<String> _loadCodeAsset() async {
    return await rootBundle.loadString('assets/codebeautify.json');
  }

  Future<Null> getCodeDetails() async {
    final response = await _loadCodeAsset();
    final responseJson = json.decode(response);

    setState(() {
      for (Map code in responseJson) {
        _codesList.add(Code.fromJson(code));
      }
    });
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              ' لطفا نام بیمار و شماره پرونده را وارد نمایید ',
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: _textPatientName,
                  decoration: InputDecoration(
                      hintText: " نام بیمار ",
                      suffixIcon: new Icon(Icons.assignment_ind)),
                  textAlign: TextAlign.right,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _textCaseNumber,
                  decoration: InputDecoration(
                    hintText: " شماره پرونده ",
                    suffixIcon: new Icon(Icons.assignment),

                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(' لغو '),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(' ذخیره '),
                onPressed: () async {
                  CodeNew rnd = CodeNew(
                      data: tempData,
                      codeId: tempCodeId,
                      date: tempDate,
                      blocked: false,
                      day: tempDay,
                      month: tempMonth,
                      year: tempYear,
                      name: _textPatientName.text.toString(),
                      caseNum: _textCaseNumber.text.toString(),
                      proRate: tempProRate,
                      time: tempTime
                  );

                  await DBProvider.db.newCodeNew(rnd);
                  setState(() {});
                  Navigator.of(context).pop();
                  tempYear = "";
                  tempMonth = "";
                  tempDay = "";
                  tempDate = "";
                  tempData = "";
                  tempCodeId = "";
                  tempId = null;
                  _textCaseNumber.text = "";
                  _textPatientName.text = "";
//                _showToast(context);
//                _showToastFlag = true;
                  tempProRate = "";
//                  tempValueRate = "";
//                  tempTechRate = "";
                },
              ),

            ],
          );
        });
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text(
          'کد با موفقیت ذخیره شد',
          textAlign: TextAlign.right,
        ),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCodeDetails();
    //getUserDetails();
    getMostUsedCodes();
    _searchResult = [];
    _searchResultNumber = 0;

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(123, 202, 204, 10),
        title: new Text('جستجوی کد',textAlign: TextAlign.right,style: TextStyle(fontSize: 16.0),),
        elevation: 8.0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Color.fromRGBO(123, 202, 204, 10.0),
            child: new Padding(
              padding: const EdgeInsets.all(4.0),
              child: new Card(
                color: Color.fromRGBO(105, 192, 186, 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: new ListTile(
                  leading: new IconButton(
                    icon: new Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                  title: new TextField(style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.right,
                    controller: controller,
                    decoration: new InputDecoration(
//                      fillColor: Colors.white,
                        hintText: 'عبارت جستجو را وارد نمایید',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white,fontSize: 14.0)),
//                    onChanged: onSearchTextChanged,
//                        onSubmitted: onSearchTextChanged(controller.text),


                  ),
                  trailing:new IconButton(onPressed: () {
                  setState(() {

                    
                    onSearchTextChanged(controller.text);
                    _notShowNullView = true;
                  });
                  },
                icon: Icon(Icons.search,color: Colors.white,),

//                color: Colors.white,
              ),
                ),
              ),
            ),
          ),
          new Container(
            height: 50.0,
            margin: EdgeInsets.only( bottom: 2.0),
            decoration:
                BoxDecoration(color: Color.fromRGBO(78, 162, 162, 10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[


                Row(
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.only(right: 8.0),
                      child: new Icon(
                        Icons.playlist_add_check,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: new Text(_showMostUsedCodesFlag?
                          "جستجوهای اخیر : " : " نتیجه جستجو : ",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white, fontFamily: 'Shabnam'),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(right: 4.0),


                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                        color: Colors.red[400],),
                      child: Padding(padding: const EdgeInsets.all(3.0),
                        child: new Text(_showMostUsedCodesFlag?
                            _mostUsedCodesNum.toString() : _searchResultNumber.toString(),
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(color: Colors.white, fontFamily: 'Shabnam',),
                        ),
                      ),
                    ),
                  ],
                ),





//                Container(margin: EdgeInsets.only(left: 8.0),
//                  child: Row(
//                    children: <Widget>[
//                      new RaisedButton(
//                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//                        child: Text('کدهای پرتکرار',style: TextStyle(color: Colors.white),),
//                        elevation: 8.0,color: Colors.red[300],
//                      onPressed: () {},),
//                    ],
//                  ),
//                )
              ],
            ),
          ),
          new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? _notShowNullView ? new ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, i) {
                      return new Card(
                        elevation: 8.0,
                        child: new Container(margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(8.0),
                          child: new Column(
                            children: <Widget>[
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    ' کد شماره:' + _searchResult[i].id,
                                    textAlign: TextAlign.right,style: TextStyle(color: Colors.blue),
                                  ),
                                  new IconButton(
                                      icon: Icon(Icons.add,size: 30.0,color: Colors.blue,),
                                      onPressed: () async {
                                        print("This is the Code ID: " +
                                            _searchResult[i].id);
                                        var currentDate = formatDate(DateTime.now(),
                                            [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
                                        print("This is Time Format: " +
                                            currentDate.toString());
                                        var _persianDate = PersianDate.fromDateTime(
                                            DateTime.parse(DateTime.now().toString()));
                                        print(_persianDate);
                                        var _date = new DateTime.now();
                                        print(_date);
                                        var _day = _persianDate.day.toString();
                                        print(_day);
                                        var _month = _persianDate.month.toString();
                                        var _year = _persianDate.year.toString();
                                        var _time = _date.hour.toString() + ":" + _date.minute.toString();
                                        tempCodeId = _searchResult[i].id;
                                        tempData = _searchResult[i].data;
                                        tempDate = _persianDate.toString();
                                        tempDay = _day;
                                        tempMonth = _month;
                                        tempYear = _year;
                                        tempTime = _time;
                                        tempProRate = _searchResult[i].proRate.toString();
//                                tempTechRate = _searchResult[i].techRate;
//                                tempValueRate = _searchResult[i].valueRate;
                                        _displayDialog(context);

                                        print("code searched saved to database");
                                      }),

                                ],
                              ),
                              new _ShowMoreText(text: _searchResult[i].data),


                            ],
                          ),
//                          trailing: new IconButton(
//                              icon: Icon(Icons.add,size: 30.0,color: Colors.blue,),
//                              onPressed: () async {
//                                print("This is the Code ID: " +
//                                    _searchResult[i].id);
//                                var currentDate = formatDate(DateTime.now(),
//                                    [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
//                                print("This is Time Format: " +
//                                    currentDate.toString());
//                                var _persianDate = PersianDate.fromDateTime(
//                                    DateTime.parse(DateTime.now().toString()));
//                                print(_persianDate);
//                                var _date = new DateTime.now();
//                                print(_date);
//                                var _day = _persianDate.day.toString();
//                                print(_day);
//                                var _month = _persianDate.month.toString();
//                                var _year = _persianDate.year.toString();
//                                var _time = _date.hour.toString() + ":" + _date.minute.toString();
//                                tempCodeId = _searchResult[i].id;
//                                tempData = _searchResult[i].data;
//                                tempDate = _persianDate.toString();
//                                tempDay = _day;
//                                tempMonth = _month;
//                                tempYear = _year;
//                                tempTime = _time;
//                                tempProRate = _searchResult[i].proRate.toString();
////                                tempTechRate = _searchResult[i].techRate;
////                                tempValueRate = _searchResult[i].valueRate;
//                                _displayDialog(context);
//
//                                print("code searched saved to database");
//                              }),


//                          new Text(
//                            _searchResult[i].data,
//                            textAlign: TextAlign.right,
//                          ),




                        ),
                        margin: const EdgeInsets.all(4.0),
                      );
                    },
                  )
            : new ListView.builder(itemBuilder: (context, l){return; },itemCount: _nullList.length,)
                : new ListView.builder(
                    itemCount: _mostUsedCodes.length,
                    itemBuilder: (context, j) {
                      return new Card(
                        elevation: 8.0,

                        child: new Container(margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(8.0),
                          child: new Column(
                            children: <Widget>[

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    'کد شماره:' + " " + _mostUsedCodes[j].codeId,
                                    textAlign: TextAlign.right,style: TextStyle(color: Colors.blue),
                                  ),
                                  new IconButton(
                                      icon: Icon(Icons.add,color: Colors.blue,size: 30.0,),
                                      onPressed: () async {
                                        var currentDate = formatDate(DateTime.now(),
                                            [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
                                        var _persianDate = PersianDate.fromDateTime(DateTime.parse(DateTime.now().toString()));


                                        var _date = new DateTime.now();
                                        var _time = _date.hour.toString() + ":" + _date.minute.toString();
                                        var _day = _persianDate.day.toString();
                                        var _month = _persianDate.month.toString();
                                        var _year = _persianDate.year.toString();
                                        tempCodeId = _mostUsedCodes[j].codeId;
                                        tempData = _mostUsedCodes[j].data;
                                        tempDate = _persianDate.toString();
                                        tempDay = _day;
                                        tempMonth = _month;
                                        tempYear = _year;
                                        tempTime = _time;
                                        tempProRate = _mostUsedCodes[j].proRate.toString();
//                                tempTechRate = _codesList[j].techRate;
//                                tempValueRate = _codesList[j].valueRate;
                                        _displayDialog(context);
                                        print("data saved to table");

//                              _showToastFlag == true ? _showToast(context) :null;
//                              _showToastFlag = false;
                                      }

//                            onPressed: () async {
//                              var currentDate = formatDate(DateTime.now(),
//                                  [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
//                              var _date = new DateTime.now();
//                              var _day = _date.day.toString();
//                              var _month = _date.month.toString();
//                              var _year = _date.year.toString();
//                              CodeNew rnd = CodeNew(
//                                  data: _codesList[j].data,
//                                  codeId: _codesList[j].id,
//                                  date: currentDate,
//                                  blocked: false,
//                                  day: _day,
//                                  month: _month,
//                                  year: _year);
//                              await DBProvider.db.newCodeNew(rnd);
//                              setState(() {});
//                              print("data saved to table");
//                              print("day: " + _day);
//                              print("month: " + _month);
//                              print("year: " + _year);
//                              print("codeId: " + _codesList[j].id);
//                              print("data: " + _codesList[j].data);
//                              print("date: " + currentDate);

//                            },
                                  ),
                                ],
                              ),
                              new _ShowMoreText(text: _mostUsedCodes[j].data),
                            ],


                          ),
//                          trailing: new IconButton(
//                              icon: Icon(Icons.add,color: Colors.blue,size: 30.0,),
//                              onPressed: () async {
//                                var currentDate = formatDate(DateTime.now(),
//                                    [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
//                                var _persianDate = PersianDate.fromDateTime(DateTime.parse(DateTime.now().toString()));
//
//
//                                var _date = new DateTime.now();
//                                var _time = _date.hour.toString() + ":" + _date.minute.toString();
//                                var _day = _persianDate.day.toString();
//                                var _month = _persianDate.month.toString();
//                                var _year = _persianDate.year.toString();
//                                tempCodeId = _codesList[j].id;
//                                tempData = _codesList[j].data;
//                                tempDate = _persianDate.toString();
//                                tempDay = _day;
//                                tempMonth = _month;
//                                tempYear = _year;
//                                tempTime = _time;
//                                tempProRate = _codesList[j].proRate.toString();
////                                tempTechRate = _codesList[j].techRate;
////                                tempValueRate = _codesList[j].valueRate;
//                                _displayDialog(context);
//                                print("data saved to table");
//
////                              _showToastFlag == true ? _showToast(context) :null;
////                              _showToastFlag = false;
//                              }
//
////                            onPressed: () async {
////                              var currentDate = formatDate(DateTime.now(),
////                                  [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
////                              var _date = new DateTime.now();
////                              var _day = _date.day.toString();
////                              var _month = _date.month.toString();
////                              var _year = _date.year.toString();
////                              CodeNew rnd = CodeNew(
////                                  data: _codesList[j].data,
////                                  codeId: _codesList[j].id,
////                                  date: currentDate,
////                                  blocked: false,
////                                  day: _day,
////                                  month: _month,
////                                  year: _year);
////                              await DBProvider.db.newCodeNew(rnd);
////                              setState(() {});
////                              print("data saved to table");
////                              print("day: " + _day);
////                              print("month: " + _month);
////                              print("year: " + _year);
////                              print("codeId: " + _codesList[j].id);
////                              print("data: " + _codesList[j].data);
////                              print("date: " + currentDate);
//
////                            },
//                              ),



//                          new Text(
//                          _codesList[j].data,
//                          textAlign: TextAlign.right,
//                        ),


                        ),
                        margin: const EdgeInsets.all(4.0),
                      );
                    },
                  ),
          ),

/*
          new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return new Card(
                  child: new ListTile(
                    title: new Text(_searchResult[i].id +  ' :کد شماره',textAlign: TextAlign.right,),
                    subtitle: new Text(_searchResult[i].data ,textAlign: TextAlign.right,),
                  ),
                  margin: const EdgeInsets.all(4.0),
                );
              },
            )
                : new ListView.builder(
              itemCount: _userDetails.length,
              itemBuilder: (context, index) {
                return new Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  child: new ListTile(
                    title: new Text( _userDetails[index].id + ' :کد شماره' ,textAlign: TextAlign.right,),
                    subtitle: new Text( _userDetails[index].data ,textAlign: TextAlign.right,),
                  ),
                  margin: const EdgeInsets.all(4.0),
                );
              },
            ),
          ),

 */
        ],
      ),

      /*
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check_circle_outline),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SavedCodeNew()),
          );
        },
      ),

      */
    );
  }
  Future<List<CodeNew>> getMostUsedCodes() async {
    List<CodeNew> list = await DBProvider.db.getMonthCodeNews();
    _mostUsedCodes = list;
    _mostUsedCodesNum = _mostUsedCodes.length;
    _showMostUsedCodesFlag = true;
    setState(() {});
    return _mostUsedCodes;

  }

/*
  Widget _createSearchView(){
    return new Container(
      padding: EdgeInsets.only(bottom: 10.0 ,right: 10.0, left: 10.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: new TextField(

        controller:  _searchView,
        decoration: InputDecoration(contentPadding: EdgeInsets.only(right: 10.0, top: 15.0),
          prefixIcon: Icon(Icons.search),
          hintText: "متن جستجو را وارد کنید",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
  //Create a ListView widget
  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _codes.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.white,
              elevation: 5.0,
              child: new Container(
                margin: EdgeInsets.all(15.0),
                child: new Text("${_codes[index]}"),
              ),
            );
          }),
    );
  }
  */

/*
  //Perform actual search
  Widget _performSearch() {
    _filterList = new List<String>();
    for (int i = 0; i < _codes.length; i++) {
      var item = _codes[i];
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }
*/

  onSearchTextChanged(String text) async {
    _searchResult.clear();

    setState(() {    _notShowNullView = false;
    });
    _searchResultNumber = 0;
    _showMostUsedCodesFlag = false;
    _mostUsedCodes.clear();
    _mostUsedCodesNum = 0;
    if (text.isEmpty) {
      setState(() {
//        _searchResultNumber = 0;
//        _searchResult.clear();
        _showMostUsedCodesFlag = true;
        getMostUsedCodes();
      });
      return;
    }

    _codesList.forEach((codeDetail) {
      if (codeDetail.id.contains(text) || codeDetail.data.contains(text))
        _searchResult.add(codeDetail);
//      setState(() {});
    });

    _searchResultNumber = _searchResult.length;

    setState(() {});
//    return;
  }

/*
    _userDetails.forEach((userDetail) {
      if (userDetail.id.contains(text) || userDetail.data.contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
  */
}

List<Code> _searchResult = [];

//List<UserDetails> _userDetails = [];

final String url = 'https://api.myjson.com/bins/15p1ix';

class UserDetails {
  final String id;
  final String data;

  UserDetails({this.id, this.data});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['id'],
      data: json['data'],
    );
  }
}

List<Code> _codesList = [];
//List<Code> _savedList = [];
List<CodeNew> _mostUsedCodes = [];


/*
var _codesList1;

class CodesList {
  final List<Code> codes;

  CodesList({
    this.codes
  });
  factory CodesList.fromJson(List<dynamic> parsedJson){

    List<Code> codes = new List<Code>();
    codes = parsedJson.map((i)=>Code.fromJson(i)).toList();

    //_codesList = codes;

    return new CodesList(
        codes: codes
    );
  }
}
*/
class Code {
  //final String categoryId;
  final String id;
  final String data;
  final String proRate;
  final String techRate;
  final String valueRate;

  //final String proRate;
  //final String techRate;
  //final String valueRate;

  Code({
    this.id,
    this.data,
    //this.categoryId,
    this.proRate,
    this.techRate,
    this.valueRate
  });

  factory Code.fromJson(Map<String, dynamic> json) {
    return new Code(
      id: json['id'].toString(),
      data: json['data'],
      //categoryId: json['categoryId'].toString(),
      proRate: json['proRate'].toString(),
      techRate: json['techRate'].toString(),
      valueRate: json['valueRate'].toString()
    );
  }

/*
  //Create the Filtered ListView
  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.white,
              elevation: 5.0,
              child: new Container(
                margin: EdgeInsets.all(15.0),
                child: new Text("${_filterList[index]}"),
              ),
            );
          }),
    );
  }
}

*/

/*
class DataSearch extends SearchDelegate<String>{

  final codes = [
    "Gorgan",
    "Tehran",
    "Shiraz",
    "Esfahan",
    "Tabriz",
    "Mashhad",
    "Yazd"
  ];

  final recentCodes = [
    "Gorgan"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // implement buildActions
    // actions for appbar
    return [IconButton(icon: Icon(Icons.clear),onPressed: (){
      query = '';
    } ,)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //  implement buildLeading
    //leading icon on the left of appbar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,),
      onPressed: () {
        close(context, null);
      } ,);

  }

  @override
  Widget buildResults(BuildContext context) {
    //  implement buildResults

    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //  implement buildSuggestions
    final suggestionList = query.isEmpty ? recentCodes : codes.where((p) => p.startsWith(query)).toList();

    return ListView.builder(itemBuilder: (context, index) => ListTile(
      leading: Icon(Icons.code),
      title: Text(suggestionList[index]),
    ),
      itemCount: suggestionList.length,
    );
  }

}
*/

}

/*
class SavedCodeNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//List<Widget> widgetList = [];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 10.0,
            backgroundColor: Colors.green,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.calendar_view_day),
                  text: "انتخاب بازه",
                ),
                Tab(
                  icon: Icon(Icons.calendar_today),
                  text: "ماهانه",
                ),
                Tab(
                  icon: Icon(Icons.today),
                  text: "روزانه",
                ),
              ],
            ),
            title: Text('کدهای ذخیره شده'),
          ),
          body: TabBarView(
            children: [
//Range Saved codes
              FutureBuilder<List<CodeNew>>(
                future: DBProvider.db.getTodayCodeNews(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CodeNew>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        CodeNew item = snapshot.data[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(color: Colors.red),
                          onDismissed: (direction) {
                            DBProvider.db.deleteCodeNew(item.id);
                          },
                          child: ListTile(
                            title: Text(item.codeId.toString()),
                            leading: Text(item.id.toString()),
                            trailing: Checkbox(
                              onChanged: (bool value) {
                                DBProvider.db.blockOrUnblock(item);
                                //setState(() {});
                              },
                              value: item.blocked,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),

//This month Saved codes
              Column(
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  ),

                ],
              ),

//Today Saved codes List
              FutureBuilder<List<CodeNew>>(
                future: DBProvider.db.getAllCodeNews(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CodeNew>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        CodeNew item = snapshot.data[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(color: Colors.red),
                          onDismissed: (direction) {
                            DBProvider.db.deleteCodeNew(item.id);
                          },
                          child: ListTile(
                            title: Text(item.codeId.toString()),
                            leading: Text(item.id.toString()),
                            trailing: Checkbox(
                              onChanged: (bool value) {
                                DBProvider.db.blockOrUnblock(item);
                                //setState(() {});
                              },
                              value: item.blocked,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );

//  implement build
  }
//void setState(Null Function() param0) {
//}
}
*/

// ignore: must_be_immutable
class TextFieldAlertDialog extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "TextField in Dialog"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField in AlertDialog'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Show Alert Dialog'),
          color: Colors.red,
          onPressed: () => _displayDialog(context),
        ),
      ),
    );
  }
}


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
                  style: new TextStyle(color: Colors.blue,fontSize: 12.0),
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