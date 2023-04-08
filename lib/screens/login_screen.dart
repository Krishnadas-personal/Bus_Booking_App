import 'package:bus_booking_app/provider/auth_provider.dart';
import 'package:bus_booking_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/text_field.dart';
import 'bus_list.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  void _saveForm() {
    final validater = _formKey.currentState?.validate();

    if (!validater!) {
      return;
    }
    _formKey.currentState?.save();
    Provider.of<AuthProvider>(context, listen: false)
        .authendicate(_authData)
        .then((_) {
      Map<String, dynamic> auth =
          Provider.of<AuthProvider>(context, listen: false).authList;
      if (auth['status'] == true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(auth['message'])));
        Navigator.of(context).pushNamed(BusList.routenames);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(auth['message'])));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQuery.size.height * 1,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(
                      stops: const [.5, .5],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Theme.of(context).primaryColor,
                        Colors.red,
                      ],
                    ),
                  ),
                  height: mediaQuery.size.height * 0.3,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Welcome",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold)),
                        Text("Manage your Bus and Drivers",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                CustomTextField(
                    label: "Enter Username",
                    onSaved: (newvalue) {
                      _authData['username'] = newvalue;
                    },
                    validate: (value) {
                      if (value.isEmpty) {
                        return "Username is Mandatory";
                      }
                      return null;
                    }),
                CustomTextField(
                    label: "Enter Password",
                    onSaved: (newvalue) {
                      _authData['password'] = newvalue;
                    },
                    validate: (value) {
                      if (value.isEmpty) {
                        return "Password is Mandatory";
                      }
                      return null;
                    }),
                const Spacer(),
                LongButton(
                  text: "Login",
                  buttonColor: Colors.red,
                  textColor: Colors.white,
                  onTap: _saveForm,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
