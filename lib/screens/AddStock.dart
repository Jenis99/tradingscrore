import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tradingscrore/Helper/Databasehelper.dart';
import 'package:tradingscrore/screens/Tabsstock.dart';
import 'package:tradingscrore/screens/ViewStock.dart';

class AddStock extends StatefulWidget {
  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  TextEditingController dateinput=TextEditingController();
  TextEditingController _sharename=TextEditingController();
  TextEditingController _quantity=TextEditingController();
  TextEditingController _entry=TextEditingController();
  TextEditingController _stop=TextEditingController();
  TextEditingController _target=TextEditingController();
  TextEditingController _description=TextEditingController();
  TextEditingController _manualloss=TextEditingController();
  TextEditingController _manualtarget=TextEditingController();


  var formkey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xfff4f8fb),
      appBar: AppBar(
        title: Text("Add Stock",style: TextStyle(
          color: Colors.black
        ),),
        foregroundColor: Colors.black,
        backgroundColor: Color(0xffffffff),
      ),
      body: SingleChildScrollView(
          child: (
              Container(
                   padding: EdgeInsets.only(left: 10.0,right: 10.0),
                  child: Form(
                    key:formkey ,
                    child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                        controller: dateinput,
                          validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Date";
                          }
                          return null;
                        },
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
                              dateinput.text =formattedDate.toString(); //set output date to TextField value.
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                          
                        decoration: InputDecoration (
                          labelText: "Share Name",
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
                        controller: _sharename,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Date";
                          }
                          return null;
                        },
                        
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                        decoration: InputDecoration (
                          labelText: "Entry",
                          labelStyle:TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black45 ),
                            // borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black),
                          ),
                        ),
                        controller: _entry,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Entry Amount";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                        decoration: InputDecoration (
                          labelText: "Quantity",
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
                        controller: _quantity,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Quantity";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                        decoration: InputDecoration (
                          labelText: "Target ( % )",
                          labelStyle:TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black45 ),
                            // borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black45),
                          ),
                        ),
                        controller: _target,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Target";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        decoration: InputDecoration (
                          labelText: "Stop Loss ( % )",
                          labelStyle:TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black45 ),
                            // borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black),
                          ),
                        ),
                        controller: _stop,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Stop Loss";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                        decoration: InputDecoration (
                          labelText: "Target Manual",
                          labelStyle:TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black45 ),
                            // borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black45),
                          ),
                        ),
                        controller: _manualtarget,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Manual Target";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        decoration: InputDecoration (
                          labelText: "Stop Loss Manual",
                          labelStyle:TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black45 ),
                            // borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black),
                          ),
                        ),
                        controller: _manualloss,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Manual Loss";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black
                        ),
                        decoration: InputDecoration (
                          labelText: "Description",
                          labelStyle:TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black45 ),
                            // borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black),
                          ),
                        ),
                        controller: _description,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Description";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0,),
                      Center(
                          child:  SizedBox(
                            width: 150.0,
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () async{
                              if(formkey.currentState!.validate()){

                              var date = dateinput.text.toString();
                              var sharename=_sharename.text.toString();
                              var qty=_quantity.text.toString();
                              var entry=_entry.text.toString();
                              var stop=_stop.text.toString();
                              var target=_target.text.toString();
                              var description=_description.text.toString();
                              var manualtarget=_manualtarget.text.toString();
                              var manualloss=_manualloss.text.toString();
                                Databasehelper obj=Databasehelper();
                                var id =await obj.insert_stock(date,sharename,qty,entry,stop,target,description,manualtarget,manualloss);
                                print("Inserted"+id.toString());
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Tabsstock()));
                              }
                              },
                              child: Text("Add",style: TextStyle(
                                fontSize: 20.0
                            ),),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                            ),
                          )
                      ),

                    ],
                  ) 
                    )
              )
          )
      ),
    );
  }
}
