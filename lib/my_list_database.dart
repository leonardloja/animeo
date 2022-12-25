import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'models/my_list.dart';


class MyListDatabase {
  MyListDatabase._privateConstructor();

  static final MyListDatabase instance =
      MyListDatabase._privateConstructor();
  static Database? _database;

  final String tableMyList = 'MyList';
  final String idCol = 'id';
  final String nameCol = 'name';
  final String imageUrlCol = 'imageUrl';
  final String releasedDateCol = 'releasedDate';
  final dbName = 'animeo.db';
  final idType = 'TEXT NOT NULL';
  final textType = 'TEXT NOT NULL';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, dbName);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, version) async {
    await db.execute('''
    CREATE TABLE $tableMyList(
      $idCol $idType, $nameCol $textType, $imageUrlCol $textType, $releasedDateCol $textType)''');
  }

  Future<void> insert(MyList myList) async {
    final db = await instance.database;
    final result = await db.insert(tableMyList, myList.toJson());
    if (result != -1) {
      print('success');
    }
  }

  Future<List<MyList>>? getAllMyLists() async {
    final db = await instance.database;
    final results = await db.query(tableMyList);
    return results.map((json) => MyList.fromJson(json)).toList();
  }

  Future<int> delete(String id) async {
    final db = await instance.database;
    return db.delete(
      tableMyList,
      where: '$idCol == ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
  }
}
