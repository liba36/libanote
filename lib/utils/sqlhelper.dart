import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:liba_note/model/diary.dart';
import 'package:liba_note/model/book.dart';

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
        image integer,
        type integer,
        description text,
        createtime text,
        edittime text)''');
    } catch (e) {
      _createRes += "create book table error : " + e.toString();
    }
    //日记内容
    try {
      await db.execute('''
        CREATE TABLE diary (
        id integer primary key autoincrement, 
        title text, 
        context text,
        bookid integer,
        createtime text,
        edittime text)''');
    } catch (e) {
      _createRes += "create diary table error : " + e.toString();
    }
    //图片
    try {
      await db.execute('''
        CREATE TABLE images (
        id integer, 
        image text,
        type integer)''');
      // foreign key(id) references diary(id) on delete cascade on update cascade
    } catch (e) {
      _createRes += "create images table error : " + e.toString();
    }

    //密码本内容
    try {
      await db.execute('''
        CREATE TABLE diary (
        id integer primary key autoincrement, 
        title text, 
        name text,
        password text,
        bookid integer,
        createtime text,
        edittime text)''');
    } catch (e) {
      _createRes += "create account table error : " + e.toString();
    }
  }

  /**
   * diary 表操作
   */
  Future<int> insertDiary(diary di) async {
    Database database = await db;
    var result = database.insert("diary", di.diaryTomap());
    return result;
  }

  Future<List> getDiary(int bookid) async {
    Database database = await db;
    var result =
        await database.query('diary', where: '"bookid"=?', whereArgs: [bookid]);
    return result;
  }

  Future<int> deleteDiary(int id) async {
    Database database = await db;
    var result =
        await database.delete('diary', where: '"id"=?', whereArgs: [id]);
    return result;
  }

  Future<int> updateDiary(diary di) async {
    Database database = await db;
    var result = await database
        .update('diary', di.diaryTomap(), where: '"id"=?', whereArgs: [di.id]);
  }

  /**
   * book 表操作
   */
  Future<int> insertBook(book bo) async {
    Database database = await db;
    var result = database.insert("book", bo.bookTomap());
    return result;
  }

  Future<List> getBook() async {
    Database database = await db;
    var result = await database.rawQuery("select * from book");
    return result;
  }

  /**
   * account 表操作
   */
  Future<bool> insertAccount() {}
}
