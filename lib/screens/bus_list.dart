import 'package:bus_booking_app/models/bus.dart';
import 'package:bus_booking_app/provider/auth_provider.dart';
import 'package:bus_booking_app/provider/bus_provider.dart';
import 'package:bus_booking_app/screens/bus_details.dart';
import 'package:bus_booking_app/screens/driver_list.dart';

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
      Provider.of<BusProvider>(context, listen: false)
          .buslist(token, apikey)
          .then((_) {
        loading = false;
      });
    });
    super.initState();
  }

  Future<bool> _onPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final busLists = Provider.of<BusProvider>(context).busList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(child: Image.asset('assets/logo.png')),
      ),
      body: (loading)
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Grid(
                          title: "Bus",
                          color: Colors.red,
                          image: 'bus.png',
                          subtitle: "Manage your Bus",
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(BusList.routenames);
                          },
                        ),
                      ),
                      Flexible(
                        child: Grid(
                          title: "Driver",
                          color: Theme.of(context).primaryColor,
                          image: 'driver.png',
                          subtitle: "Manage your Driver",
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(DriverList.routenames);
                          },
                        ),
                      ),
                    ],
                  ),
                  Text('${busLists.length} Buses Found '),
                  Expanded(
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
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (builder) {
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
