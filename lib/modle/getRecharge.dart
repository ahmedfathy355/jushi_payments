import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:JushiPayments/utility/utils.dart';

class getRecharge {
  final int OrderTypeID;
  final String OrderType;
  final int EmpID;
  final double Amount;
  final String CreatedDate;
  final String Time;
  final String UserName;

  getRecharge({
    this.OrderTypeID,
    this.OrderType,
    this.EmpID,
    this.Amount,
    this.CreatedDate,
    this.Time,
    this.UserName,
  });

  factory getRecharge.fromJson(Map<Object, dynamic> json) => getRecharge(
    OrderTypeID: json["OrderTypeID"],
    OrderType: json["OrderType"],
    EmpID: json["EmpID"],
    Amount: json["Amount"],
    CreatedDate: json["CreatedDate"],
    Time: json["Time"],
    UserName: json["UserName"],
  );
}

Future<List<getRecharge>> EmployeeRecharge(http.Client client ,  String _dateFrom, String _dateTo , int  EmpID) async {

  final response =  await client.get(Utils.restURL + "getRecharge?_dateFrom=$_dateFrom&_dateTo=$_dateTo&EmpID=$EmpID");

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseEmployeeAcc, response.body);

}

List<getRecharge> parseEmployeeAcc(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<Object, dynamic>>();

  return parsed.map<getRecharge>((json) => getRecharge.fromJson(json)).toList();
}

