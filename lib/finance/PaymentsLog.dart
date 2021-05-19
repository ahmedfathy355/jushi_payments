import 'dart:async';
import 'package:JushiPayments/modle/getPayments.dart';
import 'package:JushiPayments/utility/Localizations/localization_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calendar_strip/calendar_strip.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class PaymentsLog extends StatefulWidget {

  final String filterDateStr ;
  PaymentsLog( {Key key , @required this.filterDateStr }) : super (key:key);
  @override
  _PaymentsLog createState() => _PaymentsLog();
}

DateTime startDate = DateTime.now().subtract(Duration(days: 365));
DateTime endDate = DateTime.now().add(Duration(days: 0));
DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));
List<DateTime> markedDates = [
  DateTime.now().subtract(Duration(days: 0))
//  DateTime.now().subtract(Duration(days: 0)),
//  DateTime.now().add(Duration(days: 4))
];


DateTime _selectedDay = DateTime.now();
DateTime _selectedFirstOfMonth = (now.month < 12) ? new DateTime(now.year, now.month  , 0) : new DateTime(now.year + 1, 1, 0);
var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');




class _PaymentsLog extends State<PaymentsLog> {
  SharedPreferences prefs;
  List<getPayments> _paymentsList = [];

  Future<List<getPayments>> _getPayments() async{
    try{
      prefs = await SharedPreferences.getInstance();
      if(widget.filterDateStr == "Month")
      {
        _paymentsList = await EmployeePayments(http.Client(), formatter.format(_selectedFirstOfMonth.add(Duration(days: 1))),formatter.format(_selectedDay), prefs.getInt("txt_Emp_ID"));
      }
      else
      {
        _paymentsList = await EmployeePayments(http.Client(), formatter.format(_selectedDay),formatter.format(_selectedDay), prefs.getInt("txt_Emp_ID"));
      }
    }
    catch(e)
    {
      print(e);
    }
    return _paymentsList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),
//      appBar: AppBar(
//        title: Text("Choco Factory"),
//      ),
      body:  Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: CalendarStrip(
              startDate: startDate,
              endDate: endDate,
              onDateSelected: (date) {
                // New date selected
                setState(() {
                  _paymentsList.clear();
                  _selectedDay = date;
                });},
              dateTileBuilder: dateTileBuilder,
              iconColor: Colors.black87,
              monthNameWidget: _monthNameWidget,
              markedDates: markedDates,
              containerDecoration: BoxDecoration(color: const Color(0xfff2f4f7)),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 120),
            child:
            FutureBuilder(
                future: _getPayments(),
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                    {
                      if(_paymentsList.length > 0)
                        {
                          return new ListView.builder(itemBuilder: (_,int index) => listLog(context,this._paymentsList,index),
                          itemCount: this._paymentsList.length,
                        );
                        }
                      else{
                        return Center(child: Text(getTranslated(context, 'No_Data')),);
                      }
                    }
                  else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },)
          ),
        ],
      ),

    );
  }



  _monthNameWidget(monthName) {
    return Container(
      child: Text(monthName,
          style:
          TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black87, fontStyle: FontStyle.italic)),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
      Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      )
    ]);
  }

  dateTileBuilder(date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(), style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

}


Widget listLog (BuildContext context , List<getPayments> _list , int _index)
{
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x08000000),
                        offset: Offset(0, 10),
                        blurRadius: 30)
                  ],
                ),
                child:
                Container(
                  margin: EdgeInsets.only(left:60,right:  60 ,top: 2),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Circular Std Book',
                            fontSize: 15,
                            color: const Color(0xff3A4759),
                            height: 0.45,
                          ),
                          children: [
                            TextSpan(
                              text: _list[_index].Amount.toString()+ '\n\n',
                              style: TextStyle(
                                fontFamily: 'Circular Std Book',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: '  '+ getTranslated(context, _list[_index].Area.toString())  ,
                            ),
                          ],
                        ),
                      ),

                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Circular Std Medium',
                            fontSize: 15,
                            color: const Color(0xffa6b1c0),
                            height: 0.45,
                          ),
                          children: [
                            TextSpan(
                              text: _list[_index].CreatedDate.substring(0, 10).toString() + '\n\n',
                              style: TextStyle(
                                fontFamily: 'Circular Std Bold',
                                color:const Color(0xffa6b1c0),

                              ),
                            ),
                            TextSpan(
                              text:  _list[_index].Time ,
                              style: TextStyle(
                                fontFamily: 'Circular Std Book',
                                color: const Color(0xffa6b1c0),
                                letterSpacing: 0.76,
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),

                ),
              ),

              //color box
              Transform.translate(
                offset: Offset(-10,7),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(67.0),
                    gradient: LinearGradient(
                      begin: Alignment(-1.0, -1.0),
                      end: Alignment(-1.0, 1.0),
                      //colors: [const Color(0xfff953c6), const Color(0xffb91d73)],
                      colors: [const Color(0xfffbe6d4), const Color(0xfff7fbe1)],
                      stops: [0.0, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x33ff8f91),
                          offset: Offset(0, 5),
                          blurRadius: 20)
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 0,right: 18, top: 13),
                child: (_list[_index].Area.toString() == "SuperMarket") ? SvgPicture.asset("assets/images/supermarket1.svg",height: 32,width: 32,) : SvgPicture.asset("assets/images/cafe.svg",height: 32,width: 32,) ,
              ),
            ],
          ),
        ],
      ),
    );

}



