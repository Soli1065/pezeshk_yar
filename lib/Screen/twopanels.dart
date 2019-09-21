import 'package:flutter/material.dart';
import 'package:jalali_date/jalali_date.dart';
import 'package:pezeshk_yar/Screen/Database.dart';
import 'package:pezeshk_yar/Screen/CodeNewModel.dart';
import 'package:persian_datepicker/persian_datepicker.dart';

class TwoPanels extends StatefulWidget {
  final AnimationController controller;

  TwoPanels({this.controller});

  @override
  _TwoPanelsState createState() => new _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {
  static const header_height = 38.0;

  TextEditingController _firstDatePickerController = new TextEditingController();
  PersianDatePickerWidget persianDatePicker;


  @override
  void initState() {
    persianDatePicker = PersianDatePicker(controller: _firstDatePickerController,).init();
    super.initState();
  }

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    final frontPanelHeight = -header_height;

    return new RelativeRectTween(
            begin: new RelativeRect.fromLTRB(
                0.0, backPanelHeight, 0.0, frontPanelHeight),
            end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(new CurvedAnimation(
            parent: widget.controller, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            color: Colors.white,
            child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: new FutureBuilder<List<CodeNew>>(
              future: DBProvider.db.getAllCodeNews(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CodeNew>> snapshot) {
                if (snapshot.hasData) {
                  return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      CodeNew item = snapshot.data[index];
                      return new Card(
                        elevation: 8.0,
                        child: new ListTile(
                          title: new Text(
                            item.data,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontFamily: 'Shabnam'),
                          ),
                          subtitle: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: new Column(mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    new Text(
                                      "کد شماره: " + item.codeId,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: 'Shabnam'),
                                    ),
                                    new Text(
                                      "تاریخ ثبت: " +
                                          item.time +
                                          " , " +
                                          item.date,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: 'Shabnam'),
                                    ),
                                    new Text("نام بیمار: " +
                                        item.name,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: 'Shabnam'),),
                                    new Text("شماره پرونده: " +
                                        item.caseNum,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: 'Shabnam'),),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 60.0,
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.delete_forever),
                                  onPressed: () async {
                                    DBProvider.db
                                        .deleteCodeNew(item.id);
//                                              _displaySum();
                                    setState(() {});
                                  },
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
      ),





          new PositionedTransition(
            rect: getPanelAnimation(constraints),
            child:

//                borderRadius: new BorderRadius.only(
//                    topLeft: new Radius.circular(16.0),
//                    topRight: new Radius.circular(16.0)),
               Container(margin: EdgeInsets.only(top: 4.0,right: 4.0,left: 4.0),
                decoration: BoxDecoration(color: Color.fromRGBO(123, 202, 204, 1.0),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),),
                child: SingleChildScrollView(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: header_height,
                        child: new Text(
                          "جستجوی پیشرفته",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),



                      Container(margin: EdgeInsets.only(right: 10.0,left: 10.0,top: 25.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: new Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      left: 4.0,
                                      right: 4.0),
                                  child: new Icon(Icons.date_range,color: Colors.white,),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      right: 4.0,
                                      left: 4.0),
                                  child: new Text(
                                    "از",
                                    style:
                                    TextStyle(fontFamily: 'Shabnam',color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      left: 4.0,
                                      right: 4.0),
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue[200],
                                        borderRadius:
                                        BorderRadius.circular(4.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: new Text(
                                        PersianDate.fromDateTime(
                                            DateTime.parse(
                                                DateTime.now()
                                                    .toString()))
                                            .toString(),style: TextStyle(color: Colors.white),),


//
                                    ),
                                  ),
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      right: 4.0,
                                      left: 4.0),
                                  child: new Icon(
                                    Icons.date_range,color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      right: 4.0,
                                      left: 4.0),
                                  child: new Text(
                                    "تا",
                                    style:
                                    TextStyle(fontFamily: 'Shabnam',color: Colors.white),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      left: 4.0,
                                      right: 4.0),
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue[200],
                                        borderRadius:
                                        BorderRadius.circular(4.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: new Text(
                                          PersianDate.fromDateTime(
                                              DateTime.parse(
                                                  DateTime.now()
                                                      .toString()))
                                              .toString(),style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),


                      Container(margin: EdgeInsets.only(left: 10.0,right: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top:10.0,right: 10.0,left: 10.0),
                          child: new TextField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.assignment_ind,color: Colors.white,),
                                hintText: "نام بیمار",
                                hintStyle:
                                    TextStyle(color: Colors.white,fontFamily: 'Shabnam',fontSize: 16)),
                            textAlign: TextAlign.right,
                            maxLines: 1,
//                                  controller: _patientNameController,
//                                    enabled: true,
//                                    autofocus: false,
                          ),
                        ),
                      ),
                      Container(margin: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: new TextField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.assignment,color: Colors.white,),
                                hintText: "شماره پرونده",
                                hintStyle:
                                    TextStyle(fontFamily: 'Shabnam',color: Colors.white)),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            maxLines: 1,
//                                  controller: _caseNumberController,
                          ),
                        ),
                      ),
                      Container(margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left:10.0, right: 10.0),
                          child: new TextField(
                            decoration: InputDecoration(
                                suffixIcon:
                                    Icon(Icons.assignment_turned_in,color: Colors.white,),
                                hintText: "شماره کد",
                                hintStyle:
                                    TextStyle(fontFamily: 'Shabnam',color: Colors.white)),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            textAlign: TextAlign.right,
//                                  controller: _codeIdController,
                          ),
                        ),
                      ),
                      Container(margin: EdgeInsets.only(top: 40.0),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0,
                              bottom: 10.0,
                              left: 6.0,
                              right: 6.0),
                          child: new RaisedButton(
                            onPressed: () {},
                            elevation: 15.0,
                            color: Colors.blue,
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
            ),
          ]),


    );
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: bothPanels,
    );
  }
}
