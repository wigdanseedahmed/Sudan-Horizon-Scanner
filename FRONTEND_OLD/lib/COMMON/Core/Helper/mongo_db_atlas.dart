import 'package:sudan_horizon_scanner/imports.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

class AtlasDBConnection {

  static late AtlasDBConnection _instance;

  final String _getConnectionString = "MONGODB_ATLAS_URI";

  late Db _db;

  static getInstance(){
    if(_instance == null) {
      _instance = AtlasDBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async{
    if (_db == null){
      try {
        _db = Db.create(_getConnectionString) as Db;
        await _db.open();
      } catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
    }
    return _db;
  }

  closeConnection() {
    _db.close();
  }
}