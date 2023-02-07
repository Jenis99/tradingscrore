import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradingscrore/screens/pinscreen.dart';

class setpin extends StatefulWidget {
  @override
  State<setpin> createState() => _setpinState();
}

class _setpinState extends State<setpin> {
  OtpFieldController _password = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    if(pin!=null){
                                    SharedPreferences prefs= await SharedPreferences.getInstance();
                                    prefs.setString("password",pin);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>pinscreen())
                                    );
                                  }
                    // if (prefs.containsKey("password")) {
                    //   if (prefs.getString("password").toString() == pin) {
                    //     Navigator.of(context).pop();
                    //     Navigator.of(context).push(
                    //         MaterialPageRoute(builder: (context) => ViewStock()));
                    //   } else {
                    //     AlertDialog(
                    //       title: Text("Error!"),
                    //       content: Text("Please enter a correct password"),
                    //       actions: [
                    //         ElevatedButton(
                    //             onPressed: () async {
                    //               Navigator.of(context).pop();
                    //             },
                    //             child: Text("Retry")),
                    //         ElevatedButton(
                    //             onPressed: () {
                    //               Navigator.of(context).pop();
                    //             },
                    //             child: Text("Cancle")),
                    //       ],
                    //     );
                    //   }
                    // } else {
                    //   AlertDialog(
                    //     title: Text("Error!"),
                    //     content: Text("Please enter a correct password"),
                    //     actions: [
                    //       ElevatedButton(
                    //           onPressed: () async {
                    //             Navigator.of(context).pop();
                    //           },
                    //           child: Text("Retry")),
                    //       ElevatedButton(
                    //           onPressed: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //           child: Text("Cancle")),
                    //     ],
                    //   );
                    }
  ),
  ]
                ),

              )
          ),
        ),
        // child: Container(
        //   padding: EdgeInsets.only(left: 10.0,right: 10.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(height: 20.0,),
        //       Text("Set pin",style: TextStyle(
        //           fontSize: 20.0
        //       ),),
        //       SizedBox(height: 5.0,),
        //       TextFormField(decoration: InputDecoration(
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(10.0),
        //           ),
        //           filled: true,
        //           hintStyle: TextStyle(color: Colors.grey[800]),
        //           hintText: "Enter Pin",
        //           fillColor: Colors.white70),
        //         controller: _password,
        //         keyboardType:TextInputType.number,
        //         obscureText: true,
        //       ),
        //       SizedBox(height: 20.0,),
        //       Text("Confirm pin",style: TextStyle(
        //           fontSize: 20.0
        //       ),),
        //       SizedBox(height: 5.0,),
        //
        //       TextFormField(decoration: InputDecoration(
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(10.0),
        //           ),
        //           filled: true,
        //           hintStyle: TextStyle(color: Colors.grey[800]),
        //           hintText: "Enter Pin",
        //           fillColor: Colors.white70),
        //         controller: _confirm,
        //         keyboardType:TextInputType.number,
        //         obscureText: true,
        //       ),
        //       SizedBox(height: 20.0,),
        //       Center(
        //         child: ElevatedButton(onPressed: ()async{
        //           var password=_password.text.toString();
        //           var confirm=_confirm.text.toString();
        //           if(password==confirm){
        //             SharedPreferences prefs= await SharedPreferences.getInstance();
        //             prefs.setString("password",password);
        //             Navigator.of(context).pop();
        //             Navigator.of(context).push(
        //                 MaterialPageRoute(builder: (context)=>pinscreen())
        //             );
        //           }
        //           else{
        //             print("Enter Same Pin");
        //           }
        //         },
        //             child: Text("Submit")),
        //       )
        //     ],
        //   ),
        // )
    );
  }
}
