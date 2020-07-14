import 'package:JushiPayments/finance/log_history.dart';
import 'package:JushiPayments/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'XD_financeCustomSize4.dart';
import 'transfare.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletHome extends StatefulWidget {

  final String EmpName;
  WalletHome({Key key, @required this.EmpName}) : super(key: key);

  @override
  _WalletHomeState createState() => _WalletHomeState();
}


class _WalletHomeState extends State<WalletHome> {

  @override
  void initState() {
    setState(() {
    });
    super.initState();
  }
  SharedPreferences prefs;

  signOut() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("txt_Emp_ID", null);
      prefs.setString("txt_Emp_Password", null);
      prefs.setString("Name", null);
      prefs.setBool("Login", false);
      prefs.commit();
    });
  }

  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),
      body: SafeArea(
        child: Stack(
          children: <Widget>[

            //Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(50,60,0,0),
                  child: Text(
                    widget.EmpName,
                    style: TextStyle(
                      fontFamily: 'Circular Std Medium',
                      fontSize: 70*0.30,
                      color: const Color(0xff3a4759),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,60,0,0),
                  child: Container(
                    height: 32,
                    width: 32,
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        "assets/images/gear.svg",height: 32,width: 32,
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TransfareBalance() ));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,30,0,0),
                  child: Container(
                    height: 32,
                    width: 32,
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        "assets/images/deposit.svg",height: 32,width: 32,
                      ),
                      onTap: (){
                        signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login() ));
                      },
                    ),
                  ),
                ),
              ],
            ),

            //text
            Transform.translate(
              offset: Offset(51.0*0.30, 358.0*0.30),
              child: Text(
                'Today Records',
                style: TextStyle(
                  fontFamily: 'Circular Std Medium',
                  fontSize: 60*0.30,
                  color: const Color(0xff3a4759),
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.left,
              ),
            ),

//          Transform.translate(
//            offset: Offset(-2.0*0.30, 0.0*0.30),
//            child: Stack(
//              children: <Widget>[
////                Transform.translate(
////                  offset: Offset(70.0*0.30, 43.0*0.30),
////                  child: Text(
////                    '09:41',
////                    style: TextStyle(
////                      fontFamily: 'SF UI Display',
////                      fontSize: 45*0.30,
////                      color: const Color(0xff3a4759),
////                      fontWeight: FontWeight.w600,
////                    ),
////                    textAlign: TextAlign.left,
////                  ),
////                ),
//                // wifi icon
////                Transform.translate(
////                  offset: Offset(891.0*0.30, 57.78*0.30),
////                  child:
////                      // Adobe XD layer: 'Sc2prs.tif_1_' (group)
////                      SvgPicture.string(
////                    _shapeSVG_b9beb40ee97b414fb377d0eba24d8eca,
////                    allowDrawingOutsideViewBox: true,
////                  ),
////                ),
////                Transform.translate(
////                  offset: Offset(948.0*0.30, 58.04*0.30),
////                  child:
////                      // Adobe XD layer: 'Sc2prs.tif_1_' (group)
////                      Stack(
////                    children: <Widget>[],
////                  ),
////                ),
//              ],
//            ),
//          ),
//          Transform.translate(
//            offset: Offset(362.0*0.30, 2397.29*0.30),
//            child: Container(
//              width: 402.0*0.30,
//              height: 14.9*0.30,
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(8.0),
//                color: const Color(0xffdee2eb),
//              ),
//            ),
//          ),

            // box 1
            Transform.translate(
              offset: Offset(51.0*0.30, 508.0*0.30),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 230.0*0.30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    begin: Alignment(1.0, -1.0),
                    end: Alignment(-1.0, 1.0),
                    colors: [const Color(0xfff953c6), const Color(0xffb91d73)],
                    stops: [0.0, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x33ab60ef),
                        offset: Offset(0*0.30, 20*0.30),
                        blurRadius: 30)
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(120.0*0.30, 585.0*0.31),
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0.0*0.30, 48.43*0.30),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Circular Std Book',
                          fontSize: 31*0.40,
                          color: const Color(0xffffffff),
                          height: 1.2727272727272727*0.30,
                        ),
                        children: [
                          TextSpan(
                            text: '\-25.00 LE',
                            style: TextStyle(
                              fontSize: 55*0.40,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0.0*0.30, -35.5*0.30),
                    child: Text(
                      'Payments',
                      style: TextStyle(
                        fontFamily: 'Circular Std Book',
                        fontSize: 40*0.40,
                        color: const Color(0xccffffff),
                        height: 1.725*0.40,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            //box 2
//          Transform.translate(
//            offset: Offset(403.0*0.33, 508.0*0.30),
//            child: Container(
//              width: MediaQuery.of(context).size.width / 3.6,
//              height: 230.0*0.30,
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(20.0),
//                gradient: LinearGradient(
//                  begin: Alignment(1.0, -1.0),
//                  end: Alignment(-1.0, 1.0),
//                  colors: [const Color(0xff4e54c8), const Color(0xff8f94fb)],
//                  stops: [0.0, 1.0],
//                ),
//                boxShadow: [
//                  BoxShadow(
//                      color: const Color(0x33ff8f91),
//                      offset: Offset(0*0.30, 20*0.30),
//                      blurRadius: 20)
//                ],
//              ),
//            ),
//          ),
//          Transform.translate(
//            offset: Offset(448.0*0.33, 585.0*0.31),
//            child: Stack(
//              children: <Widget>[
//                Transform.translate(
//                  offset: Offset(0.0*0.30, 48.43*0.30),
//                  child: Text.rich(
//                    TextSpan(
//                      style: TextStyle(
//                        fontFamily: 'Circular Std Book',
//                        fontSize: 31*0.30,
//                        color: const Color(0xffffffff),
//                        height: 1.2727272727272727*0.30,
//                      ),
//                      children: [
//                        TextSpan(
//                          text: '\-15.00 LE',
//                          style: TextStyle(
//                            fontSize: 55*0.30,
//                          ),
//                        ),
//                      ],
//                    ),
//                    textAlign: TextAlign.left,
//                  ),
//                ),
//                Transform.translate(
//                  offset: Offset(0.0*0.30, -35.5*0.30),
//                  child: Text(
//                    'Resturant',
//                    style: TextStyle(
//                      fontFamily: 'Circular Std Book',
//                      fontSize: 40*0.30,
//                      color: const Color(0xccffffff),
//                      height: 1.725*0.30,
//                    ),
//                    textAlign: TextAlign.left,
//                  ),
//                ),
//              ],
//            ),
//          ),
            //box 3
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width - 180 , 152),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 230.0*0.30,
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
                        offset: Offset(0*0.30, 20*0.30),
                        blurRadius: 30)
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width - 160, 585.0*0.31),
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0.0*0.30, 48.43*0.30),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Circular Std Book',
                          fontSize: 31*0.40,
                          color: const Color(0xffffffff),
                          height: 1.2727272727272727*0.30,
                        ),
                        children: [
                          TextSpan(
                            text: '\150.00 LE',
                            style: TextStyle(
                              fontSize: 55*0.40,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0.0*0.30, -35.5*0.30),
                    child: Text(
                      'Charge',
                      style: TextStyle(
                        fontFamily: 'Circular Std Book',
                        fontSize: 40*0.40,
                        color: const Color(0xccffffff),
                        height: 1.725*0.40,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),

            // white box shadow
            Transform.translate(
              offset: Offset(101.0*0.30, 886.0*0.30),
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 277.0 * 0.30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0x9effffff),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x08000000),
                        offset: Offset(0, 30),
                        blurRadius: 40)
                  ],
                ),
              ),
            ),
            //box 4
            Transform.translate(
              offset: Offset(50.0*0.30, 821.0*0.30),
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 307.0*0.30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x14000000),
                        offset: Offset(0*0.30, 30*0.30),
                        blurRadius: 40)
                  ],
                ),
              ),
            ),
            //box 4 text
            Transform.translate(
              offset: Offset(0,-50),
              child: Center(
                child: SizedBox(

                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Circular Std Book',
                        fontSize: 110*0.30,
                        color: const Color(0xffff958f),
                        height: 1.6666666666666667*0.80,
                      ),
                      children: [
                        TextSpan(
                          text: '\250.00\n',
                        ),
                        TextSpan(
                          text: 'Total Balance',
                          style: TextStyle(
                            fontSize: 60*0.30,
                            color: const Color(0xffa6b1c0),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ),

            //text
            Transform.translate(
              offset: Offset(51.0*0.30, 1231.0*0.30),
              child: Text(
                'Last Records Overview',
                style: TextStyle(
                  fontFamily: 'Circular Std Medium',
                  fontSize: 60*0.30,
                  color: const Color(0xff3a4759),
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            //rectangle 1
            //Payments
            Padding(
              padding: EdgeInsets.fromLTRB(18,412,0,0),
              child: MaterialButton(
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 74,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x08000000),
                                offset: Offset(0*0.30, 30*0.30),
                                blurRadius: 40)
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-18, 7),
                      child: Container(
                        width: 218.0*0.30,
                        height: 195.0*0.30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                            begin: Alignment(1.0, -1.0),
                            end: Alignment(-1.0, 1.0),
                            colors: [const Color(0xfff953c6), const Color(0xffb91d73)],
                            stops: [0.0, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x47ff958f),
                                offset: Offset(0*0.30, 20*0.30),
                                blurRadius: 20)
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(65, 6),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Circular Std Medium',
                            fontSize: 60*0.30,
                            color: const Color(0xff3a4759),
                            height: 1.75,
                          ),
                          children: [
                            TextSpan(
                              text: 'Payments\n',
                            ),
                            TextSpan(
                              text: 'View Log',
                              style: TextStyle(
                                fontFamily: 'Circular Std Book',
                                fontSize: 40*0.30,
                                color: const Color(0xffa6b1c0),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(MediaQuery.of(context).size.width - 170, 23),
                      child: SizedBox(
                        width: 100,
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'Circular Std Medium',
                              fontSize: 60*0.30,
                              color: const Color(0xffa6b1c0),
                              height: 1.8421052631578947*0.30,
                            ),
                            children: [
                              TextSpan(
                                text: 'This Month\n\n',
                              ),
                              TextSpan(
                                text: '\250.00 LE',
                                style: TextStyle(
                                  fontFamily: 'Circular Std Book',
                                  fontSize: 38*0.30,
                                  color: const Color(0xfff953c6),
                                  letterSpacing: 0.76,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, 16),
                      child: SvgPicture.asset(
                        "assets/images/deposit.svg",height: 40,width: 40,
                      ),
                    ),
                  ],
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => financeList4() ));
                },
              ),
            ),

//          Transform.translate(
//            offset: Offset(0.0*0.30, 82.0*0.30),
//            child:
//          ),
            

            //Rectangle 2
            //Charges
            Padding(
              padding: EdgeInsets.fromLTRB(18,502,0,0),
              child: MaterialButton(
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 74,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x08000000),
                                offset: Offset(0*0.30, 30*0.30),
                                blurRadius: 40)
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-18, 7),
                      child: Container(
                        width: 218.0*0.30,
                        height: 195.0*0.30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                            begin: Alignment(1.0, -1.0),
                            end: Alignment(-1.0, 1.0),
                            colors: [const Color(0xff4e54c8), const Color(0xff8f94fb)],
                            stops: [0.0, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xffa6b1c0),
                                offset: Offset(0*0.30, 20*0.30),
                                blurRadius: 20)
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(65, 6),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Circular Std Medium',
                            fontSize: 60*0.30,
                            color: const Color(0xff3a4759),
                            height: 1.75,
                          ),
                          children: [
                            TextSpan(
                              text: 'Charges\n',
                            ),
                            TextSpan(
                              text: 'View Log',
                              style: TextStyle(
                                fontFamily: 'Circular Std Book',
                                fontSize: 40*0.30,
                                color: const Color(0xffa6b1c0),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(MediaQuery.of(context).size.width - 170, 23),
                      child: SizedBox(
                        width: 100,
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'Circular Std Medium',
                              fontSize: 60*0.30,
                              color: const Color(0xffa6b1c0),
                              height: 1.8421052631578947*0.30,
                            ),
                            children: [
                              TextSpan(
                                text: 'Last Month\n\n',
                              ),
                              TextSpan(
                                text: '\100.00 LE',
                                style: TextStyle(
                                  fontFamily: 'Circular Std Book',
                                  fontSize: 38*0.30,
                                  color: const Color(0xff4e54c8),
                                  letterSpacing: 0.76,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, 16),
                      child: SvgPicture.asset(
                        "assets/images/deposit.svg",height: 40,width: 40,
                      ),
                    ),
                  ],
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => financeList4() ));
                },
              ),
            ),

            // box 3
            // transfare


            Padding(
              padding: EdgeInsets.fromLTRB(18,592,0,0),
              child: MaterialButton(
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 74,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x08000000),
                                offset: Offset(0*0.30, 30*0.30),
                                blurRadius: 40)
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-18, 7),
                      child: Container(
                        width: 218.0*0.30,
                        height: 195.0*0.30,
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
                                color: const Color(0x473fece4),
                                offset: Offset(0*0.30, 20*0.30),
                                blurRadius: 20)
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(65, 6),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Circular Std Medium',
                            fontSize: 60*0.30,
                            color: const Color(0xff3a4759),
                            height: 1.75,
                          ),
                          children: [
                            TextSpan(
                              text: 'Transfares\n',
                            ),
                            TextSpan(
                              text: 'View Log',
                              style: TextStyle(
                                fontFamily: 'Circular Std Book',
                                fontSize: 40*0.30,
                                color: const Color(0xffa6b1c0),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(MediaQuery.of(context).size.width - 170, 23),
                      child: SizedBox(
                        width: 100,
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'Circular Std Medium',
                              fontSize: 60*0.30,
                              color: const Color(0xffa6b1c0),
                              height: 1.8421052631578947*0.30,
                            ),
                            children: [
                              TextSpan(
                                text: 'Last Orders\n\n',
                              ),
                              TextSpan(
                                text: '\100.00 LE',
                                style: TextStyle(
                                  fontFamily: 'Circular Std Book',
                                  fontSize: 38*0.30,
                                  color: const Color(0xff43cea2),
                                  letterSpacing: 0.76,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, 16),
                      child: SvgPicture.asset(
                        "assets/images/deposit.svg",height: 40,width: 40,
                      ),
                    ),
                  ],
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TransfareBalance() ));
                },
              ),
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
}

