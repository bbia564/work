import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_summary/db_work/work_entity.dart';

class DBWork extends GetxService {
  late Database dbBase;

  Future<DBWork> init() async {
    await createWorkDB();
    return this;
  }

  createWorkDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'work.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createWorkTable(db);
    });
  }

  createWorkTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS work (id INTEGER PRIMARY KEY, createdTime TEXT, type INTEGER, title TEXT, content TEXT, scheduleTime TEXT)');
  }

  deleteWorkData(int id) async {
    await dbBase.delete('work', where: 'id = ?', whereArgs: [id]);
  }

  cleanAllWorksData() async {
    await dbBase.delete('work');
  }

  Future<List<WorkEntity>> getWorksData() async {
    var result = await dbBase.query('work', orderBy: 'createdTime DESC');
    return result.map((e) => WorkEntity.fromJson(e)).toList();
  }
}
