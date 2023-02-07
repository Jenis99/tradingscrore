import 'package:flutter/material.dart';
import 'package:tradingscrore/Helper/Databasehelper.dart';
import 'package:tradingscrore/screens/AddStock.dart';
import 'package:tradingscrore/screens/ClosedStock.dart';
import 'package:tradingscrore/screens/Homescreen.dart';
import 'package:tradingscrore/screens/Updatescreen.dart';
import 'package:tradingscrore/screens/exitpage.dart';

class ViewStock extends StatefulWidget {
  @override
  State<ViewStock> createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
  Future<List> ? allstock;
  Future<List> get_data()async{
    Databasehelper obj=Databasehelper();
    var data = await obj.get_stock();
    return data;
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
    backgroundColor: Color(0xfff4f8fb),

    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.add,
      ),
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>AddStock())
        );
      },
    ),
    body: FutureBuilder(
            future: get_data(),
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

                      var loss = (double.parse(entry)-(double.parse(entry)*double.parse(stop)/100)).toString();
                      var profit =(double.parse(entry)+(double.parse(entry)*double.parse(target)/100)).toString();
                      var total =(double.parse(entry)*double.parse(qty)).toString();

                      return GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                              title: Text(snapshot.data![index]["sharename"].toString().toUpperCase(),style: TextStyle(
                                  color:Colors.black,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold
                              ),),
                          content: Text(snapshot.data![index]["description"].toString()),
                          )
                          );
                        },
                        child: Container(
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
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                color: Colors.black45,),

                                              onPressed: ()async{
                                                AlertDialog alert = new AlertDialog(
                                                  title: Text("Warning!"),
                                                  content: Text("Are you sure you want to delete?"),
                                                  actions: [
                                                    ElevatedButton(onPressed: () async{
                                                      Navigator.of(context).pop();
                                                      var id = snapshot.data![index]["pid"].toString();
                                                      Databasehelper obj = new Databasehelper();
                                                      var status = await obj.delete_stock(id);
                                                      if(status==1){

                                                        setState(() {
                                                          allstock = get_data();
                                                        });
                                                        Navigator.of(context).pop();
                                                        Navigator.of(context).pop();
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute(builder: (context)=>ViewStock())
                                                        );
                                                      }
                                                      else
                                                      {
                                                        print("Record not Deleted");
                                                      }
                                                    },
                                                        child: Text("Yes"),
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Colors.black
                                                      ),
                                                    ),
                                                    ElevatedButton(onPressed: (){
                                                      Navigator.of(context).pop();
                                                    }, child: Text("No"),
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Colors.black
                                                      ),),
                                                  ],
                                                );

                                                showDialog(context: context, builder: (context){
                                                  return alert;
                                                });

                                              }),
                                            IconButton(
                                                icon: Icon(Icons.edit,
                                                  color: Colors.black45,),
                                                onPressed: ()async {
                                                  var id = snapshot.data![index]["pid"].toString();
                                                  Databasehelper obj = Databasehelper();
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Updatescreen(
                                                                uid:id,
                                                              ))
                                                  );
                                                }
                                            ),
                                            IconButton(onPressed: (){
                                              var id = snapshot.data![index]["pid"].toString();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (context)=>exitpage(
                                                    uid: id,
                                                  ))
                                              );
                                            }, icon: Icon(Icons.exit_to_app),color: Colors.black45,)
                                          ]
                                            ),
                                        Text(snapshot.data![index]["date"].toString(),style: TextStyle(
                                            color:Colors.black
                                        ),),
                                          ],
                                        ),

                                    SizedBox(height: 15.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data![index]["sharename"].toString(),style: TextStyle(
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
                                    Text("Investment : ₹ "+total,style: TextStyle(
                                        color:Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0
                                    ),),
                                    SizedBox(height: 20.0,),
                                    Text("Description : "+snapshot.data![index]["description"].toString()),
                                  ],
                                ),
                                )
                            ),
                          ),
                        );
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

    );
  }
}
