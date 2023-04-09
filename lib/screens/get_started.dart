import 'package:bus_booking_app/screens/login_screen.dart';
import 'package:bus_booking_app/widgets/button.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child:Image.asset('assets/logo.png')
      ),
      bottomNavigationBar: LongButton(
          text: 'Get Started',
          buttonColor: Colors.white,
          textColor: Colors.red,
          onTap: () {
               Navigator.of(context).pushReplacementNamed(LoginScreen.routenames);
          }),
    );
  }
}
