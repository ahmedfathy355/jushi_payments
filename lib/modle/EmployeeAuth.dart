import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:JushiPayments/utility/utils.dart';

class EmployeeAuth {
  final int EmpID;
  final String Name;
  final String Dept;
  final String Position;
  final String Password;

  EmployeeAuth({
    this.EmpID,
    this.Name,
    this.Dept,
    this.Position,
    this.Password,
  });

  factory EmployeeAuth.fromJson(Map<Object, dynamic> json) => EmployeeAuth(
    EmpID: json["EmpID"],
    Name: json["Name"],
    Dept:  json["Dept"],
    Position: json["Position"],
    Password: json["Password"],
  );
}

Future<List<EmployeeAuth>> ValidateLogin(http.Client client , int EmpID , String Password) async {
  final streamedRest =  await client.get(Utils.restURL + "EmployeeAuth?EmpID=$EmpID&Password=$Password");
  Utils.StatusCode = streamedRest.statusCode;
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseEmployeeAcc, "["+streamedRest.body+"]");
}

List<EmployeeAuth> parseEmployeeAcc(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<Object, dynamic>>();
  return parsed.map<EmployeeAuth>((json) => EmployeeAuth.fromJson(json)).toList();
}

