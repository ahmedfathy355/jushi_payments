import 'dart:async';
import 'dart:io';
import 'package:JushiPayments/modle/EmpAccount.dart';
import 'package:JushiPayments/modle/EmpRegistration.dart';
import 'package:JushiPayments/modle/TodayBalance.dart';
import 'package:JushiPayments/utility/Localizations/localization_constants.dart';
import 'package:JushiPayments/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class TransfareBalance extends StatefulWidget {

  final String connectionStatus;
  TransfareBalance({this.connectionStatus});

  @override
  _TransfareBalanceState createState() => _TransfareBalanceState();
}

class _TransfareBalanceState extends State<TransfareBalance> {
  SharedPreferences prefs;
  var txt_To_EmpID;
  var txt_transfaredAmount;
  var txt_Emp_Password;
  var txt_TotalBalance;
  final c_To_EmpID = new TextEditingController();
  final c_Emp_Password = new TextEditingController();
  final c_transfaredAmount = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isExistCode = false;

  static Pattern Password_pattern =  r'(^(?:[+0]9)?[0-9]{3,12}$)';
  //static Pattern Password_pattern =  r'^(?=.*?[0-9]).{8,}$';
  static Pattern Code_pattern =  r'(^(?:[+0]9)?[0-9]{4,5}$)';
  RegExp regex_pass = new RegExp(Password_pattern);
  RegExp regex_code = new RegExp(Code_pattern);
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  void initState() {
    //checkIsLogin();
    c_To_EmpID.addListener(txt_To_EmpID);
    c_Emp_Password.addListener(txt_Emp_Password);
    c_transfaredAmount.addListener(txt_transfaredAmount);
    super.initState();
  }


  void dispose() {
    c_To_EmpID.dispose();
    c_Emp_Password.dispose();
    c_transfaredAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),
      body:FutureBuilder(future: _total(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          {
            return _body();
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },),
    );
  }


Widget _body(){
    return  SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: 50,),

            //box 1
            Container(
              width: 200,
              height: 90,
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
              child: Center(
                child: SizedBox(

                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Circular Std Book',
                        fontSize: 30,
                        color: const Color(0xff4286f4),
                        height: 1.1,
                      ),
                      children: [
                        TextSpan(
                          text: txt_TotalBalance.toString()+'\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,)
                        ),
                        TextSpan(
                          text: getTranslated(context, 'Total_Balance'),
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
              ),
            ),

            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Align(
                child: Text(
                  getTranslated(context, 'Enter_Employee_Code_To_Send_Mony'),
                  style: TextStyle(
                    fontFamily: 'Circular Std Book',
                    fontSize: 18,
                    color: const Color(0xff000000),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),


            SizedBox(height: 20,),

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
                      controller: c_To_EmpID,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: const Color(0xff373B44),
                      ),
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person , color: const Color(0xffFF958F),) ,
                        hintText: getTranslated(context, 'Transfer_To_Code'),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        errorText: txt_To_EmpID,
                      ),
                      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return getTranslated(context, 'Employee_Code_is_required');
                        }
                        else{
                          txt_To_EmpID = value ;
                          if (!regex_code.hasMatch(value))
                            return getTranslated(context, 'Enter_valid_Employee_Code');
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
                      controller: c_Emp_Password,
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
                        prefixIcon: Icon(Icons.lock , color: const Color(0xffFF958F),) ,
                        hintText: getTranslated(context, 'Password'),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      onFieldSubmitted:(_) => FocusScope.of(context).unfocus(),
                      validator: (value){
                        if(value.isEmpty)
                        {return getTranslated(context, 'Employee_Password_is_required') ;}
                        else{
                          txt_Emp_Password = value ;
                          if (!regex_pass.hasMatch(value))
                            return getTranslated(context, 'Enter_valid_password');
                          else
                            return null;
                        }
                      },


                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        getTranslated(context, 'Amount'),
                        style: TextStyle(
                          fontFamily: 'Circular Std Book',
                          fontSize: 26,
                          color: const Color(0xff000000),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffffffff),
                        border: Border.all(width: 0.1,color: const Color(0xff0d2137))
                    ),
                    child: TextFormField(
                      controller: c_transfaredAmount,
                      keyboardType: TextInputType.number,
                      style:TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: const Color(0xff0d2137),
                      ),
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.attach_money , color: const Color(0xffFF958F),) ,
                        hintText: getTranslated(context, 'Amount'),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      onFieldSubmitted:(_) => FocusScope.of(context).nextFocus(),
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return getTranslated(context, 'Amount');
                        } else{
                          txt_transfaredAmount = value;
                        }
                      },
                    ),
                  ),

                  MaterialButton(
                    child: Container(
                      height: 62,
                        margin: EdgeInsets.only(bottom: 20,top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                            color: const Color(0xff3A4759),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Wrap(
                          children: <Widget>[
                            Transform.rotate(
                              angle: 70,
                              child: Icon(
                                Icons.swap_calls,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                                getTranslated(context, 'Transfares'),
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    color: const Color(0xffF2F4F7))
                            ),
                          ],
                        )
                    ),
                    onPressed: (){
                      check() ;
                    },
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    ) ;
}

  List<EmpAccount> _AllaccountList = [];
  List<TodayBalance> _list = [];

