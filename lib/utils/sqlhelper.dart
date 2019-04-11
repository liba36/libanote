import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:liba_note/model/diary.dart';

class sqlhelper {
  //创建数据库结果
  String _createRes = "";
  String _path1 = "";

  String get createres => _createRes;

  String get path1 => _path1;

  Database _database;

  Future get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await openDb();
      return _database;
    }
  }

  //Database _database;
  openDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    //Directory documentDirectory = await getExternalStorageDirectory();
    String path = join(documentDirectory.path, "libanote.db");

    _path1 = path;

    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _database;
  }

  FutureOr _onCreate(Database db, int version) async {

    //小本子列表
    try {
      await db.execute('''
        CREATE TABLE book (
        id integer primary key autoincrement, 
        title text, 
        description text,
        createtime text,
        edittime text)''');
    } catch (e) {
      _createRes = "create diary table error : " + e.toString();
    }

    //日记内容
    try {
      await db.execute('''
        CREATE TABLE diary (
        id_d integer primary key autoincrement, 
        title text, 
        context text,
        createtime text,
        edittime text)''');
    } catch (e) {
      _createRes = "create diary table error : " + e.toString();
    }
    try {
      await db.execute('''
        CREATE TABLE images_d (
        id_d integer, 
        image text,
        foreign key(id_d) references diary(id_d) on delete cascade on update cascade
        )''');
    } catch (e) {
      _createRes += "\n create images table error : " + e.toString();
    }
  }

  Future<int> insertDiaryNote(diary di) async {
    Database database = await db;
    var result = database.insert("diary", di.diaryTomap());
    return result;
  }

  Future<List>  getDiaryNote() async {
    Database database = await db;
    var result = await database
        .rawQuery("select * from diary");//asc
    //print('获取所有diyProject,当前diyProject有: $result');
    return result;
  }
}
