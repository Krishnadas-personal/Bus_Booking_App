import 'package:bus_booking_app/provider/auth_provider.dart';
import 'package:bus_booking_app/provider/bus_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/bus_details.dart';
import 'screens/bus_list.dart';
import 'screens/get_started.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BusProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bus Booking',
            theme: ThemeData(
              primaryColor: Colors.black,
              // primarySwatch: Colors.red,
            ),
            home: FutureBuilder(
                future: auth.autoLogin(),
                builder: (ctx, authResult) =>
                    (authResult.data == false) ? GetStarted() : BusList()),
            routes: {
              BusList.routenames: (context) => BusList(),
            },
          );
        },
      ),
    );
  }
}
