import 'package:flutter/material.dart';
import 'package:tradingscrore/screens/Updatescreen.dart';
import 'package:tradingscrore/screens/exitpage.dart';

import '../Helper/Databasehelper.dart';
import '../Helper/DotWidget.dart';

class ClosedStock extends StatefulWidget {
  @override
  State<ClosedStock> createState() => _ClosedStockState();
}

class _ClosedStockState extends State<ClosedStock> {
  var get=0.0;
  var total=0.0;

  var type = "all";

  Future<List> ? allstock;
  Future<List> get_data()async{
    Databasehelper obj=Databasehelper();
    var data = await obj.get_close_stock();
    return data.toList();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allstock=get_data();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        height: 25.0,
                        child: ElevatedButton(onPressed: (){
                          setState(() {
                            type="all";
                            allstock=null;
                             allstock=get_data();
                          });
                           
                        }, child: Text("ALL"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black
                          ),
                        )
                    ),
                    SizedBox(
                        height: 25.0,
                        child: ElevatedButton(onPressed: (){
                            setState(() {
                            type="profit";
                             allstock=null;
                            allstock=get_data();
                          });
                          
                        }, child: Text("Profit"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black
                          ),
                        ),
                    ),
                    SizedBox(
                        height: 25.0,
                        child: ElevatedButton(onPressed: (){
                          setState(() {
                            type="loss";
                             allstock=null;
                             allstock=get_data();
                          });
                           
                        }, child: Text("Loss"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black
                          ),
                        )
                    )
                  ],
                ),
                SizedBox(height: 10.0,),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: allstock,
                builder: (context,snapshot){
                  if(snapshot.hasData)
                  {
                    if(snapshot.data!.length == 0)
                    {
                      return Center(
                        child: Text("No Stock"),
                      );
                    }
                    else
                    {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var stop=snapshot.data![index]["stop"].toString();
                          var entry=snapshot.data![index]["entry"].toString();
                          var target=snapshot.data![index]["target"].toString();
                          var qty=snapshot.data![index]["qty"].toString();
                          var exitamount=snapshot.data![index]["exitamount"].toString();

                          var loss = (double.parse(entry)-(double.parse(entry)*double.parse(stop)/100)).toString();
                          var profit =(double.parse(entry)+(double.parse(entry)*double.parse(target)/100)).toString();
                          var total =(double.parse(entry)*double.parse(qty)).toString();


                          get=((double.parse(exitamount)-double.parse(entry))*double.parse(qty)).toDouble();

                          if(type=="loss" && get<=0)
                          {
                             return Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: EdgeInsets.only(top: 20.0),
                            child: Card(
                              elevation: 15.0,
                              child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color:Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children:[
                                            Text(snapshot.data![index]["date"].toString(),style: TextStyle(
                                                color:Colors.black
                                            ),),
                                          ]
                                      ),
                                      SizedBox(height: 15.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data![index]["sharename"].toString().toUpperCase(),style: TextStyle(
                                              color:Colors.black,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text("Qty : "+snapshot.data![index]["qty"].toString(),style: TextStyle(
                                              color:Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),),

                                        ],
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Entry",style: TextStyle(
                                                  color:Colors.black,
                                                  fontSize: 20.0
                                              ),),
                                              SizedBox(height: 5.0,),
                                              Text(snapshot.data![index]["entry"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 25.0,
                                              ),),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Stop Loss",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(loss,style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                              SizedBox(height: 10.0,),
                                              Text("Manual Loss",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(snapshot.data![index]["manualloss"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),

                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Target",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(profit,style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                              SizedBox(height: 10.0,),
                                              Text("Manual Target",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(snapshot.data![index]["manualtarget"].toString(),
                                                style: TextStyle(
                                                    color:Colors.black,
                                                    fontSize: 20.0

                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0,),
                                      Text("Description : "+snapshot.data![index]["description"].toString()),
                                      SizedBox(height: 10.0,),
                                      Text("Investment : ₹ "+total,style: TextStyle(
                                          color:Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0
                                      ),),
                                      SizedBox(height: 20.0,),
                                      DotWidget(
                                        dashColor: Colors.black,
                                        dashHeight: 2,
                                        dashWidth: 2,
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Exit Date",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 5.0,),
                                              Text(snapshot.data![index]["exitdate"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Exit Amount",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 5.0,),
                                              Text(snapshot.data![index]["exitamount"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 13.0,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text("Remark",style: TextStyle(
                                                      color:Colors.black,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  SizedBox(height: 5.0,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width/2,
                                                    child: Text(snapshot.data![index]["remark"].toString(),style: TextStyle(
                                                      color:Colors.black,
                                                      fontSize: 15.0,
                                                    ),),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(get.toString(),style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color:(get<0)?Colors.red:Colors.green,
                                            ),),
                                          )

                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          );
                          }
                          else if(type=="profit" && get>=1)
                          {
                            return Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: EdgeInsets.only(top: 20.0),
                            child: Card(
                              elevation: 15.0,
                              child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color:Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children:[
                                            Text(snapshot.data![index]["date"].toString(),style: TextStyle(
                                                color:Colors.black
                                            ),),
                                          ]
                                      ),
                                      SizedBox(height: 15.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data![index]["sharename"].toString().toUpperCase(),style: TextStyle(
                                              color:Colors.black,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text("Qty : "+snapshot.data![index]["qty"].toString(),style: TextStyle(
                                              color:Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),),

                                        ],
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Entry",style: TextStyle(
                                                  color:Colors.black,
                                                  fontSize: 20.0
                                              ),),
                                              SizedBox(height: 5.0,),
                                              Text(snapshot.data![index]["entry"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 25.0,
                                              ),),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Stop Loss",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(loss,style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                              SizedBox(height: 10.0,),
                                              Text("Manual Loss",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(snapshot.data![index]["manualloss"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),

                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Target",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(profit,style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                              SizedBox(height: 10.0,),
                                              Text("Manual Target",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(snapshot.data![index]["manualtarget"].toString(),
                                                style: TextStyle(
                                                    color:Colors.black,
                                                    fontSize: 20.0

                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0,),
                                      Text("Description : "+snapshot.data![index]["description"].toString()),
                                      SizedBox(height: 10.0,),
                                      Text("Investment : ₹ "+total,style: TextStyle(
                                          color:Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0
                                      ),),
                                      SizedBox(height: 20.0,),
                                      DotWidget(
                                        dashColor: Colors.black,
                                        dashHeight: 2,
                                        dashWidth: 2,
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Exit Date",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 5.0,),
                                              Text(snapshot.data![index]["exitdate"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Exit Amount",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 5.0,),
                                              Text(snapshot.data![index]["exitamount"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 13.0,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text("Remark",style: TextStyle(
                                                      color:Colors.black,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  SizedBox(height: 5.0,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width/2,
                                                    child: Text(snapshot.data![index]["remark"].toString(),style: TextStyle(
                                                      color:Colors.black,
                                                      fontSize: 15.0,
                                                    ),),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(get.toString(),style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color:(get<0)?Colors.red:Colors.green,
                                            ),),
                                          )

                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          );
                          }
                          else
                          {
                            return Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: EdgeInsets.only(top: 20.0),
                            child: Card(
                              elevation: 15.0,
                              child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color:Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children:[
                                            Text(snapshot.data![index]["date"].toString(),style: TextStyle(
                                                color:Colors.black
                                            ),),
                                          ]
                                      ),
                                      SizedBox(height: 15.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data![index]["sharename"].toString().toUpperCase(),style: TextStyle(
                                              color:Colors.black,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text("Qty : "+snapshot.data![index]["qty"].toString(),style: TextStyle(
                                              color:Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),),

                                        ],
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Entry",style: TextStyle(
                                                  color:Colors.black,
                                                  fontSize: 20.0
                                              ),),
                                              SizedBox(height: 5.0,),
                                              Text(snapshot.data![index]["entry"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 25.0,
                                              ),),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Stop Loss",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(loss,style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                              SizedBox(height: 10.0,),
                                              Text("Manual Loss",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(snapshot.data![index]["manualloss"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),

                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Target",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(profit,style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                              SizedBox(height: 10.0,),
                                              Text("Manual Target",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 2.0,),
                                              Text(snapshot.data![index]["manualtarget"].toString(),
                                                style: TextStyle(
                                                    color:Colors.black,
                                                    fontSize: 20.0

                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0,),
                                      Text("Description : "+snapshot.data![index]["description"].toString()),
                                      SizedBox(height: 10.0,),
                                      Text("Investment : ₹ "+total,style: TextStyle(
                                          color:Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0
                                      ),),
                                      SizedBox(height: 20.0,),
                                      DotWidget(
                                        dashColor: Colors.black,
                                        dashHeight: 2,
                                        dashWidth: 2,
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Exit Date",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 5.0,),
                                              Text(snapshot.data![index]["exitdate"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("Exit Amount",style: TextStyle(
                                                color:Colors.black,
                                              ),),
                                              SizedBox(height: 5.0,),
                                              Text(snapshot.data![index]["exitamount"].toString(),style: TextStyle(
                                                color:Colors.black,
                                                fontSize: 20.0,
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 13.0,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text("Remark",style: TextStyle(
                                                      color:Colors.black,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  SizedBox(height: 5.0,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width/2,
                                                    child: Text(snapshot.data![index]["remark"].toString(),style: TextStyle(
                                                      color:Colors.black,
                                                      fontSize: 15.0,
                                                    ),),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(get.toString(),style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color:(get<0)?Colors.red:Colors.green,
                                            ),),
                                          )

                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          );
                          }

                         
                        },
                      );
                    }
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            ),
          )
        ],
      ),
    );
  }
}
