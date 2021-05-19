import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:JushiPayments/utility/utils.dart';

class getPayments {
  final int OrderTypeID;
  final String OrderType;
  final String Area;
  final int EmpID;
  final double Amount;
  final String CreatedDate;
  final String Time;
  final String UserName;

  getPayments({
    this.OrderTypeID,
    this.OrderType,
    this.Area,
    this.EmpID,
    this.Amount,
    this.CreatedDate,
    this.Time,
    this.UserName,
  });

  factory getPayments.fromJson(Map<Object, dynamic> json) => getPayments(
    OrderTypeID: json["OrderTypeID"],
    OrderType: json["OrderType"],
    Area:  json["Area"],
    EmpID: json["EmpID"],
    Amount: json["Amount"],
    CreatedDate:  json['CreatedDate'] ,
    Time: json["Time"],
    UserName: json["UserName"],
  );
}

Future<List<getPayments>> EmployeePayments(http.Client client , String _dateFrom, String _dateTo , int  EmpID) async {

  final response =  await client.get(Utils.restURL + "getPayments?_dateFrom=$_dateFrom&_dateTo=$_dateTo&EmpID=$EmpID", headers: {'Authorization': Utils.BasicAuth + 'jPkhIk0ltylIp5xuHpWPf6LsHjfbxhw9huyfCE=6LsHjfbxhw9huyfCE'});

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseEmployeeAcc, response.body);

}

List<getPayments> parseEmployeeAcc(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<Object, dynamic>>();

  return parsed.map<getPayments>((json) => getPayments.fromJson(json)).toList();
}

