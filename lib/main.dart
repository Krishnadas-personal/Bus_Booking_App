import 'package:bus_booking_app/provider/auth_provider.dart';
import 'package:bus_booking_app/provider/bus_provider.dart';
import 'package:bus_booking_app/provider/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'screens/bus_list.dart';
import 'screens/driver_list.dart';
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
        ChangeNotifierProvider(
          create: (context) => DriverProvider(),
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
                    (authResult.data == false) ? const GetStarted() : const BusList()),
            routes: {
              LoginScreen.routenames: (context) => const LoginScreen(),
              BusList.routenames: (context) => const BusList(),
              DriverList.routenames: (context) => const DriverList(),
            },
          );
        },
      ),
    );
  }
}
