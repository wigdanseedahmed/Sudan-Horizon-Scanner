import 'package:sudan_horizon_scanner/imports.dart';

List<LocalityModel> localityModelFromJson(String str) => List<LocalityModel>.from(json.decode(str).map((x) => LocalityModel.fromJson(x)));

String localityModelToJson(List<LocalityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<LocalityModel> localityModelFromMap(String str) => List<LocalityModel>.from(json.decode(str).map((x) => LocalityModel.fromMap(x)));

String localityModelToMap(List<LocalityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class LocalityModel {
  LocalityModel({
    this.localityId,
    this.localityNameEn,
    this.localityNameAr,
    this.localityNamePcode,
    this.cityNameEn,
    this.cityNameAr,
    this.cityPcode,
    this.stateNameEn,
    this.stateNameAr,
    this.stateNamePcode,
    this.provinceNameEn,
    this.provinceNameAr,
    this.provincePcode,
    this.regionNameEn,
    this.regionNameAr,
    this.regionPcode,
    this.countryEn,
    this.countryAr,
    this.countryPcode,
    this.governmentType,
    this.governmentChiefAdministrator,
    this.governmentGovernor,
    this.population,
    this.type,
    this.shapeLength,
    this.shapeArea,
    this.latitude,
    this.longitude,
    this.coordinates,
    this.mostInterventionType,
    this.leastInterventionType,
    this.noInterventionType,
  });

  int? localityId;
  String? localityNameEn;
  String? localityNameAr;
  String? localityNamePcode;
  String? cityNameEn;
  String? cityNameAr;
  String? cityPcode;
  String? stateNameEn;
  String? stateNameAr;
  String? stateNamePcode;
  String? provinceNameEn;
  String? provinceNameAr;
  String? provincePcode;
  String? regionNameEn;
  String? regionNameAr;
  String? regionPcode;
  String? countryEn;
  String? countryAr;
  String? countryPcode;
  String? governmentType;
  String? governmentChiefAdministrator;
  String? governmentGovernor;
  int? population;
  String? type;
  double? shapeLength;
  double? shapeArea;
  double? latitude;
  double? longitude;
  List<List<List<double>>>? coordinates;
  String? mostInterventionType;
  String? leastInterventionType;
  String? noInterventionType;

  factory LocalityModel.fromMap(Map<String, dynamic> json) => LocalityModel(
    localityId: json["LocalityId"],
    localityNameEn: json["Locality_Name_EN"],
    localityNameAr: json["Locality_Name_AR"],
    localityNamePcode: json["Locality_Name_PCODE"],
    cityNameEn: json["City_Name_EN"],
    cityNameAr: json["City_Name_AR"],
    cityPcode: json["City_PCODE"],
    stateNameEn: json["State_Name_EN"],
    stateNameAr: json["State_Name_AR"],
    stateNamePcode: json["State_Name_PCODE"],
    provinceNameEn: json["Province_Name_EN"],
    provinceNameAr: json["Province_Name_AR"],
    provincePcode: json["Province_PCODE"],
    regionNameEn: json["Region_Name_EN"],
    regionNameAr: json["Region_Name_AR"],
    regionPcode: json["Region_PCODE"],
    countryEn: json["Country_EN"],
    countryAr: json["Country_AR"],
    countryPcode: json["Country_PCODE"],
    governmentType: json["Government_Type"],
    governmentChiefAdministrator: json["Government_Chief_Administrator"],
    governmentGovernor: json["Government_Governor"],
    population: json["Population"],
    type: json["Type"],
    shapeLength: json["Shape_Length"].toDouble(),
    shapeArea: json["Shape_Area"].toDouble(),
    latitude: json["Latitude"].toDouble(),
    longitude: json["Longitude"].toDouble(),
    coordinates: List<List<List<double>>>.from(json["Coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
    mostInterventionType: json["Most_Intervention_Type"],
    leastInterventionType: json["Least_Intervention_Type"],
    noInterventionType: json["No_Intervention_Type"],
  );

  Map<String, dynamic> toMap() => {
    "LocalityId": localityId,
    "Locality_Name_EN": localityNameEn,
    "Locality_Name_AR": localityNameAr,
    "Locality_Name_PCODE": localityNamePcode,
    "City_Name_EN": cityNameEn,
    "City_Name_AR": cityNameAr,
    "City_PCODE": cityPcode,
    "State_Name_EN": stateNameEn,
    "State_Name_AR": stateNameAr,
    "State_Name_PCODE": stateNamePcode,
    "Province_Name_EN": provinceNameEn,
    "Province_Name_AR": provinceNameAr,
    "Province_PCODE": provincePcode,
    "Region_Name_EN": regionNameEn,
    "Region_Name_AR": regionNameAr,
    "Region_PCODE": regionPcode,
    "Country_EN": countryEn,
    "Country_AR": countryAr,
    "Country_PCODE": countryPcode,
    "Government_Type": governmentType,
    "Government_Chief_Administrator": governmentChiefAdministrator,
    "Government_Governor": governmentGovernor,
    "Population": population,
    "Type": type,
    "Shape_Length": shapeLength,
    "Shape_Area": shapeArea,
    "Latitude": latitude,
    "Longitude": longitude,
    "Coordinates": List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
    "Most_Intervention_Type": mostInterventionType,
    "Least_Intervention_Type": leastInterventionType,
    "No_Intervention_Type": noInterventionType,
  };
  
  factory LocalityModel.fromJson(Map<String, dynamic> json) => LocalityModel(
    localityId: json["LocalityId"],
    localityNameEn: json["Locality_Name_EN"],
    localityNameAr: json["Locality_Name_AR"],
    localityNamePcode: json["Locality_Name_PCODE"],
    cityNameEn: json["City_Name_EN"],
    cityNameAr: json["City_Name_AR"],
    cityPcode: json["City_PCODE"],
    stateNameEn: json["State_Name_EN"],
    stateNameAr: json["State_Name_AR"],
    stateNamePcode: json["State_Name_PCODE"],
    provinceNameEn: json["Province_Name_EN"],
    provinceNameAr: json["Province_Name_AR"],
    provincePcode: json["Province_PCODE"],
    regionNameEn: json["Region_Name_EN"],
    regionNameAr: json["Region_Name_AR"],
    regionPcode: json["Region_PCODE"],
    countryEn: json["Country_EN"],
    countryAr: json["Country_AR"],
    countryPcode: json["Country_PCODE"],
    governmentType: json["Government_Type"],
    governmentChiefAdministrator: json["Government_Chief_Administrator"],
    governmentGovernor: json["Government_Governor"],
    population: json["Population"],
    type: json["Type"],
    shapeLength: json["Shape_Length"].toDouble(),
    shapeArea: json["Shape_Area"].toDouble(),
    latitude: json["Latitude"].toDouble(),
    longitude: json["Longitude"].toDouble(),
    coordinates: List<List<List<double>>>.from(json["Coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
    mostInterventionType: json["Most_Intervention_Type"],
    leastInterventionType: json["Least_Intervention_Type"],
    noInterventionType: json["No_Intervention_Type"],
  );

  Map<String, dynamic> toJson() => {
    "LocalityId": localityId,
    "Locality_Name_EN": localityNameEn,
    "Locality_Name_AR": localityNameAr,
    "Locality_Name_PCODE": localityNamePcode,
    "City_Name_EN": cityNameEn,
    "City_Name_AR": cityNameAr,
    "City_PCODE": cityPcode,
    "State_Name_EN": stateNameEn,
    "State_Name_AR": stateNameAr,
    "State_Name_PCODE": stateNamePcode,
    "Province_Name_EN": provinceNameEn,
    "Province_Name_AR": provinceNameAr,
    "Province_PCODE": provincePcode,
    "Region_Name_EN": regionNameEn,
    "Region_Name_AR": regionNameAr,
    "Region_PCODE": regionPcode,
    "Country_EN": countryEn,
    "Country_AR": countryAr,
    "Country_PCODE": countryPcode,
    "Government_Type": governmentType,
    "Government_Chief_Administrator": governmentChiefAdministrator,
    "Government_Governor": governmentGovernor,
    "Population": population,
    "Type": type,
    "Shape_Length": shapeLength,
    "Shape_Area": shapeArea,
    "Latitude": latitude,
    "Longitude": longitude,
    "Coordinates": List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
    "Most_Intervention_Type": mostInterventionType,
    "Least_Intervention_Type": leastInterventionType,
    "No_Intervention_Type": noInterventionType,
  };
}