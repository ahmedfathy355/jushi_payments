import 'dart:async';
import 'dart:io';
import 'package:JushiPayments/finance/PaymentsLog.dart';
import 'package:JushiPayments/finance/RechargeLog.dart';
import 'package:JushiPayments/finance/transfare.dart';
import 'package:JushiPayments/login.dart';
import 'package:JushiPayments/modle/TodayBalance.dart';
import 'package:JushiPayments/utility/Localizations/localization_constants.dart';
import 'package:JushiPayments/utility/Setting_ui/change_password.dart';
import 'package:JushiPayments/utility/Setting_ui/languages_screen.dart';
import 'package:JushiPayments/utility/Setting_ui/settings_list.dart';
import 'package:JushiPayments/utility/Setting_ui/settings_section.dart';
import 'package:JushiPayments/utility/Setting_ui/settings_tile.dart';
import 'package:JushiPayments/utility/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:connectivity/connectivity.dart';


class WalletHome extends StatefulWidget {

  final String EmpName;
  WalletHome({Key key, @required this.EmpName}) : super(key: key);

  @override
  _WalletHomeState createState() => _WalletHomeState();
}

class _WalletHomeState extends State<WalletHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SharedPreferences prefs;
  List<TodayBalance> _list = [];
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  bool lockInBackground = true;
  bool notificationsEnabled = true;
  String _code;
  Locale _locale;

  @override
  void initState() {
    super.initState();
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
        if(_locale.languageCode == 'en')
        {_code = "English";}
        else if(_locale.languageCode == 'ar')
        {_code = "عربى";}
        else if(_locale.languageCode == 'zh')
        {_code = "Chinese";}
      });
    });
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _total();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
        if(_locale.languageCode == 'en')
        {_code = "English";}
        else if(_locale.languageCode == 'ar')
        {_code = "عربى";}
        else if(_locale.languageCode == 'zh')
        {_code = "Chinese";}
      });
    });
    super.didChangeDependencies();
  }


  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

