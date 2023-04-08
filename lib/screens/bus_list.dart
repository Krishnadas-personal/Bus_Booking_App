import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BusList extends StatefulWidget {
  const BusList({super.key});

  @override
  State<BusList> createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("data"),
          Text("data"),
        ],
      ),
    );
  }
}
