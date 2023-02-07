import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:tradingscrore/screens/Homescreen.dart';
import 'package:tradingscrore/screens/Tabsstock.dart';
import 'package:tradingscrore/screens/ViewStock.dart';

class pinscreen extends StatefulWidget {
  @override
  State<pinscreen> createState() => _pinscreenState();
}

class _pinscreenState extends State<pinscreen> {
  OtpFieldController _password = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                    child: Column(children: [
                      SizedBox(
                        height: 250.0,
                      ),
                      Text("This is Pinscreen"),
                      SizedBox(
                        height: 30.0,
                      ),
                      OTPTextField(
                        controller: _password,
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        keyboardType: TextInputType.number,
                        fieldWidth: 45,
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 15,
                        obscureText: true,
                        style: TextStyle(fontSize: 17),
                        onChanged: (pin) {
                          print("Changed: " + pin);
                        },
                        onCompleted: (pin) async {
                          print("Completed: " + pin);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          if (prefs.containsKey("password")) {
                            if (prefs.getString("password").toString() == pin) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Tabsstock()));
                            } else {
                              AlertDialog(
                                title: Text("Error!"),
                                content: Text("Please enter a correct password"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Retry")),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancle")),
                                ],
                              );
                            }
                          } else {
                            AlertDialog(
                              title: Text("Error!"),
                              content: Text("Please enter a correct password"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Retry")),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancle")),
                              ],
                            );
                          }
                        },
                      ),
                    ]
                  )
                ),
              ),
            )
        )
    );
  }
}
