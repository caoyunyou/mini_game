import 'package:sqflite/sqflite.dart';

class DbUtils {
  final Database database;

  DbUtils(this.database);

  // 插入数据
  Future<int> insert<T>(
    String tableName,
    Map<String, dynamic> Function() toJson,
  ) {
    return database.insert(
      tableName,
      toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 分页查询：无参数
  Future<List<T>> queryByPage<T>({
    required String tableName,
    required int pageNumber,
    required int pageSize,
    required T Function(Map<String, dynamic>) fromJson,
    String? orderBy,
  }) async {
    final offset = (pageNumber - 1) * pageSize;
    List<Map<String, Object?>> data = await database.query(
      tableName,
      orderBy: orderBy ?? 'id asc',
      limit: pageSize,
      offset: offset,
    );
    return data.map((e) => fromJson(e)).toList();
  }

  /// 分页查询：无参数
  Future<List<T>> queryByPageByParams<T>({
    required String tableName,
    required int pageNumber,
    required int pageSize,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParams,
    String? orderBy,
  }) async {
    if (null != queryParams && queryParams.isNotEmpty) {
      WhereParam whereParam = _analyticWhereParams(queryParams);

      final offset = (pageNumber - 1) * pageSize;
      List<Map<String, Object?>> data = await database.query(
        tableName,
        orderBy: orderBy ?? 'id asc',
        limit: pageSize,
        offset: offset,
        where: whereParam.whereStr,
        whereArgs: whereParam.whereArgs,
      );
      return data.map((e) => fromJson(e)).toList();
    } else {
      // 没有的话，直接走默认方法
      return queryByPage(
        tableName: tableName,
        pageNumber: pageNumber,
        pageSize: pageSize,
        fromJson: fromJson,
        orderBy: orderBy,
      );
    }
  }

  /// 查询：无参数
  Future<List<T>> query<T>(
    String tableName,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    List<Map<String, Object?>> data = await database.query(tableName);
    return data.map((e) => fromJson(e)).toList();
  }

  /// 查询，带参数
  Future<List<T>> queryByParams<T>({
    required String tableName,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParams,
  }) async {
    // 如果有参数，则进行参数解析
    if (null != queryParams && queryParams.isNotEmpty) {
      List<Map<String, Object?>> queryData;
      // 解析对应的条件信息
      WhereParam whereParam = _analyticWhereParams(queryParams);

      queryData = await database.query(
        tableName,
        whereArgs: whereParam.whereArgs,
        where: whereParam.whereStr,
      );
      return queryData.map((e) => fromJson(e)).toList();
    } else {
      return query(tableName, fromJson);
    }
  }

  /// 条件信息解析
  WhereParam _analyticWhereParams(Map<String, dynamic> queryParams) {
    // // 条件拼接
    String whereStr = queryParams.keys.join(" = ?,");
    whereStr += " = ?";

    // 条件对应的属性拼接
    List whereArg = queryParams.values.toList();

    return WhereParam(whereStr: whereStr, whereArgs: whereArg);
  }
}

class WhereParam {
  final String whereStr;
  final List whereArgs;

  const WhereParam({required this.whereStr, required this.whereArgs});
}
