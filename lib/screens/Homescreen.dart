import 'package:flutter/material.dart';
import 'package:tradingscrore/screens/AddStock.dart';

class Homescreen extends StatefulWidget {

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>AddStock())
          );
        },
      ),
      body: Center(
        child: Text("This is Home Screen"),
      )
    );
  }
}
