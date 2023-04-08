import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constant.dart';
import '../models/bus.dart';

class BusProvider with ChangeNotifier {
  List<Bus>  _busList = [
    Bus(
        name: "KSRTC",
        description: "Swift Scania P-series",
        seatCount: 28,
        seatLayout: "1*3",
        image: "assets/bus.png"),
    Bus(
        name: "KSRTC",
        description: "Swift Scania P-series",
        seatCount: 32,
        seatLayout: "2*2",
        image: "assets/bus.png"),
    Bus(
        name: "KSRTC",
        description: "Swift Scania P-series",
        seatCount: 28,
        seatLayout: "1*3",
        image: "assets/bus.png"),
    Bus(
        name: "KSRTC",
        description: "Swift Scania P-series",
        seatCount: 36,
        seatLayout: "2*2",
        image: "assets/bus.png"),
  ];

  List<Bus> get busList {
    return [..._busList];
  }

  Future<void> buslist(token, apikey) async {
    print(token);
    print(apikey);
    try {
      final url = '$baseurl/BusListApi/$apikey/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        final busDetails = json.decode(response.body);
        for (var dataJson in busDetails['bus_list']) {
          _busList.add(Bus.fromJson(dataJson));
        }

        notifyListeners();
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
