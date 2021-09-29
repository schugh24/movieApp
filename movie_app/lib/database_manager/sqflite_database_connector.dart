import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:movie_app/database_manager/database_connector.dart';

import 'sqlite_tables.dart';

DbConnector getWfDBConnector() => SqfliteDbConnector();

class SqfliteDbConnector implements DbConnector {
  static const databaseName = "movies.db";
  static const version = 3;

  static SqfliteDbConnector _instance;

  SqfliteDbConnector._getInstance();

  /// return SqfliteDatabaseConnector singleton object.
  factory SqfliteDbConnector() {
    if (_instance == null) {
      _instance = SqfliteDbConnector._getInstance();
    }
    return _instance;
  }

  /// open database connection with the database file to work upon this.
  Future<Database> openDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);
    final Future<Database> database = openDatabase(
      // constructed for each platform.
      path,
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        db.execute(MovieTable.createTableQuery);
      },
      version: version,
    );
    return database;
  }

  Future<bool> insertRecord(
      String documentName, Map<String, dynamic> record) async {
    final database = await openDb();
    int recordId = await database.insert(documentName, record,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("inserted RecordId : $recordId");
    return recordId > 0;
  }

  insertRecords(String documentName, List<Map<String, dynamic>> records) async {
    final database = await openDb();
    var batch = database.batch();
    for (var record in records) {
      database.insert(documentName, record,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    var results = await batch.commit(continueOnError: true);
    return results?.isNotEmpty ?? false;
  }
}
