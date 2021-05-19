import 'dart:async';

import 'package:JushiPayments/finance/WalletHome.dart';
import 'package:JushiPayments/modle/EmployeeAuth.dart';
import 'package:JushiPayments/utility/Localizations/localization_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'utility/utils.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

//enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  //LoginStatus _loginStatus = LoginStatus.notSignIn;
  bool IsLoadind = false;
  bool ShowIndicator = false;
  var txt_Emp_ID  ;
  var txt_Emp_Password  ;
  bool _rememberMeFlag = true;
  List<EmployeeAuth> _list = [];
  final _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;
  bool _secureText = true;
  static Pattern Password_pattern =  r'(^(?:[+0]9)?[0-9]{1,12}$)';
  //static Pattern Password_pattern =  r'^(?=.*?[0-9]).{8,}$';
  static Pattern Code_pattern =  r'(^(?:[+0]9)?[0-9]{1,12}$)';
  RegExp regex_pass = new RegExp(Password_pattern);
  RegExp regex_code = new RegExp(Code_pattern);
  final Controller_EmpCode = TextEditingController();
  final Controller_EmpPass = TextEditingController();

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _login();

    }
  }

  _login() async{
    try{
      _list =  await ValidateLogin(http.Client() , int.parse(txt_Emp_ID) , txt_Emp_Password );
      if( _list[0].EmpID != null && _list.length > 0) {

        if (_rememberMeFlag) {
          savePref(int.parse(txt_Emp_ID), txt_Emp_Password, _list[0].Name, true,_list[0].mob);
          IsLoadind = true;
          loginToast("Login Success");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WalletHome(EmpName: _list[0].Name)));
        }
        else if(_rememberMeFlag == false)
        {
          IsLoadind = true;
          loginToast("Login Success");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WalletHome(EmpName: _list[0].Name)));
        }
        txt_Emp_ID == txt_Emp_Password ? Utils.NeedChangePassword = true :Utils.NeedChangePassword = false;
      }
      else if (_list[0].EmpID == null ){
        IsLoadind = false;
        setState(() {
          ShowIndicator = false;
        });
        loginToast("Incorrect Code / Password");
      }
      else if (_list.length == 0 ){
        IsLoadind = false;
        setState(() {
          ShowIndicator = false;
        });
        loginToast("Check Code Or Password");
      }
    }
    catch(e)
    {
      loginToast("Server Offline" + e);
      setState(() {
        ShowIndicator = false;
      });
      loginToast("Error " + e);
    }
  }
//      showDialog(
//        context: context,
//        barrierDismissible: false,
//        builder: (BuildContext context) {
//          return Dialog(
//            child: new CircularPercentIndicator(
//              radius: 60.0,
//              lineWidth: 5.0,
//              percent: 1.0,
//              animation: true,
//              animationDuration: 5000,
//              center: new Text("100%"),
//              backgroundColor: Colors.redAccent,
//              progressColor: Colors.blue,
//            ),
//          );
//        }
//      );
  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  savePref(int txt_Emp_ID, String txt_Emp_Password, String Name, bool Login,String mob) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("txt_Emp_ID", txt_Emp_ID);
      prefs.setString("txt_Emp_Password", txt_Emp_Password);
      prefs.setString("Name", Name);
      prefs.setBool("Login", Login);
      prefs.setString("mob", mob ?? "");
      prefs.commit();
    });
  }

  Future<bool> checkIsLogin() async {
    try
    {
      prefs= await SharedPreferences.getInstance().then((result)
      {
        if(result != null){
          txt_Emp_ID = (prefs.getString('txt_Emp_ID') ?? "");
          txt_Emp_Password = (prefs.getString('txt_Emp_Password') ?? "");
          _rememberMeFlag = (prefs.getBool("Login") ?? false);
          IsLoadind = _rememberMeFlag ? true : false;
        }
        else{
          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => WalletHome(EmpName:prefs.getString("Name"))    ));
        }
      });
    }
    catch(e)
    {
      print(e);
    }

