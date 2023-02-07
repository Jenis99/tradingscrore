import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tradingscrore/Helper/Databasehelper.dart';
import 'package:tradingscrore/screens/ClosedStock.dart';
import 'package:tradingscrore/screens/Tabsstock.dart';
import 'package:tradingscrore/screens/ViewStock.dart';

class exitpage extends StatefulWidget {
  var uid="";
  exitpage({required this.uid});
  @override
  State<exitpage> createState() => _exitpageState();
}

class _exitpageState extends State<exitpage> {

  TextEditingController _exitamount=TextEditingController();
  TextEditingController _exitdate=TextEditingController();
  TextEditingController _exitremark=TextEditingController();


  getonestock()async{
    Databasehelper obj=Databasehelper();
    var singlestock =await obj.getsingledata(widget.uid);
    print(widget.uid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getonestock();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10.0,left: 10.0),
                child:
                 Column(
                   children: [
                     SizedBox(height: 100.0,),
                     Text("Exit The Stock",style: TextStyle(
                       fontSize: 35.0,
                       fontWeight: FontWeight.bold
                     ),),
                     SizedBox(height: 30.0,),
                     TextField(
                       style: TextStyle(
                           fontSize: 20.0
                       ),
                       decoration: InputDecoration (
                         labelText: "Exit Amount",
                         labelStyle:TextStyle(
                             fontSize: 20.0,
                             fontWeight: FontWeight.bold,
                             color: Colors.black45
                           // color:Color(0xffb0b3bd)
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide:BorderSide(color: Colors.black45 ),
                           // borderRadius: BorderRadius.circular(30.0),
                         ),
                         enabledBorder:  OutlineInputBorder(
                           borderSide:BorderSide(color: Colors.black),
                         ),
                       ),
                       controller: _exitamount,
                       keyboardType: TextInputType.number,
                     ),
                     SizedBox(height: 30.0,),
                     TextField(
                       style: TextStyle(
                           fontSize: 20.0
                       ),
                       controller: _exitdate,
                       //editing controller of this TextField
                       decoration: InputDecoration(
                         labelText: "Date",
                         labelStyle:TextStyle(
                             fontSize: 20.0,
                             fontWeight: FontWeight.bold,
                             color: Colors.black45
                           // color: Color(0xffb0b3bd)
                         ),
                         prefixIcon: Icon(Icons.calendar_today,color: Colors.black45,),
                         focusedBorder: OutlineInputBorder(
                           borderSide: const BorderSide(color: Colors.black45 ,),
                           // borderRadius: BorderRadius.circular(15.0),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color:Colors.black ),
                           // borderRadius: BorderRadius.circular(10.0),
                         ),
                       ),
                       readOnly: true,
                       //set it true, so that user will not able to edit text
                       onTap: () async {
                         DateTime? pickedDate = await showDatePicker(
                             context: context,
                             initialDate: DateTime.now(),
                             firstDate: DateTime(1950),
                             //DateTime.now() - not to allow to choose before today.
                             lastDate: DateTime(2100),
                             builder: (context, child) {
                               return Theme(
                                 data: Theme.of(context).copyWith(
                                   colorScheme: ColorScheme.light(
                                     primary: Colors.black, // <-- SEE HERE
                                     onPrimary: Colors.white, // <-- SEE HERE
                                     onSurface: Colors.black, // <-- SEE HERE
                                   ),
                                   textButtonTheme: TextButtonThemeData(
                                     style: TextButton.styleFrom(
                                       primary: Colors.black, // button text color
                                     ),
                                   ),
                                 ),
                                 child: child!,
                               );
                             }
                         );
                         Container(
                           child: SfDateRangePicker(
                             selectionMode: DateRangePickerSelectionMode.range,
                           ),
                         );
                         if (pickedDate != null) {
                           String formattedDate =
                           DateFormat('dd-MM-yyyy').format(pickedDate);
                           setState(() {
                             _exitdate.text =formattedDate.toString(); //set output date to TextField value.
                           });
                         }
                       },
                     ),
                     SizedBox(height: 30.0,),
                     TextField(
                       style: TextStyle(
                           fontSize: 20.0,
                           color: Colors.black45
                       ),
                       decoration: InputDecoration (
                         labelText: "Remark",
                         labelStyle:TextStyle(
                             fontSize: 20.0,
                             fontWeight: FontWeight.bold,
                             color: Colors.black
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide:BorderSide(color: Colors.black45 ),
                           // borderRadius: BorderRadius.circular(30.0),
                         ),
                         enabledBorder:  OutlineInputBorder(
                           borderSide:BorderSide(color: Colors.black),
                         ),
                       ),
                       controller: _exitremark,
                       keyboardType: TextInputType.text,
                     ),
                     SizedBox(height: 30.0,),
                     SizedBox(
                       width: 150.0,
                       height: 40.0,
                       child: ElevatedButton(onPressed: ()async{
                         var exitamount=_exitamount.text.toString();
                         var exitdate=_exitdate.text.toString();
                         var remark=_exitremark.text.toString();


                         Databasehelper obj = Databasehelper();
                         var st = await obj.update_exitstock(exitamount,exitdate,remark,widget.uid);
                         print(st);
                         if(st==1){
                           print("data updated");
                           Navigator.of(context).pop();
                           Navigator.of(context).pop();
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Tabsstock(
                             maintab: 1,
                           )));
                         }
                         else{
                           print("Try Agin");
                         }
                       }, child: Text("Submit",style: TextStyle(
                           fontSize: 20.0
                       ),),
                       style: ElevatedButton.styleFrom(
                         primary: Colors.black
                       ),),
                     ),
                     SizedBox(height: 10.0,),
                     Text("* If you once exit this stock you are not able to re-enter this this stock.")
                   ],
                 )

              ),
            ],
          ),
        ),
      ),
    );
  }
}
