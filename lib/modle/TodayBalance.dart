import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:JushiPayments/utility/MyCacheManager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:JushiPayments/utility/utils.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class TodayBalance {
  final int empId;
  final String name;
  final double totalBalance;
  final double todayRecharge;
  final double todayPayments;
  final double monthlyPayments;
  final double monthlyRecharge;
  final double monthlyTransfare;


  TodayBalance({
    this.empId,
    this.name,
    this.totalBalance,
    this.todayRecharge,
    this.todayPayments,
    this.monthlyPayments,
    this.monthlyRecharge,
    this.monthlyTransfare
  });

   factory TodayBalance.fromJson(Map<Object, dynamic> json) => TodayBalance(
    empId: json["EmpID"],
    name: json["Name"],
    totalBalance:  json["totalBalance"],
    todayRecharge: json["todayRecharge"],
    todayPayments: json["todayPayments"],
     monthlyPayments: json["monthlyPayments"],
     monthlyRecharge: json["monthlyRecharge"],
     monthlyTransfare: json["monthlyTransfare"]
  );
}

Future<Response> getTotalsByEmpID(int id) async{
}


Future<List<TodayBalance>> fetchTotalsByID(http.Client client , int id ,bool Conniction_Status) async {
  var file = await MyCacheManager().getSingleFile(Utils.restURL + "today?id=$id", headers: {'Authorization': Utils.BasicAuth + 'jPkhIk0ltylIp5xuHpWPf6LsHjfbxhw9huyfCE=6LsHjfbxhw9huyfCE'});
  if (file != null && await file.exists() && !Conniction_Status ) {
    var res = await file.readAsString();
    var jsonResponse  = json.decode(res).cast<Map<Object, dynamic>>();
    Utils.StatusCode = 400;
    return jsonResponse.map<TodayBalance>((json) => TodayBalance.fromJson(json)).toList();
  }
  else{

    try{
      final streamedRest =  await client.get(Utils.restURL + "today?id=$id", headers: {'Authorization': Utils.BasicAuth + 'jPkhIk0ltylIp5xuHpWPf6LsHjfbxhw9huyfCE=6LsHjfbxhw9huyfCE'});
      Utils.StatusCode = streamedRest.statusCode;
      var jsonResponse  = streamedRest.body;
      return compute(parseEmployeeAcc, jsonResponse);
    }
    catch(e)
    {
      var res = await file.readAsString();
      var jsonResponse  = json.decode(res).cast<Map<Object, dynamic>>();
      Utils.StatusCode = 400;
      return jsonResponse.map<TodayBalance>((json) => TodayBalance.fromJson(json)).toList();
    }
  }
}

List<TodayBalance> parseEmployeeAcc(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<Object, dynamic>>();

  return parsed.map<TodayBalance>((json) => TodayBalance.fromJson(json)).toList();
}


const key = "customCache";