//     if(_connectionStatus == "ConnectivityResult.none" )
//      {
//      return Scaffold(
//        backgroundColor: const Color(0xfff2f4f7),
//        body: Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//
//              children: <Widget>[
//                Image.asset("assets/images/lostconnection.png"),
//                Text(
//                  getTranslated(context, "ConnectivityResult.none"),
//                  style: TextStyle(
//                    fontFamily: 'Circular Std Medium',
//                    fontSize: 18,
//                    color: const Color(0xff8851F1),
//                  ),
//                  textAlign: TextAlign.center,
//                ),
//              ],
//            )
//        ),
//      );
//    }
//    else
//    {
      return Scaffold(
        key: _scaffoldKey,
        drawer:SettingsList(
          sections: [
            SettingsSection(
              title: getTranslated(context, 'Localize'),
              tiles: [
                SettingsTile(
                  title: getTranslated(context, 'Language'),
                  //subtitle: 'English',
                  subtitle:  _code,
                  leading: Icon(Icons.language),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => LanguagesScreen())).then((value) {
                      setState(() {
                        _total();
                      });
                    });
                  },
                ),
              ],
            ),
            SettingsSection(
              title: getTranslated(context, 'Account'),
              tiles: [
                SettingsTile(title: getTranslated(context, 'Password'), leading: Icon(Icons.security),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => change_password()));
                  },
                ),
                SettingsTile(title: getTranslated(context, 'Sign_out'), leading: Icon(Icons.exit_to_app),onTap: (){
                  signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login() ));
                },),
              ],
            ),
          ],
        ),
        backgroundColor: const Color(0xfff2f4f7),
        body:
        Container(
          margin: EdgeInsets.only(top: 24),
          child:
          OfflineBuilder(
            connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,) {
                  final bool connected = connectivity != ConnectivityResult.none;
                  return new Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Positioned(
                        height: 24,
                        left: 0.0,
                        right: 0.0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          color: connected ? null : Color(0xFFEE4400),
                          child:  connected ? null : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('OFFLINE' ,style: TextStyle(color: Colors.white),),
                              SizedBox(width: 12),
                              SizedBox(height: 12,width: 12,child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2,
                              ),)
                              //Text("${connected ? 'ONLINE' : 'OFFLINE'}")
                            ],
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: _total(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData)
                          {
                            return _sc();
                          }
                          else if(snapshot.connectionState == ConnectionState.none)
                            {
                              return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,

                                    children: <Widget>[
                                      Image.asset("assets/images/lostconnection.png"),
                                      Text(
                                        getTranslated(context, "ConnectivityResult.none"),
                                        style: TextStyle(
                                          fontFamily: 'Circular Std Medium',
                                          fontSize: 18,
                                          color: const Color(0xff8851F1),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                              );
                            }
                          else
                          {
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      ),
                    ],
                  );
                },
                child:  FutureBuilder(
                  future: _total(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData)
                    {
                      return _sc();
                    }
                    else
                    {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
        ),
      );
  }

  Widget _sc(){
    return  SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //lastUpdate Bar
            Utils.StatusCode!=200 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    color: Colors.red,
                    child: Text("Server Offline , Last Update " + DateTime.now().year.toString() + "-" +DateTime.now().month.toString() + "-"+ (DateTime.now().day-1).toString() ,style: TextStyle(backgroundColor: Colors.red,color: Colors.white),),
                  ),
                )
              ],
            ) : Container(),
            //Name + settings icon
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(5,5,5,0),
                  child: Container(
                    height: 48,
                    width: 48,
                    child: IconButton(
                      icon: const Icon(Icons.menu),
                      iconSize: 32,
                      color: const Color(0xff3A4759),
                      tooltip: 'Setting',
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen() ));
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
//                    child: GestureDetector(
//                      child: SvgPicture.asset(
//                        "assets/images/open-menu.svg",height: 28,width: 28,
//                      ),
//                      onTap: (){
//                        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen() ));
//                      },
//                    ),
                  ),
                ),
                Utils.NeedChangePassword == true ? GestureDetector(
                  child: Container(child: Image.asset("assets/images/notification.png"),height: 32,),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => change_password())).then((value) {
                      setState(() {
                        _total();
                      });
                    });
                  },
                ) : Container(),
                Padding(
                  padding: EdgeInsets.fromLTRB(20,5,20,0),
                  child: Text(
                    widget.EmpName.length> 20 ? widget.EmpName.substring(0,20) : widget.EmpName,
                    style: TextStyle(
                      fontFamily: 'Circular Std Medium',
                      fontSize: 20,
                      color: const Color(0xffb5076b),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(height:10 ,),
            //text 'Today records'
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20,0,20,0),
                  child:  Text(
                    getTranslated(context, 'Today_Records'),
                    style: TextStyle(
                      fontFamily: 'Circular Std Medium',
                      fontSize: 19,
                      color: const Color(0xff3a4759),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20,0,20,0),
                  child: Container(
                    child: Text(
                      formatter.format(now),
                      style: TextStyle(
                        fontFamily: 'Circular Std Medium',
                        fontSize: 19,
                        color: const Color(0xff3a4759),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),

            //Total 2 Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //box 1
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: MaterialButton(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          begin: Alignment(1,-1),
                          end: Alignment(-1, 1),
                          colors: [const Color(0xfff953c6), const Color(0xffb91d73)],
                          stops: [0.0, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x33ab60ef),
                              offset: Offset(0, 10),
                              blurRadius: 10)
                        ],
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    getTranslated(context, 'PaymentsToday'),
                                    style: TextStyle(
                                      fontFamily: 'Circular Std Book',
                                      fontSize:20,
                                      color: const Color(0xccffffff), )
                                ),
                                SizedBox(height:10 ,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                        _list[0].todayPayments.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Circular Std Book',
                                          fontSize: 35,
                                          color: const Color(0xffF2F4F7),
                                        )),
                                  ],
                                )

                              ]
                          ),
                        ],
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentsLog(filterDateStr: "Day"))).then((value) {
                        setState(() {
                          _total();
                        });
                      });
                    },
                  )
                ),

                //box 2
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: MaterialButton(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          begin: Alignment(1.0, -1.0),
                          end: Alignment(-1.0, 1.0),
                          colors: [const Color(0xff43cea2), const Color(0xff185a9d)],
                          stops: [0.0, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x3347eee2),
                              offset: Offset(0, 10),
                              blurRadius: 10)
                        ],
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    getTranslated(context, 'Recharge'),
                                    style: TextStyle(
                                      fontFamily: 'Circular Std Book',
                                      fontSize:20,
                                      color: const Color(0xccffffff), )
                                ),
                                SizedBox(height:10 ,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                        _list[0].todayRecharge.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Circular Std Book',
                                          fontSize: 35,
                                          color: const Color(0xffF2F4F7),
                                        )),
                                  ],
                                )

                              ]
                          ),
                        ],
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RechargeLog(filterDateStr: "Day")   )).then((value) {
                        setState(() {
                          _total();
                        });
                      });
                    },
                  )
                ),
              ],
            ),

            SizedBox(height:15 ,),

            // white box shadow My Wallet
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Container(
                    width: MediaQuery.of(context).size.width -40 ,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0x9effffff),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x08000000),
                            offset: Offset(0, 30),
                            blurRadius: 40)
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      width: MediaQuery.of(context).size.width ,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x14000000),
                              offset: Offset(0*0.30, 30*0.30),
                              blurRadius: 40)
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(height:10 ,),
                              Text(
                                getTranslated(context, 'Total_Balance'),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: const Color(0xffa6b1c0),
                                ),
                              ),
                              SizedBox(height:10 ,),
                              Text(_list[0].totalBalance.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Circular Std Book',
                                    fontSize: 35,
                                    color: const Color(0xff4e54c8),
                                  )),

                            ],
                          )
                        ],
                      ) ,
                    ),
                  ),
                  //box 4

                  //box 4 Total Balance

                ),
              ],
            ),

            SizedBox(height:5 ,),
            
            //text Last Records Overview
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width - 40,
              child: Text(
                getTranslated(context, 'Month_Records_Overview'),
                style: TextStyle(
                  fontFamily: 'Circular Std Medium',
                  fontSize: 18,
                  color: const Color(0xff3a4759),
                ),
              ),
            ),

            SizedBox(height:5 ,),
            //////////////////////////////////////////////////////////////////////////////////
            //rectangle 1
            //Payments
            MaterialButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 75,
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
                                fontFamily: 'Circular Std Medium',
                                color: const Color(0xff3a4759),
                                fontSize: 18,
                                height: 1.50,
                              ),
                              children: [
                                TextSpan( text: ' ' +getTranslated(context, 'Payments')+'\n',),

                              ],
                            ),
                          ),
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Circular Std Medium',
                                  fontSize: 18,
                                  height: 1.30,

                                ),
                                children: [
                                  TextSpan(
                                    text: _list[0].monthlyPayments.toString()+'\n',
                                    style: TextStyle(
                                      fontFamily: 'Circular Std Book',
                                      fontSize: 18,
                                      color: const Color(0xfff953c6),
                                    ),
                                  ),
                                  TextSpan( text: getTranslated(context, 'View_Log'),
                                    style: TextStyle(
                                      fontFamily: 'Circular Std Book',
                                      fontSize: 12,
                                      color: const Color(0xffa6b1c0),
                                      letterSpacing: 0.8,
                                    ),
                                  ),
//                                  TextSpan(
//                                    text: getTranslated(context, 'This_Month'),
//                                    style: TextStyle(
//                                      fontFamily: 'Circular Std Book',
//                                      color: const Color(0xffa6b1c0),
//                                      fontSize: 15,
//                                      letterSpacing: 0.8,
//                                    ),
//                                  ),
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
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                              begin: Alignment(1.0, -1.0),
                              end: Alignment(-1.0, 1.0),
                              colors: [const Color(0xfff953c6), const Color(0xffb91d73)],
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x47ff958f),
                                  offset: Offset(0, 6),
                                  blurRadius: 20)
                            ],
                          ),
                        ),
                      ),
                     Container(
                       margin: EdgeInsets.only(left: 0,right: 20, top: 13),
                       child:  SvgPicture.asset(
                         "assets/images/atm.svg",height: 32,width: 32,
                       ),
                     ),
                    ],
                  ),


                ],
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentsLog(filterDateStr: "Month"))).then((value) {
                  setState(() {
                    _total();
                  });
                });
              },
            ),

            SizedBox(height:10 ,),
            //////////////////////////////////////////////////////////////////////////////////
            //Rectangle 2
            //Charges
            MaterialButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 75,
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
                                    fontFamily: 'Circular Std Medium',
                                    fontSize: 18,
                                    color: const Color(0xff3a4759),
                                    height: 1.50,
                                  ),
                                  children: [
                                    TextSpan( text: ' ' + getTranslated(context, 'Recharge') + '\n',  ),

                                  ],
                                ),
                              ),

                              Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Circular Std Medium',
                                    fontSize: 18,
                                    color: const Color(0xffa6b1c0),
                                    height: 1.90,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: _list[0].monthlyRecharge.toString()+'\n',
                                      style: TextStyle(
                                        fontFamily: 'Circular Std Book',
                                        color: const Color(0xff43cea2),
                                        fontSize: 18,
                                      ),
                                    ),
                                    TextSpan( text: ' ' + getTranslated(context, 'View_Log'),
                                      style: TextStyle(
                                        fontFamily: 'Circular Std Book',
                                        fontSize: 12,
                                        color: const Color(0xffa6b1c0),
                                        letterSpacing: 0.8,
                                      ),
                                    ),
