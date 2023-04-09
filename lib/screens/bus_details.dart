import 'package:flutter/material.dart';

import '../constants/constant.dart';
import 'driver_list.dart';

class BusDetails extends StatelessWidget {
  static const IconData chair = IconData(0xe14d, fontFamily: 'MaterialIcons');
  final String name;
  final String description;
  final int seatCount;
  final SeatLayout layout;

  const BusDetails(
      {super.key,
      required this.name,
      required this.description,
      required this.seatCount,
      required this.layout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('$name $description'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, DriverList.routenames);
              },
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              tileColor: Theme.of(context).primaryColor,
              title: Text(choicess[1].title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
              subtitle: Text(choicess[1].subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  )),
              trailing: Image.asset(
                fit: BoxFit.cover,
                "assets/${choicess[1].image}",
              ),
            ),
            seatingLayout()
          ]),
        ),
      ),
    );
  }

  seatingLayout() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _seatingChair(Colors.black),
            for (int i = 0; i < seatCount; i = i + 4)
              Row(
                children: [
                  _seatingChair(Colors.red),
                  if (layout == SeatLayout.oneByThree) const Spacer(),
                  _seatingChair(Colors.red),
                  if (layout == SeatLayout.twoByTwo) const Spacer(),
                  _seatingChair(Colors.red),
                  _seatingChair(Colors.red),
                ],
              ),
          ],
        ),
      ),
    );
  }

  _seatingChair(Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        chair,
        color: color,
      ),
    );
  }
}
