import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/authUtility.dart';
import 'package:task_manager/data/models/networkResponse.dart';
import 'package:task_manager/screens/onboard/loginScreen.dart';

class NetworkCaller {
  Future<networkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),
          headers: {'token': authUtility.userInfo.token.toString()});
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return networkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        gotoLogin();
      } else {
        return networkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return networkResponse(false, -1, null);
  }

  Future<networkResponse> postRequest(
      String url, Map<String, dynamic> body,{bool islogin = false}) async {
    try {
      Response response = await post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'token': authUtility.userInfo.token.toString()
          },
          body: jsonEncode(body));
      // log(response.statusCode.toString());
      // log(response.body);
      if (response.statusCode == 200) {
        return networkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        if (islogin) {
          gotoLogin();
        }
      } else {
        return networkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return networkResponse(false, -1, null);
  }

  Future<void> gotoLogin() async {
    await authUtility.clearUserInfo();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.globalKey.currentContext!,
        MaterialPageRoute(builder: (context) => const loginScreen()),
        (route) => false);
  }
}
