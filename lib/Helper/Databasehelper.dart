import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databasehelper{
  Database ? db;


  Future<Database> create_db()async{
    if(db==null){
      Directory dir =await getApplicationDocumentsDirectory();
      String path = join(dir.path,"Stock_db");
      var db = await openDatabase(path,version: 1,onCreate: create_table);
      return db;
    }
    else{
      print("db already created");
      return db!;
    }
  }

  create_table(Database db,int version){
    db.execute("create table stock (pid integer primary key autoincrement,date text,sharename text,qty text,entry double,stop double,target double,description text,manualtarget double,manualloss double,exitamount double,exitdate text,remark text,status text)");

  }

  Future<int> insert_stock(date,sharename,qty,entry,stop,target,description,manualtarget,manualloss)async{
    var db = await create_db();
    var id =db.rawInsert("insert into stock (date,sharename,qty,entry,stop,target,description,manualtarget,manualloss,exitamount,exitdate,remark,status) values(?,?,?,?,?,?,?,?,?,?,?,?,?)",[date,sharename,qty,entry,stop,target,description,manualtarget,manualloss,"0","","","open"]);
    return id;
  }


  Future<List> get_stock()async{
    var db = await create_db();
    var data = await db.rawQuery("select * from stock where status=? order by pid desc",["open"]);
    return data.toList();
  }
  Future<List> get_close_stock()async{
    var db = await create_db();
    var data = await db.rawQuery("select * from stock where status=? order by pid desc",["close"]);
    return data.toList();
  }

  Future<int> delete_stock(id)async{
    var db = await create_db();
    var status = await db.rawDelete("delete from stock where pid=?",[id]);
    return status;
  }

  Future<List> getsingledata(id)async{
    var db = await create_db();
    var data = await db.rawQuery("select * from stock where pid=?",[id]);
    return data.toList();
  }

  Future<int> updatestock(date,sharename,qty,entry,stop,target,description,manualloss,manualtarget,id)async{
  var db = await create_db();
  var status =await db.rawUpdate("update stock set date=?,sharename=?,qty=?,entry=?,stop=?,target=?,description=?,manualtarget=?,manualloss=?",[date,sharename,qty,entry,stop,target,description,manualtarget,manualloss]);
  return status;
  }
  Future<int> update_exitstock(exitamount,exitdate,remark,id)async{
    var db=await create_db();
    var status=await db.rawUpdate("update stock set exitamount=?,exitdate=?,remark=?,status=? where pid=?",[exitamount,exitdate,remark,"close",id]);
    return status;
  }
}