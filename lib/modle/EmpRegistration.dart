import 'package:JushiPayments/utility/utils.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class EmpRegistration{
  final int Serial;
  final int EmpID;
  final String Name;
  final int DeptID;
  final int Position;
  final bool HaveApssword;
  final String PasswordStored ;
  final String Password ;
  final bool Active;
  final String mob ;

  EmpRegistration({this.Serial , this.EmpID , this.Name,this.DeptID,this.Position,this.HaveApssword
      , this.PasswordStored
      , this.Password
      , this.Active
      , this.mob
      });

  factory EmpRegistration.fromJson(Map<Object, dynamic> json) {
    return EmpRegistration(
        Serial :json['Serial'] as int,
        EmpID : json['EmpID'] as int,
        Name : json['Name'] as String,
        DeptID : json["DeptID"] as int,
        Position : json["Position"] as int,
        HaveApssword : json["HaveApssword"]as bool,
        PasswordStored : json["PasswordStored"]as String,
        Password : json["Password"]as String,
        mob : json["mob"]as String,
        Active : json["Active"]as bool
    );
  }
}


Future<List<EmpRegistration>> fetchEmployeeByID(http.Client client , int id) async {

  final response =  await client.get(Utils.restURL + "EmpRegistration?id=$id", headers: {'Authorization': Utils.BasicAuth + 'jPkhIk0ltylIp5xuHpWPf6LsHjfbxhw9huyfCE=6LsHjfbxhw9huyfCE'});

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseEmployee, "["+response.body+"]");

}

Future<List<EmpRegistration>> fetchAllEmployee(http.Client client) async {

  final response =  await client.get(Utils.restURL + "EmpRegistration", headers: {'Authorization': Utils.BasicAuth + 'jPkhIk0ltylIp5xuHpWPf6LsHjfbxhw9huyfCE=6LsHjfbxhw9huyfCE'});

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseEmployee, response.body);
}

// A function that converts a response body into a List<Photo>.
List<EmpRegistration> parseEmployee(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<Object, dynamic>>();

  return parsed.map<EmpRegistration>((json) => EmpRegistration.fromJson(json)).toList();
}