import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tradingscrore/Helper/Databasehelper.dart';
import 'package:tradingscrore/screens/ViewStock.dart';

class Updatescreen extends StatefulWidget {
   var uid="";

  Updatescreen({required this.uid});
  @override
  State<Updatescreen> createState() => _UpdatescreenState();
}

class _UpdatescreenState extends State<Updatescreen> {
  TextEditingController dateinput=TextEditingController();
  TextEditingController _sharename=TextEditingController();
  TextEditingController _quantity=TextEditingController();
  TextEditingController _entry=TextEditingController();
  TextEditingController _stop=TextEditingController();
  TextEditingController _target=TextEditingController();
  TextEditingController _description=TextEditingController();
  TextEditingController _manualloss=TextEditingController();
  TextEditingController _manualtarget=TextEditingController();

  getonestock()async{
    Databasehelper obj=Databasehelper();
    var singlestock =await obj.getsingledata(widget.uid);
    setState(() {
      _sharename.text=singlestock[0]["sharename"].toString();
      dateinput.text=singlestock[0]["date"].toString();
      _quantity.text=singlestock[0]["qty"].toString();
      _entry.text=singlestock[0]["entry"].toString();
      _stop.text=singlestock[0]["stop"].toString();
      _target.text=singlestock[0]["target"].toString();
      _description.text=singlestock[0]["description"].toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getonestock();
  }
  var formkey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f8fb),
      appBar: AppBar(
        title: Text("Update Stock",style: TextStyle(
            color: Colors.black
        ),),
        foregroundColor: Colors.black,
        backgroundColor: Color(0xffffffff),
      ),
      body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Container(
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.uid),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      style: TextStyle(
                          fontSize: 20.0
                      ),
                      controller: dateinput,
                      validator: (val) {
                          if (val!.length<=0) {
                            return "Please select a Date ";
                          }
                          return null;
                        },
                      //editing controller of this TextField
                      decoration: InputDecoration(
                        labelText: "Date",
                        labelStyle:TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          // color: Color(0xffb0b3bd)
                        ),
                        prefixIcon: Icon(Icons.calendar_today),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue ,),
                          borderRadius: BorderRadius.circular(15.0),
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
                                    primary: Color(0xff283593), // <-- SEE HERE
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface: Colors.blueAccent, // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary: Colors.blueAccent, // button text color
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
                          // color:Color(0xffb0b3bd)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blue ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: _sharename,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Sharename";
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
                          // color:Color(0xffb0b3bd)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blue ),
                          borderRadius: BorderRadius.circular(30.0),
          
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: _quantity,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Entry Quantity";
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
                            fontWeight: FontWeight.bold
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blue ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: _entry,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Purchase Amount";
                          }
                          return null;
                        },
                    ),
                    SizedBox(height: 20.0,),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration (
                        labelText: "Stop Loss ( % )",
                        labelStyle:TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blue ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: _stop,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                            return "Please enter Stop loss Manual Amount";
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
                            return "Please enter Maual Target";
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
                            fontWeight: FontWeight.bold
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blue ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: _target,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (val) {
                          if (val!.length<=0) {
                            return "Please enter Target ";
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
                        labelText: "Description",
                        labelStyle:TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blue ),
                          borderRadius: BorderRadius.circular(30.0),
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
                          child: ElevatedButton(onPressed: () async{
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
                            var st =await obj.updatestock(date,sharename,qty,entry,stop,target,description,manualloss,manualtarget,widget.uid);
                            if(st==1){
                              print("data updated");
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewStock()));
                            }

                           }
                          },child: Text("Update",style: TextStyle(
                              fontSize: 20.0
                          ),),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            ),
                          ),
                        )
                    )
                  ],
                )
                ),
          ),

      ),
    );
  }
}
