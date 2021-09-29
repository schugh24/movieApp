import 'package:movie_app/database_manager/database_connector.dart';
import 'package:movie_app/database_manager/stub_database_connector.dart'
    if (dart.library.io) 'package:movie_app/database_manager/sqflite_database_connector.dart'
    if (dart.library.html) 'package:movie_app/database_manager/indexed_database_connector.dart';

class DBObjCreation {
  static DbConnector getDbConnector() {
    return getWfDBConnector();
  }
}