//                                    TextSpan(
//                                      text: getTranslated(context, 'This_Month'),
//                                      style: TextStyle(
//                                        fontFamily: 'Circular Std Book',
//                                        fontSize: 15,
//                                      ),
//                                    ),
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
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                              begin: Alignment(1.0, -1.0),
                              end: Alignment(-1.0, 1.0),
                              colors: [const Color(0xff43cea2), const Color(0xff185a9d)],

                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0xffa6b1c0),
                                  offset: Offset(0, 6),
                                  blurRadius: 20)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 0,right: 20, top: 13),
                        child: SvgPicture.asset(
                          "assets/images/money.svg",height: 32,width: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RechargeLog(filterDateStr: "Month"))).then((value) {
                  setState(() {
                    _total();
                  });
                });
              },
            ),

            SizedBox(height:10 ,),
            //////////////////////////////////////////////////////////////////////////////////
            // box 3
            // transfare
            MaterialButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 75,
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
                                    fontFamily: 'Circular Std Medium',
                                    fontSize: 18,
                                    color: const Color(0xff3a4759),
                                    height: 1.50,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' ' +getTranslated(context, 'Transfares') + '\n',
                                    ),

                                  ],
                                ),
                              ),

                              Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Circular Std Medium',
                                    fontSize: 18,
                                    color: const Color(0xffa6b1c0),
                                    height: 1.9,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: _list[0].monthlyTransfare.toString()+'\n',
                                      style: TextStyle(
                                        fontFamily: 'Circular Std Book',
                                        color: const Color(0xff4e54c8),
                                        letterSpacing: 0.76,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ' +getTranslated(context, 'View_Log'),
                                      style: TextStyle(
                                        fontFamily: 'Circular Std Book',
                                        fontSize: 12,
                                        color: const Color(0xffa6b1c0),
                                        letterSpacing: 0.8,
                                      ),
                                    ),
