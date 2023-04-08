import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/constant.dart';

import '../models/driver.dart';

class DriverProvider with ChangeNotifier {
  List<Driver> _driverList = [];

  List<Driver> get driverList {
    return [..._driverList];
  }

  Map<String, dynamic> _driverAdd = {};

  Map<String, dynamic> get driverAdd {
    return {..._driverAdd};
  }

  Map<String, dynamic> _deleteDriver = {};

  Map<String, dynamic> get deleteDriver {
    return {..._deleteDriver};
  }

  Future<void> driverlist(token, apikey) async {
    try {
      final url = '$baseurl/DriverApi/$apikey/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        final driverDetails = json.decode(response.body);
        List<Driver> driver = [];
        for (var dataJson in driverDetails['driver_list']) {
          driver.add(Driver.fromJson(dataJson));
        }
        _driverList = driver;

        notifyListeners();
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> addDriver(token, apikey, driverData) async {
    print(driverData);
    try {
      final url = '$baseurl/DriverApi/$apikey/';
      var response = await http.post(
        Uri.parse(url),
        body: driverData,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        final driverAdd = json.decode(response.body);
        _driverAdd = driverAdd as Map<String, dynamic>;
        notifyListeners();
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<void> delDriver(token, apikey, driverid) async {
    try {
      final url = '$baseurl/DriverApi/$apikey/';
      var response = await http.delete(
        Uri.parse(url),
        body: {
          "driver_id": driverid,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        final driverDelete = json.decode(response.body);
        _deleteDriver = driverDelete as Map<String, dynamic>;
        notifyListeners();
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
