import 'package:mini_game/muyu/models/merit_record.dart';
import 'package:mini_game/utils/db_utils.dart';
import 'package:sqflite/sqflite.dart';

class MeritRecordDao {
  late DbUtils _dbUtils;

  MeritRecordDao(Database database) {
    _dbUtils = DbUtils(database);
  }

  static String tableName = "merit_record";
  static String tableSql = """
  CREATE TABLE $tableName (
  id VARCHAR(64) PRIMARY KEY,
  value INTEGER, 
  muyuImage TEXT,
  muyuName TEXT,
  meritType TEXT,
  audio TEXT,
  timestamp INTEGER
)""";

  //创建数据库
  static Future<void> createTable(Database db) {
    return db.execute(tableSql);
  }

  Future<int> insert(MeritRecord record) {
    return _dbUtils.insert(tableName, record.toJson);
  }

  // 分页查询
  Future<List<MeritRecord>> queryByPage(int pageNumber, int pageSize) async {
    return _dbUtils.queryByPage(
      tableName: tableName,
      pageNumber: pageNumber,
      pageSize: pageSize,
      fromJson: MeritRecord.fromJson,
    );
  }

  // 通过参数查询分页数据
  Future<List<MeritRecord>> queryByPageByParams(
    int pageNumber,
    int pageSize,
    Map<String, dynamic>? queryParams,
  ) async {
    return _dbUtils.queryByPageByParams(
      tableName: tableName,
      pageNumber: pageNumber,
      pageSize: pageSize,
      fromJson: MeritRecord.fromJson,
      queryParams: queryParams,
    );
  }

  Future<List<MeritRecord>> query() async {
    return await _dbUtils.query(tableName, MeritRecord.fromJson);
  }

  /// 查询
  Future<List<MeritRecord>> queryByParams({
    Map<String, dynamic>? queryParams,
  }) async {
    return await _dbUtils.queryByParams(
      tableName: tableName,
      fromJson: MeritRecord.fromJson,
      queryParams: queryParams,
    );
  }
}
