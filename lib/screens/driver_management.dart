import 'package:bus_booking_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/driver_provider.dart';
import '../widgets/button.dart';

class DriverManagement extends StatefulWidget {
  const DriverManagement({super.key});

  @override
  State<DriverManagement> createState() => _DriverManagementState();
}

class _DriverManagementState extends State<DriverManagement> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> driverData = {'name': '', 'mobile': '', 'license_no': ''};

  void _saveDriver() {
    final validater = _formKey.currentState?.validate();

    if (!validater!) {
      return;
    }
    _formKey.currentState?.save();
    Provider.of<AuthProvider>(context, listen: false).autoLogin().then((_) {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      final apikey = Provider.of<AuthProvider>(context, listen: false).userid;
      print(token);
      print(apikey);
      Provider.of<DriverProvider>(context, listen: false)
          .addDriver(token, apikey, driverData)
          .then((_) {
        var driveradd =
            Provider.of<DriverProvider>(context, listen: false).driverAdd;
        if (driveradd['status'] == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(driveradd['message'])));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(child: const Text("Add Driver")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                  label: "Enter Name",
                  onSaved: (value) {
                    driverData['name']=value;
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Name is Mandatory';
                    }
                    return null;
                  }),
              CustomTextField(
                  label: "Enter License Number",
                  onSaved: (value) {
                    driverData['license_no'] = value;
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'License Number is Mandatory';
                    }
                    return null;
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: LongButton(
          text: 'Save',
          buttonColor: Colors.red,
          textColor: Colors.white,
          onTap: _saveDriver),
    );
  }
}
