
import 'package:JushiPayments/login.dart';
import 'package:JushiPayments/utility/Localizations/localization_constants.dart';
import 'package:JushiPayments/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class change_password extends StatefulWidget {
  @override
  _change_password createState() => _change_password();
}


class _change_password extends State<change_password> {
  SharedPreferences prefs;

  var txt_Old_Password;
  var txt_New_Password;
  var txt_Confirm_Password;

  final c_Old_Password = new TextEditingController();
  final c_New_Password = new TextEditingController();
  final c_Confirm_Password = new TextEditingController();
  final _formKey = GlobalKey<FormState>();



  static Pattern Password_pattern =  r'(^(?:[+0]9)?[0-9]{3,12}$)';
  //static Pattern Password_pattern =  r'^(?=.*?[0-9]).{8,}$';
  static Pattern Code_pattern =  r'(^(?:[+0]9)?[0-9]{4,5}$)';
  RegExp regex_pass = new RegExp(Password_pattern);
  RegExp regex_code = new RegExp(Code_pattern);
  bool _secureText = true;
  bool _isSamePass = false;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }
  @override
  void initState() {
    //checkIsLogin();
    c_Old_Password.addListener(txt_Old_Password);
    c_New_Password.addListener(txt_New_Password);
    c_Confirm_Password.addListener(txt_Confirm_Password);
    super.initState();
  }


  void dispose() {
    c_Old_Password.dispose();
    c_New_Password.dispose();
    c_Confirm_Password.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),
      body:_body()
    );
  }


  Widget _body(){
    return  SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: 50,),

            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: 5,),
                  // Password
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffffffff),
                        border: Border.all(width: 0.1,color: const Color(0xff0d2137))
                    ),
                    child: TextFormField(
                      controller: c_Old_Password,
                      keyboardType: TextInputType.number,
                      obscureText: _secureText,
                      style:TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: const Color(0xff0d2137),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: Icon(_secureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        prefixIcon: Icon(Icons.lock , color: const Color(0xffFF958F),) ,
                        hintText: getTranslated(context, 'Current_Password'),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      onFieldSubmitted:(_) => FocusScope.of(context).unfocus(),
                      validator: (value){
                        if(value.isEmpty)
                        {return getTranslated(context, 'Employee_Password_is_required');}
                        else{
                          txt_Old_Password = value ;
                          if (!regex_pass.hasMatch(value))
                            return getTranslated(context, 'Enter_valid_password');
                          else
                            return null;
                        }
                      },


                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffffffff),
                        border: Border.all(width: 0.1,color: const Color(0xff0d2137))
                    ),
                    child: TextFormField(
                      controller: c_New_Password,
                      keyboardType: TextInputType.number,
                      obscureText: _secureText,
                      style:TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: const Color(0xff0d2137),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: Icon(_secureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        prefixIcon: Icon(Icons.lock , color: const Color(0xffFF958F),) ,
                        hintText: getTranslated(context, 'New_password'),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      onFieldSubmitted:(_) => FocusScope.of(context).unfocus(),
                      validator: (value){
                        if(value.isEmpty)
                        {return getTranslated(context, 'Employee_Password_is_required');}
                        else{
                          txt_New_Password = value ;
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
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffffffff),
                        border: Border.all(width: 0.1,color: const Color(0xff0d2137))
                    ),
                    child: TextFormField(
                      controller: c_Confirm_Password,
                      keyboardType: TextInputType.number,
                      obscureText: _secureText,
                      style:TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: const Color(0xff0d2137),
                      ),

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: Icon(_secureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        prefixIcon: Icon(Icons.arrow_forward_ios , color: const Color(0xffFF958F),) ,
                        hintText: getTranslated(context, 'Confirm_Password'),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        errorText: txt_Confirm_Password,
                      ),
                      onFieldSubmitted:(_) => FocusScope.of(context).unfocus(),
                      validator: (value){
                        if(value.isEmpty)
                        {return getTranslated(context, 'Employee_Password_is_required');}
                        else{
                          txt_Confirm_Password = value ;
                          if (!regex_pass.hasMatch(value))
                            return getTranslated(context, 'Type_Password_Again');
                          else
                            return null;
                        }
                      },


                    ),
                  ),
                  SizedBox(height: 15,),
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

                            SizedBox(width: 10),
                            Text(
                                getTranslated(context, 'Save'),
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


  bool _isUpdated = false;

  Future _updatePassword(  String Pass ) async {
    prefs = await SharedPreferences.getInstance();
    int EmpID = prefs.getInt("txt_Emp_ID")  ;
    var get_response = await http.put(Utils.restURL + "EmpRegistration/$EmpID", body: { "PasswordStored": '$Pass'});
    if (get_response.statusCode == 201){
      _isUpdated = true ;
    }
    else
      {
        _isUpdated = false;
      }
  }

  signOut() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("txt_Emp_ID", null);
      prefs.setString("txt_Emp_Password", null);
      prefs.setString("Name", null);
      prefs.setBool("Login", false);
    });
  }

  check() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if(txt_Confirm_Password == txt_New_Password){
        _updatePassword( txt_Confirm_Password );
        if( _isUpdated)
          {
            signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login() ));
          }
        else
          {
            setState(() {
              txt_Confirm_Password = getTranslated(context, 'Error_Check_Server');
            });
          }

      }
      else{
        setState(() {
          txt_Confirm_Password = getTranslated(context, 'Password_does_not_match');
        });
      }

    }
  }
}