//  Future<List<EmpAccount>> _getPayments() async{
//    try{
//      prefs = await SharedPreferences.getInstance();
//      _AllaccountList = await fetchAllEmployeeAcc(http.Client());
//    }
//    catch(e)
//    {
//      print(e);
//    }
//    return _AllaccountList;
//  }

  String _connectionStatus = 'Unknown';

  Future<List<TodayBalance>> _total() async{
    try{
      prefs = await SharedPreferences.getInstance();
      _list = await fetchTotalsByID(http.Client() , prefs.getInt("txt_Emp_ID"), widget.connectionStatus == "ConnectivityResult.none" ? false : true);
      setState(() {
        txt_TotalBalance = _list[0].totalBalance.toString();
      });
    }
    catch(e)
    {
      print(e);
    }
    return _list;

  }

//  Future _insertTransfare_sql(String table_id , String ItemID , double Qty) async {
//    var sql = "insert Into bill_items_test (tableID,ItemID, Qty) Values ('$table_id' , '$ItemID' , $Qty) ";
//    await http.post(Utils.RestURL + "tables", body: {'TableName': 'Table 17', 'IsBooked': 'false'});
//
//    print('inserted');
//    selecteditems.clear();
//  }

  Future _insertTransfare_SP(int EmpID  , int _To_EmpID ,double  Amount ) async {
    var _Amount  = Amount * -1;
//    var sql1 = "exec CrudTransfare  @OrderTypeID=2,@EmpID=$EmpID,@Amount=$Amount,@UserCreatID=$EmpID,@StatementType='Insert'  ";

    await http.post(Utils.restURL + "EmpAccount", body: {"OrderTypeID": "2", "EmpID": "$EmpID" ,"Amount":"$_Amount","UserCreatID":"$EmpID","StatementType":"Insert"    });
    await http.post(Utils.restURL + "EmpAccount", body: {"OrderTypeID": "2", "EmpID": "$_To_EmpID" ,"Amount":"$Amount","UserCreatID":"$EmpID","StatementType":"Insert"    });
    
  }

  Future<List<EmpRegistration>> validateCode( int _To_EmpID  ) async {
    try{
      prefs = await SharedPreferences.getInstance();
      var _isExist = await fetchEmployeeByID(http.Client() , _To_EmpID );
      if( _isExist[0].EmpID != null && _isExist.length > 0) {
        setState(() {
          _isExistCode = true;
        });
      }
      else if (_isExist[0].EmpID == null ){
        setState(() {
          _isExistCode = false;
          txt_To_EmpID = getTranslated(context, 'Error_Check_Server');
        });
      }
      else if (_isExist.length == 0 ){
        setState(() {
          _isExistCode = false;
          txt_To_EmpID = getTranslated(context, 'Error_Check_Server');
        });
      }
    }
    catch(e)
    {
      print(e);
    }

  }



  Future _updateTable(int table_id ) async {
    var get_response = await http.put(Utils.restURL + "tables/$table_id", body: { 'IsBooked': 'true'});
    print (get_response.statusCode.toString());
  }

  Future _updateItems(int table_id , int ItemID , double Qty) async {
    var get_response = await http.post(Utils.restURL + "tables_items", body: { 'TableID': table_id , 'ItemID': ItemID , 'Qty': Qty });
    print (get_response.statusCode.toString());
  }

  check() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      validateCode(int.parse(txt_To_EmpID));
      if(_isExistCode){
        _insertTransfare_SP(prefs.getInt("txt_Emp_ID") , int.parse( txt_To_EmpID) ,double.parse( txt_transfaredAmount) );
        //_total();
//        setState(() {
//          txt_To_EmpID = "";
//          txt_transfaredAmount = "";
//          txt_Emp_Password = "";
//        });
        Navigator.pop(context);
      }
      else{
        setState(() {
          txt_To_EmpID = "Check Employee Code";
        });
      }

    }
  }
}