//    if (LoginStatus.signIn == true) {
////      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => WalletHome(EmpName:prefs.getString("Name"))    ));
////
////    }
  }

  @override
  void initState() {
    //checkIsLogin();
    Controller_EmpCode.addListener(txt_Emp_ID);
    Controller_EmpPass.addListener(txt_Emp_Password);
    super.initState();
  }


  void dispose() {
    Controller_EmpCode.dispose();
    Controller_EmpPass.dispose();
    super.dispose();
  }


  //
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisSize: MainAxisSize.max,

              children: <Widget>[
//          //logo
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 110.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/icon/logo.png'),
                  ),
                ),
                //Login Now
                Container(
                  padding: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Login Now',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 26,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'to continue your wallet',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: const Color(0xff8b959a),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Employee Code
                      Container(
                        width: MediaQuery.of(context).size.width - 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xffffffff),
                          border: Border.all(width: 1.0, color: const Color(0xffe2e6ea)),
                        ),
                        child:  TextFormField(
                          controller: Controller_EmpCode,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                            color: const Color(0xff373B44),
                          ),
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.person , color: const Color(0xff2e77ae),) ,
                            hintText: getTranslated(context, "Employee_Code") ,
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return getTranslated(context, "Employee_Code_is_required") ;
                            }
                            else{
                              txt_Emp_ID = value ;
                              if (!regex_code.hasMatch(value))
                                return getTranslated(context, "Enter_valid_Employee_Code") ;
                              else
                                return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 5,),
                      // Password
                      Container(
                        width: MediaQuery.of(context).size.width - 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xffffffff),
                            border: Border.all(width: 0.1,color: const Color(0xff0d2137))
                        ),
                        child: TextFormField(
                          controller: Controller_EmpPass,
                          keyboardType: TextInputType.number,
                          obscureText: _secureText,
                          style:TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                            color: const Color(0xff0d2137),
                          ),
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: Icon(_secureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            prefixIcon: Icon(Icons.lock , color: const Color(0xff2e77ae),) ,
                            hintText: getTranslated(context, "Password") ,
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                          onFieldSubmitted:(_) => FocusScope.of(context).unfocus(),
                          validator: (value){
                            if(value.isEmpty)
                            {return getTranslated(context, "Employee_Password_is_required") ;}
                            else{
                              txt_Emp_Password = value ;
                              if (!regex_pass.hasMatch(value))
                                return  getTranslated(context, "Enter_valid_password") ;
                              else
                                return null;
                            }
                          },


                        ),
                      ),
                      //remmember
                      Container(
                        margin: new EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.grey,
                              value: _rememberMeFlag,
                              onChanged: (value) => setState(() {
                                _rememberMeFlag = !_rememberMeFlag;
                              }),
                            ),
                            new Text(
                              getTranslated(context, "Remember_me"),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                color: const Color(0xff696969),
                              ),
                            )
                          ],
                        ),
                      ),
                      //button
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        height: 50,
                        child: new  RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
                          ),
                          color:  const Color(0xff3c82ff),
                          highlightColor: Colors.blueGrey,
                          elevation: 5,
                          onPressed: (){
                            setState(() {
                              ShowIndicator = true;
                            });
                            check();
                          },
                          child:
//                          Utils.StatusCode != 200 ? Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: [
//                              Center(
//                                child: Text(Utils.StatusCode.toString() + "Server Offline ",
//                                  style: TextStyle(
//                                    fontFamily: 'Roboto',
//                                    fontSize: 24,
//                                    color: Colors.amberAccent,
//                                  ),
//                                  textAlign: TextAlign.left,),
//                              )
//                            ],
//                          ) :
                          ShowIndicator ? CircularProgressIndicator() : Text(
                            getTranslated(context, 'Login'),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 24,
                              color: const Color(0xffffffff),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      //Forgot password


                    ],
                  ),
                ),

                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _showMyDialog();
                      },
                      child: Container(
                        margin: new EdgeInsets.only(right: 5.0,left: 5),
                        child: new Text(
                          getTranslated(context, 'Forgot_password'),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            color: const Color(0xff696969),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ubuntu-eg.com'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('to reset password contact your administrator'),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  }



