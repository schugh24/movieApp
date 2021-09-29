import 'dart:convert';
import 'package:movie_app/str_constants.dart';

import 'database_manager/database_connector.dart';
import 'database_manager/sqlite_tables.dart';
import 'database_object_creation.dart';

DbConnector dbConnector = DBObjCreation.getDbConnector();

class DbOperations {
  static insertMovieRecords(Map<String, dynamic> map) async {
    var transformedMap = getInsertObj(map);
    await dbConnector.insertRecord(MovieTable.tableName, transformedMap);
  }

  static Map<String, dynamic> getInsertObj(Map<String, dynamic> obj) {
    var newMap = <String, dynamic>{};
    newMap[kMovieName] = obj[kMovieName];
    newMap[kDirectorName] = obj[kDirectorName];
    newMap[kMovieUrl] = obj[kMovieUrl];
    newMap[kTimeStamp] = obj[kTimeStamp];
    newMap[kConfig] = jsonEncode(obj);
    return newMap;
  }
}
