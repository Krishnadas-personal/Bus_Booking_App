import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/constant.dart';
import '../models/bus.dart';


class BusProvider with ChangeNotifier {

  final List<Bus> _busList = [
    Bus(
        name: "KSRTC",
        description: "Swift Scania P-series",
        seatCount: 28,
        seatLayout: SeatLayout.oneByThree,
        image: "assets/bus.png"),
    Bus(
        name: "KSRTC",
        description: "Swift Scania P-series",
        seatCount: 32,
        seatLayout: SeatLayout.twoByTwo,
        image: "assets/bus.png"),
    Bus(
        name: "KSRTC",
        description: "Swift Scania P-series",
        seatCount: 28,
        seatLayout: SeatLayout.oneByThree,
        image: "assets/bus.png"),
    Bus(
        name: "KSRTC",
        description: "Swift Scania P-series",
        seatCount: 36,
        seatLayout: SeatLayout.twoByTwo,
        image: "assets/bus.png"),
    Bus(
        name: "KSRTC",
        description: "Swift Scania P-series",
        seatCount: 40,
        seatLayout: SeatLayout.twoByTwo,
        image: "assets/bus.png"),
  ];

  List<Bus> get busList {
    return [..._busList];
  }

  Future<void> buslist(token, apikey) async {
    try {
      final url = '$baseurl/BusListApi/$apikey/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final busDetails = json.decode(response.body);
        for (var dataJson in busDetails['bus_list']) {
          _busList.add(Bus.fromJson(dataJson));
        }

        notifyListeners();
      }
    } catch (err) {
      throw err;
    }
  }
}