//                                    TextSpan(
//                                      text: getTranslated(context, 'This_Month'),
//                                      style: TextStyle(
//                                        fontFamily: 'Circular Std Book',
//                                        fontSize: 15,
//                                      ),
//                                    ),
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
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                              begin: Alignment(1.0, -1.0),
                              end: Alignment(-1.0, 1.0),
                              colors: [const Color(0xff4e54c8), const Color(0xff8f94fb)],
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x473fece4),
                                  offset: Offset(0, 6),
                                  blurRadius: 20)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 0,right: 20, top: 13),
                        child: SvgPicture.asset(
                          "assets/images/transaction.svg",height: 32,width: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TransfareBalance(connectionStatus: _connectionStatus,) )).then((value) {
                  setState(() {
                    _total();
                  });
                });
              },
            ),



//          Transform.translate(
//            offset: Offset(102.5*0.30, 1852.5*0.30),
//            child: SvgPicture.string(
//              _shapeSVG_29d18e60df15422aa18d65d23b288a96,
//              allowDrawingOutsideViewBox: true,
//            ),
//          ),

//          Transform.translate(
//            offset: Offset(300.0*0.30, 218.0*0.30),
//            child: Text(
//              'Ahmed Fathy Mohamed',
//              style: TextStyle(
//                fontFamily: 'Circular Std Medium',
//                fontSize: 70*0.30,
//                color: const Color(0xff3a4759),
//              ),
//              textAlign: TextAlign.left,
//            ),
//          ),
//menu icon
//          Transform.translate(
//            offset: Offset(57.0*0.30, 233.2*0.30),
//            child: SvgPicture.string(
//              _shapeSVG_8f8f679547a84a4092a6780c3f207d0a,
//              allowDrawingOutsideViewBox: true,
//            ),
//          ),

            //orange point
//          Transform.translate(
//            offset: Offset(-1.0*0.30, 21.0*0.30),
//            child: Stack(
//              children: <Widget>[
//                Transform.translate(
//                  offset: Offset(1044.0*0.30, 206.0*0.30),
//                  child: Container(
//                    width: 22.0*0.30,
//                    height: 22.0*0.30,
//                    decoration: BoxDecoration(
//                      borderRadius:
//                          BorderRadius.all(Radius.elliptical(11.0, 11.0)),
//                      color: const Color(0xffff958f),
//                      boxShadow: [
//                        BoxShadow(
//                            color: const Color(0x33ff8f91),
//                            offset: Offset(0*0.30, 20*0.30),
//                            blurRadius: 20)
//                      ],
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
          ],
        ),
      ),
    );
  }

  Future<List<TodayBalance>> _total() async{
    try{
      prefs = await SharedPreferences.getInstance();
      //_list = await fetchTotalsByID(http.Client() , prefs.getInt("txt_Emp_ID") ).timeout(Duration(seconds: 6),onTimeout: () => _list = null,);
      _list = await fetchTotalsByID(http.Client() , prefs.getInt("txt_Emp_ID") ,_connectionStatus == "ConnectivityResult.none" ? false : true);
    }
    catch(e)
    {
      print(e);
    }
    return _list;
  }

  signOut() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("txt_Emp_ID", null);
      prefs.setString("txt_Emp_Password", null);
      prefs.setString("Name", null);
      prefs.setBool("Login", false);
      prefs.setString("Mobile", null);
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
            await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
              await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
            await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
              await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }


}

