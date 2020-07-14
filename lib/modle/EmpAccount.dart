import 'package:JushiPayments/utility/utils.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

class EmpAccount{
  final int Serial;
  final String OederCode;
  final int OrderTypeID;
  final int EmpID;
  final double Amount;
  final int AreaID;
  final DateTime CreatedDate;
  final String Time;
  final int UserCreatID;

  EmpAccount(
      {this.Serial, this.OederCode, this.OrderTypeID, this.EmpID, this.Amount, this.AreaID
        , this.CreatedDate
        , this.Time
        , this.UserCreatID
      });

  factory EmpAccount.fromJson(Map<Object , dynamic> json){
    return EmpAccount(
        Serial : json['Serial'] as int,
      OederCode : json['OederCode']  as String,
      OrderTypeID : json['OrderTypeID'] as int,
      EmpID : json['EmpID'] as int,
      Amount : json['Amount'] as double,
      AreaID : json['AreaID'] as int,
      CreatedDate : DateTime.parse ( json['CreatedDate'] ),
      Time : json['Time'] as String,
      UserCreatID : json['UserCreatID'] as int
    );
  }
}

Future<List<EmpAccount>> fetchEmployeeAccByID(http.Client client , String id) async {
  final response =  await client.get(Utils.restURL + "EmpAccount?id=$id");
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseEmployeeAcc, "["+response.body+"]");
}


Future<List<EmpAccount>> fetchTotalBalanceByID(http.Client client , String id) async {

  final response =  await client.get(Utils.restURL + "EmpAccount/$id");

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseEmployeeAcc, response.body);
}

Future<List<EmpAccount>> fetchAllEmployeeAcc(http.Client client) async {

  final response =  await client.get(Utils.restURL + "EmpAccount");

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseEmployeeAcc, response.body);
}

List<EmpAccount> parseEmployeeAcc(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<Object, dynamic>>();

  return parsed.map<EmpAccount>((json) => EmpAccount.fromJson(json)).toList();
}

