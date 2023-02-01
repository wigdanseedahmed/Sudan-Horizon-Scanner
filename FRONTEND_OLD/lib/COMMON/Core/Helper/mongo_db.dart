import 'package:sudan_horizon_scanner/imports.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

class DBConnection {

  static late DBConnection _instance;

  final String _host = "localhost";
  final String _port = "27017";
  final String _dbName = "sudan_horizon_scanner";
  late Db _db;

  static getInstance(){
    _instance ??= DBConnection();
    return _instance;
  }

  Future<Db> getConnection() async{
    if (_db == null){
      try {
        _db = Db(_getConnectionString());
        await _db.open();
      } catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
    }
    return _db;
  }

  _getConnectionString(){
    return "mongodb://$_host:$_port/$_dbName";
  }

  closeConnection() {
    _db.close();
  }

}