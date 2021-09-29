
///To persist data in Local storage, [DatabaseConnection] define some contranct 
///to save and fetch records from it.
abstract class DbConnector {

/// insert record in particular collection, [collectionName] name of the collection
/// [record] is the single document need to be inserted in collection.
  Future<bool> insertRecord(String collectionName, Map<String, dynamic> record);
/// For inserting multiple records in batch
/// [collectionName] -Name of collection
/// [records]- records to be inserted.
  insertRecords(String collectionName, List<Map<String, dynamic>> records);



}
