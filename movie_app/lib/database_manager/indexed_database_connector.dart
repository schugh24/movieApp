import 'package:idb_shim/idb_browser.dart';
import 'package:idb_shim/idb_shim.dart';
import 'package:movie_app/database_manager/database_connector.dart';
import 'package:movie_app/database_manager/sqflite_database_connector.dart'
    as dbConnect;
import 'package:movie_app/database_manager/sqlite_tables.dart';

DbConnector getWfDBConnector() => IndexedDbConnector();

class IndexedDbConnector implements DbConnector {
  IndexedDbConnector._internal();

  Map<String, String> tableNamePrimaryKey = {
    MovieTable.tableName: MovieTable.movieName
  };

  static IndexedDbConnector _instance = IndexedDbConnector._internal();

  factory IndexedDbConnector() => _instance;

  /// open database connection with the database file to work upon this.
  Future<Database> openDb() async {
    IdbFactory idbFactory = getIdbFactory();
    return idbFactory.open(dbConnect.SqfliteDbConnector.databaseName,
        version: dbConnect.SqfliteDbConnector.version,
        onUpgradeNeeded: _onUpgrade);
  }

  void _onUpgrade(VersionChangeEvent event) {
    Database db = event.database;

    db.createObjectStore(MovieTable.tableName, autoIncrement: true);
  }

  @override
  Future<bool> insertRecord(
      String documentName, Map<String, dynamic> record) async {
    Database db = await openDb();
    var txn = db.transaction(documentName, idbModeReadWrite);
    var store = txn.objectStore(documentName);
    var key =
        await store.put(record, record[tableNamePrimaryKey[documentName]]);
    await txn.completed;
    return key != null;
  }

  @override
  insertRecords(String documentName, List<Map<String, dynamic>> records) async {
    Database db = await openDb();
    var txn = db.transaction(documentName, idbModeReadWrite);
    var store = txn.objectStore(documentName);
    for (var record in records) {
      await store.put(record, record[tableNamePrimaryKey[documentName]]);
    }
    await txn.completed;
  }
}
