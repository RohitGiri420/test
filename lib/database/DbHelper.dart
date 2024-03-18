import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:untitled1/model/NoteModel.dart';

class DbHelper {
  static String TableName = "NoteTable";
  static String NoteId = "NoteId";
  static String NoteTitle = "Title";
  static String NoteDecs = "Description";

  Database? _database;

  Future<Database> getDb() async {
    if (_database != null) {
      return _database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "Notesdb");
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "Create Table $TableName($NoteId integer primary key autoincrement,$NoteTitle text,$NoteDecs text)");
      },
    );

    return _database!;
  }

  Future<bool> AddData(NoteModel noteModel) async {
    var db = await getDb();
    var count = await db.insert(TableName, noteModel.ToMap());
    return count > 0;
  }

  Future<List<NoteModel>> FetchData() async {
    var db = await getDb();
    List<NoteModel> list = [];

    var data = await db.query(TableName);

    for (Map<String, dynamic> eachdata in data) {
      NoteModel noteModel = NoteModel.fromMap(eachdata);
      list.add(noteModel);
    }
    return list;
  }

  Future<bool> UpdateData(NoteModel noteModel) async {
    var db = await getDb();
    var check = await db.update(TableName, noteModel.ToMap(),
        where: "$NoteId = ${noteModel.id}");

    return check > 0;
  }

  Future<bool> DeleteDat(int id) async {
    var db = await getDb();
    var check = await db.delete(TableName, where: "$NoteId=?", whereArgs: [id.toString()]);
    return check >0;

  }
}
