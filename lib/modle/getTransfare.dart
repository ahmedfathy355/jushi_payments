import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:JushiPayments/utility/utils.dart';

class getTransfare {
  final int OrderTypeID;
  final String OrderType;
  final int EmpID;
  final double Amount;
  final DateTime CreatedDate;
  final String Time;
  final String UserName;

  getTransfare({
    this.OrderTypeID,
    this.OrderType,
    this.EmpID,
    this.Amount,
    this.CreatedDate,
    this.Time,
    this.UserName,
  });

  factory getTransfare.fromJson(Map<Object, dynamic> json) => getTransfare(
    OrderTypeID: json["OrderTypeID"],
    OrderType: json["OrderType"],
    EmpID: json["EmpID"],
    Amount: json["Amount"],
    CreatedDate: json["CreatedDate"],
    Time: json["Time"],
    UserName: json["UserName"],
  );
}

Future<List<getTransfare>> EmployeeTransfare(http.Client client , String _dateFrom, String _dateTo , int  EmpID)async {

  final response =  await client.get(Utils.restURL + "getTransfare?_dateFrom=$_dateFrom&_dateTo=$_dateTo&EmpID=$EmpID", headers: {'Authorization': Utils.BasicAuth + 'jPkhIk0ltylIp5xuHpWPf6LsHjfbxhw9huyfCE=6LsHjfbxhw9huyfCE'});

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseEmployeeAcc, response.body);
}

List<getTransfare> parseEmployeeAcc(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<Object, dynamic>>();
  return parsed.map<getTransfare>((json) => getTransfare.fromJson(json)).toList();
}

