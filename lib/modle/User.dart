
import 'dart:async';
import 'dart:convert';

import 'package:JushiPayments/utility/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User{
  final int UserID;
  final int EmployeeID;
  final int UserGroupID ;
  final String UserName;
  final String PasswordStored ;
  final String Password ;
  final bool Active;
  final int AreaID;

  User({this.UserID , this.EmployeeID , this.UserGroupID,this.UserName,this.PasswordStored,this.Password, this.Active, this.AreaID});
  //Items( this.ItemName );

  factory User.fromJson(Map<Object, dynamic> json) {
    return User(
      UserID: json['UserID'] as int,
      EmployeeID: json['EmployeeID'] as int,
      UserGroupID: json['UserGroupID'] as int,
      UserName: json['UserName'] as String,
      PasswordStored: json['PasswordStored'] as String,
      Password: json['Password'] as String,
      Active: json['Active'] as bool,
      AreaID: json['AreaID'] as int,
    );
  }

}

Future<List<User>> fetchUserByID(http.Client client,int id) async {

  final response =  await client.get(Utils.restURL + "user?id=$id");

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseusr, "["+response.body+"]");
}

Future<List<User>> fetchUserAllUsers(http.Client client) async {

  final response =  await client.get(Utils.restURL + "user");

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseusr, response.body);
}

// A function that converts a response body into a List<Photo>.
List<User> parseusr(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<Object, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}