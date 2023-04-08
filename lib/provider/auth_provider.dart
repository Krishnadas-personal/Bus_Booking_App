import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constant.dart';

class AuthProvider with ChangeNotifier {
  Map<String, dynamic> _authList = {};

  Map<String, dynamic> get authList {
    return {..._authList};
  }

  String? token;

  String? userid;

  bool get isAuth {
    return token != null;
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userAuth')) {
      return false;
    }
    final extractedData = json.decode(prefs.getString('userAuth')!);
    token = extractedData['access'] as String?;
    userid = extractedData['url_id'] as String?;

    notifyListeners();
    return true;
  }

  Future<void> authendicate(keyValues) async {
    try {
      final url = '$baseurl/LoginApi';
      var response = await http.post(
        Uri.parse(url),
        body: json.encode(keyValues),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final authDetails = json.decode(response.body);
      _authList = authDetails as Map<String, dynamic>;
      print(_authList.toString());
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final authData = json.encode({
        "refresh": _authList['refresh'],
        "access": _authList["access"],
        "url_id": _authList["url_id"]
      });
      prefs.setString("userAuth", authData);
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
