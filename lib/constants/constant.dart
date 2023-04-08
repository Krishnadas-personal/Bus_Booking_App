import 'package:flutter/material.dart';

import '../screens/bus_list.dart';

var baseurl= 'http://flutter.noviindus.co.in/api';

List<Choices> choicess = <Choices>[
    const Choices(
        title: 'Bus',
        subtitle: 'Manage your Bus',
        image: 'bus.png',
        color: Colors.red),
    const Choices(
        title: 'Driver',
        subtitle: 'Manage your Driver',
        image: 'driver.png',
        color: Colors.black),
  ];