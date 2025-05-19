import 'package:mini_game/storage/db_storage/dao/merit_record_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbStorage {
  DbStorage._();

  static DbStorage? _dbStorage;

  static DbStorage get instance {
    _dbStorage = _dbStorage ?? DbStorage._();
    return _dbStorage!;
  }

  late Database _db;

  late MeritRecordDao _meritRecordDao;

  MeritRecordDao get meritRecordDao => _meritRecordDao;

  // 开启数据库
  Future<void> open() async {
    String databasePath = await getDatabasesPath();
    // 暂定数据库名称
    String dbPath = context.join(databasePath, 'first_station.db');
    _db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    _meritRecordDao = MeritRecordDao(_db);
  }

  //创建数据库
  Future<void> _onCreate(Database db, int version) async {
    await MeritRecordDao.createTable(db);
  }
}
