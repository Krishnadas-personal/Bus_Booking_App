import 'package:flutter/material.dart';

import '../screens/bus_list.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key,
    required this.choicess,
    required this.index,
  });

  final List<Choices> choicess;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          color: choicess[index].color,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                  child: Text(choicess[index].title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(choicess[index].subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      )),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    "assets/${choicess[index].image}",
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
