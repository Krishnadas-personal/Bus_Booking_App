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
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('moov',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_drop_down, color: Colors.yellow, size: 50.0),
              Text('be',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold)),
            ],
          )
        ]),
      ),
      bottomNavigationBar: LongButton(
          text: 'Get Started',
          buttonColor: Colors.white,
          textColor: Colors.red,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }),
            );
          }),
    );
  }
}
