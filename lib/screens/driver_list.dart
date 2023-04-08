import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/driver_provider.dart';
import '../widgets/button.dart';
import 'driver_management.dart';

class DriverList extends StatefulWidget {
  static const routenames = 'driver-detail';
  const DriverList({super.key});

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  bool loading = true;

  @override
  void initState() {
    driverListing();
    super.initState();
  }

  void driverListing() {
    Provider.of<AuthProvider>(context, listen: false).autoLogin().then((value) {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      final apikey = Provider.of<AuthProvider>(context, listen: false).userid;
      print(token);
      print(apikey);
      Provider.of<DriverProvider>(context, listen: false)
          .driverlist(token, apikey)
          .then((_) {
        setState(() {
          loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final driverList = Provider.of<DriverProvider>(context).driverList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Center(child: Text("Driver List")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${driverList.length} Drivers Found '),
            Expanded(
              child: ListView.builder(
                  itemCount: driverList.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, DriverList.routenames);
                        },
                        contentPadding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        tileColor: Colors.white,
                        leading: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/driver_img.png')),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(driverList[index].name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                )),
                            Text('Licn no: ${driverList[index].licenseNo}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                )),
                          ],
                        ),
                        trailing: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: Colors.red,
                          onPressed: () {
                            Provider.of<AuthProvider>(context, listen: false)
                                .autoLogin()
                                .then((_) {
                              final token = Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .token;
                              final apikey = Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .userid;

                              Provider.of<DriverProvider>(context,
                                      listen: false)
                                  .delDriver(token, apikey,
                                      driverList[index].licenseNo)
                                  .then((_) {
                                var driverdelete = Provider.of<DriverProvider>(
                                        context,
                                        listen: false)
                                    .deleteDriver;
                                if (driverdelete['status'] == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(driverdelete['message']),
                                    ),
                                  );
                                }
                              });
                            });
                          },
                          child: const Text("Delete",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0)),
                        ),
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
      bottomNavigationBar: LongButton(
          text: 'Add Driver',
          buttonColor: Colors.red,
          textColor: Colors.white,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const DriverManagement();
              }),
            ).then((_) {
              driverListing();
            });
          }),
    );
  }
}
