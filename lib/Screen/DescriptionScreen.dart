import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  @override
  DescriptionPage createState() => DescriptionPage();
}

class DescriptionPage extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(123, 202, 204, 10.0),
        title: Text(
          "توضیحات",
          style: TextStyle(fontFamily: 'Shabnam',fontSize: 16.0),
        ),
      ),
      body: new Card(
        elevation: 10.0,
//        margin: EdgeInsets.all(5.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: new Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(alignment: Alignment.center,
                  children: <Widget>[
                    new Card(elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: <Widget>[
                            new Text(
                              "با توجه به اینکه پرداخت های پزشکان در اکثر مراکز دولتی و بعضا خصوصی با تاخیر زیاد انجام می شود و پزشکان معمولا پس از یک سال، سابقه ای از خدمات انجام شده توسط خود را به خاطر نداشته و این موضوع موجب نارضایتی و عدم اعتماد پزشک به سیستم مالی بیمارستان می شود، اپلیکیشن پزشک یار تلاش کرده است که با ثبت خدمات انجام شده توسط پزشک با جزئیات کامل، اطلاعات مورد نیاز در هنگام محاسبه کارانه را در اختیار پزشکان قرار دهد. اپلیکیشن پزشک یار به منظور تسهیل دسترسی پزشکان به ویرایش سوم کتاب ارزش های نسبی خدمات تشخیصی درمانی تهیه شده است. شما در این نرم افزار امکان جستجو بر اساس اقدامات و کدهای مختلف را داشته و می توانید کای حرفه ای کلیه خدماتی که در روز انجام می دهید را در سیستم ثبت نموده و در پایان روز یا ماه آمار عملکردی خود را مشاهده نمایید. برای محاسبه میزان دریافتی می توانید میزان کارکرد جزء حرفه ای خود را بصورت ریالی یا تعداد کا خدمات انجام شده در سیستم مشاهده نمایید و محاسبه طبق تصویب نامه هیئت وزیران بصورت پلکانی برای شما انجام خواهد شد ",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Shabnam',
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),


                    Container(
                          alignment: Alignment(0.0, 0.0),
                      height: 150.0,
                      width: 150.0,
//                      margin: EdgeInsets.only(right: 200.0),
                      decoration:
                      BoxDecoration(
//                  borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: new AssetImage('assets/images/image.jpg'),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.dstATop),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),


                  ],
                ),
                new Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(margin: EdgeInsets.only(left: 8.0),
                                height: 100.0,
                                width: 150.0,
                                child: new Image(
                                    image: AssetImage(
                                  'assets/images/logo_avije.png',
                                ))),
//                            Container(margin: EdgeInsets.only(right: 8.0),
//                              child: new Image(height: 100.0,width: 150.0,
//                                image: AssetImage('assets/images/logo.png'),
//                              ),
//                            ),


                          ],
                        ),

//                        new Text("آویژه"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text("شماره پشتیبانی: 63-02188566557",style: TextStyle(fontSize: 14.0),),
                        ),

                      ],

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
