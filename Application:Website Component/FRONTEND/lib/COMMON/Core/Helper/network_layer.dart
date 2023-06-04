import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;


Future<List<InterventionsProjectModel>> fetchProjects(
    List<InterventionsProjectModel> readJsonFileContent) async {
  final response = await http.get(
    Uri.parse(AppUrl.projects),
    headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    },
  );
  if (response.statusCode == 200) {
    readJsonFileContent = interventionsProjectModelFromJson(response.body);
    return readJsonFileContent;
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}


/////////////////////////////////////////////////////////////////////////////

/// READ STATES INTERVENTION MAP
Future<List<StateModel>> readStatesInterventionMapDataFromJsonFile(
    {required List<StateModel> readJsonFileContent}) async {
  /// Read Local Json File Directly
  /*String jsonString = await DefaultAssetBundle.of(context)
        .loadString('jsonDataFiles/interventions/interventions_locality_map.json');
    //print(jsonString);*/

  /// String to URI, using the same url used in the nodejs code
  var uri = Uri.parse(AppUrl.states);

  /// Create Request to get data and response to read data
  final response = await http.get(
    uri,
    headers: {
      //"Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
      "Content-Type, Access-Control-Allow-Origin, Accept",
      "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
    },
  );
  //print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body}');
  if (response.statusCode == 200) {
      readJsonFileContent = stateModelFromJson(response.body);

    //print(readJsonFileContent.length);
    return readJsonFileContent;
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

/// READ STATES INTERVENTION MAP
Future<List<StateModel>> readLocalitiesInterventionMapDataFromJsonFile(List<StateModel> readJsonFileContent) async {
  /// Read Local Json File Directly
  /*String jsonString = await DefaultAssetBundle.of(context)
        .loadString('jsonDataFiles/interventions/interventions_locality_map.json');
    //print(jsonString);*/

  /// String to URI, using the same url used in the nodejs code
  var uri = Uri.parse(AppUrl.localities);

  /// Create Request to get data and response to read data
  final response = await http.get(
    uri,
    headers: {
      //"Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
      "Content-Type, Access-Control-Allow-Origin, Accept",
      "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
    },
  );
  //print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body}');
  if (response.statusCode == 200) {
    readJsonFileContent = stateModelFromJson(response.body);

    //print(readJsonFileContent.length);
    return readJsonFileContent;
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}