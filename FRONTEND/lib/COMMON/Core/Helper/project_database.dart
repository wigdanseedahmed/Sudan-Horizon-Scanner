import 'package:mongo_dart/mongo_dart.dart';
import 'package:sudan_horizon_scanner/imports.dart';

class MongoProjectDatabase {
  static late var db, projectCollection;

  static int port = 27017;

  static connect() async {
    var db = Db(
        'mongodb://localhost:27017/sudan_horizon_scanner'); //await Db.create('mongodb://localhost:27017/sudan_horizon_scanner');
    await db.open();
    print('Connected');
    var projectCollection = db.collection('project_data');

    return projectCollection;
  }

  ///GET PROJECT
  static Future<List<Map<String, dynamic>>?> getDocuments() async {
    var server = await HttpServer.bind('localhost', port);
    var db = Db(
        'mongodb://localhost:27017/sudan_horizon_scanner'); //await Db.create('mongodb://localhost:27017/sudan_horizon_scanner');
    await db.open();
    print('Connected');
    var projectCollection = db.collection('project_data');
    server.listen((HttpRequest request) async {
      if (request.uri.path == '/') {
        return request.response.write('object');
      } else if (request.uri.path == '/sudan_horizon_scanner') {
         return request.response.write(await projectCollection.find().toList());
      }
      return request.response.close();
    });
    /*try {
      final projects = await projectCollection.find().toList();
      if (kDebugMode) {
        print(projects);
      }
      return projects;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }*/
    }

  ///CREATE PROJECT
  static create(InterventionsProjectModel project) async {
    var p = await projectCollection.save({"id": project.id});
    p["projectName"] = project.projectName;
    p["projectDetail"] = project.projectDetail;
    p["startDate"] = project.startDate;
    await projectCollection.save(p);
  }

  ///INSERT PROJECT
  static insert(InterventionsProjectModel project) async {
    await projectCollection.insertAll([project.toMap()]);
  }

  ///UPDATE PROJECT
  static update(InterventionsProjectModel project) async {
    var p = await projectCollection.findOne({"id": project.id});
    p["projectName"] = project.projectName;
    p["projectDetail"] = project.projectDetail;
    p["startDate"] = project.startDate;
    await projectCollection.save(p);
  }

  ///DELETE PROJECT
  static delete(InterventionsProjectModel project) async {
    await projectCollection
        .remove(await projectCollection.findOne(where.eq('id', project.id)));
  }
}
