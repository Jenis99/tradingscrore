import 'package:flutter/material.dart';
import 'package:tradingscrore/Helper/Databasehelper.dart';
import 'package:tradingscrore/screens/ClosedStock.dart';
import 'package:tradingscrore/screens/Homescreen.dart';
import 'package:tradingscrore/screens/ViewStock.dart';
import 'package:tradingscrore/screens/exitpage.dart';
import 'package:path/path.dart';

class Tabsstock extends StatefulWidget {
  var balance=0.0;
  var maintab=0;
  Tabsstock({this.maintab=0});

  @override
  State<Tabsstock> createState() => _TabsstockState();
}

class _TabsstockState extends State<Tabsstock> {
  var selected=0;


  var balance=0.0;


  calculateresult() async
  {
    Databasehelper obj=Databasehelper();
    var data= await obj.get_close_stock();
    data.forEach((row) {
      setState(() {
        var s = (double.parse(row["exitamount"].toString())-double.parse(row["entry"].toString()))*double.parse(row["qty"].toString());
        print(double.parse(row["entry"].toString())-double.parse(row["exitamount"].toString()));
        balance = balance + s;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateresult();
    setState(() {
      selected = widget.maintab;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: selected,
      child: Scaffold(
        backgroundColor: Color(0xfff4f8fb),
        appBar: AppBar(
          title: Text("TS"),
          foregroundColor: Colors.black,
          backgroundColor: Color(0xffffffff),
          actions: [
           Center(
             child: Padding(
               padding: EdgeInsets.only(right: 25.0),
               child: Text("Rs."+balance.toString(),style: TextStyle(color: (balance<0)?Colors.red:Colors.green,fontSize: 30.0,fontWeight: FontWeight.bold),),
             ),
           )
          ],
          bottom: TabBar(
            indicatorColor: Colors.black,
            onTap: (index)
            {
              setState(() {
               print(index.toString());
              });
            },
            tabs: [

              Tab(
                child: Text("Opening Stock",style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Tab(
                child: Text("Closed Stock",style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
           ViewStock(),
            ClosedStock()
            // Column(
            //   children: [
            //     Text("First")
            //   ],
            // ),
            // Column(
            //   children: [
            //     Text("Second")
            //   ],
            // ),

          ],
        ),
      ),
    );
  }
}
