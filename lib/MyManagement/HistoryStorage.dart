import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as myDB;

final String dbName = "currencyDB.db";

final String _tableName = 'main_value';

final String columnId = '_id';
final String columnTitle = 'title';
final String columnUrl = "webUrl";
final String columnTime = "time";

class HistoryItem {
  int id;
  String title;
  String url;
  int time;

  Map<String, Object> toMap() {
    var map = <String, Object>{
      columnTitle: title,
      columnUrl: url,
      columnTime: time,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  HistoryItem();

  HistoryItem.fromMap(Map<String, Object> map) {
    id = map[columnId];
    title = map[columnTitle];
    url = map[columnUrl];
    time = map[columnTime];
  }
}

class HistoryStoreProvider {
  myDB.Database db;

  Future<myDB.Database> open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = "${documentsDirectory.path}/$dbName";

    return db = await myDB.openDatabase(dbPath, version: 1,
        onCreate: (myDB.Database db, int version) async {
      await db.execute('''
CREATE TABLE $_tableName ( 
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $columnTitle TEXT NOT NULL,
  $columnUrl TEXT NOT NULL,
  $columnTime INTEGER NOT NULL);
''');
    });
  }

  Future<HistoryItem> insert(HistoryItem mainItem) async {
    mainItem.id = DateTime.now().millisecondsSinceEpoch;
    await db.insert(_tableName, mainItem.toMap());
    return mainItem;
  }

  Future<HistoryItem> getHistoryItem(int id) async {
    List<Map> maps = await db.query(_tableName,
        columns: [
          columnId,
          columnTitle,
          columnUrl,
          columnTime,
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return HistoryItem.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Map>> getAllHistoryItem() async {
    List<Map> maps = await db.query(
      _tableName,
      columns: [
        columnId,
        columnTitle,
        columnUrl,
        columnTime,
      ],
    );
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  Future<HistoryItem> checkValue(String url) async {
    List<Map> maps = await db.query(_tableName,
        columns: [
          columnId,
          columnTitle,
          columnUrl,
          columnTime,
        ],
        where: '$columnUrl = ?',
        whereArgs: [url]);
    if (maps.length > 0) {
      return HistoryItem.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(id) async {
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    return await db.delete(_tableName);
  }

  Future<int> update(HistoryItem todo, String id) async {
    return await db.update(
      _tableName,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future close() async => db.close();
}
