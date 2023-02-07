import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradingscrore/screens/pinscreen.dart';
import 'package:tradingscrore/screens/setpin.dart';

class Splacescreen extends StatefulWidget {
  @override
  State<Splacescreen> createState() => _SplacescreenState();
}

class _SplacescreenState extends State<Splacescreen> {
  checkpin(){
    Future.delayed(const Duration(seconds: 3), ()async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey("password")){
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>pinscreen())
        );
      }
      else{
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>setpin())
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkpin();
  }
  TextEditingController _password= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("img/tradinglogo.png"),
      ),
    );
  }
}
