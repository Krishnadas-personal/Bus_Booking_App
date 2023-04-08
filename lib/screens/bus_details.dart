import 'package:flutter/material.dart';

import '../constants/constant.dart';
import '../widgets/grid.dart';

class BusDetails extends StatelessWidget {
  final String name;
  final String description;
  final int seatCount;
  final String layout;

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
        child: Column(children: [
          ListTile(
            onTap: () {},
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
              "assets/${choicess[1].image}",
            ),
          ),
        ]),
      ),
    );
  }
}
