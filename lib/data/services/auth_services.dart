import 'dart:convert';

import 'package:cinestream/data/api/api_client.dart';
import 'package:cinestream/data/api/auth_client.dart';
import 'package:cinestream/data/models/user_model.dart';
import 'package:cinestream/screens/HomeScreen.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServises {
  final AuthClient _authClient = AuthClient();

  Future<UserModel?> login(
    String username,
    String Password,
    BuildContext context,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      dio.Response loginresponse = await _authClient.postData(
        '/auth/login',
        body: {"username": username, "password": Password},
      );

      if (loginresponse.statusCode == 200 && loginresponse.data != null) {
        UserModel userdata = UserModel.fromJson(loginresponse.data);
        prefs.setBool("isLogin", true);
        prefs.setString("userData", jsonEncode(userdata.toJson()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

        return userdata;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
    return null;
  }
}
