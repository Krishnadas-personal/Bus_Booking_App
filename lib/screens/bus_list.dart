import 'package:bus_booking_app/provider/auth_provider.dart';
import 'package:bus_booking_app/provider/bus_provider.dart';
import 'package:bus_booking_app/screens/bus_details.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constants/constant.dart';
import '../widgets/grid.dart';

class BusList extends StatefulWidget {
  static const routenames = 'bus-list';
  const BusList({super.key});

  @override
  State<BusList> createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  bool loading = true;

  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).autoLogin().then((value) {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      final apikey = Provider.of<AuthProvider>(context, listen: false).userid;
      print(token);
      print(apikey);
      Provider.of<BusProvider>(context, listen: false)
          .buslist(token, apikey)
          .then((_) {
        setState(() {
          loading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final busLists = Provider.of<BusProvider>(context).busList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
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
            ),
          ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                children: List.generate(choicess.length, (index) {
                  return Grid(choicess: choicess, index: index);
                }),
              ),
            ),
            Text('${busLists.length} Buses Found '),
            Expanded(
              flex: 6,
              child: ListView.builder(
                  itemCount: busLists.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(busLists[index].name),
                        subtitle: Text(busLists[index].description),
                        trailing: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: Colors.red,
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (builder) {
                              return BusDetails(
                                name: busLists[index].name,
                                description: busLists[index].description,
                                seatCount: busLists[index].seatCount,
                                layout: busLists[index].seatLayout,
                              );
                            }));
                          },
                          child: const Text("Manage",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0)),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class Choices {
  const Choices(
      {required this.title,
      required this.image,
      required this.subtitle,
      required this.color});
  final String title;
  final String subtitle;
  final String image;
  final Color color;
}
