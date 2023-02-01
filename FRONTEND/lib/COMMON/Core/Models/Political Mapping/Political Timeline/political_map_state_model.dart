import 'package:sudan_horizon_scanner/imports.dart';

List<PoliticalMapStateModel> politicalMapStateModelFromJson(String str) => List<PoliticalMapStateModel>.from(json.decode(str).map((x) => PoliticalMapStateModel.fromJson(x)));

String politicalMapStateModelToJson(List<PoliticalMapStateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<PoliticalMapStateModel> politicalMapStateModelFromMap(String str) => List<PoliticalMapStateModel>.from(json.decode(str).map((x) => PoliticalMapStateModel.fromMap(x)));

String politicalMapStateModelToMap(List<PoliticalMapStateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PoliticalMapStateModel {
  PoliticalMapStateModel({
    this.stateId,
    this.stateNameEn,
    this.stateNameAr,
    this.statePcode,
    this.stateCapitalNameEn,
    this.stateCapitalNameAr,
    this.stateCapitalPcode,
    this.stateRegionNameEn,
    this.stateRegionNameAr,
    this.stateRegionPcode,
    this.countryEn,
    this.countryAr,
    this.countryPcode,
    this.governmentType,
    this.governmentChiefAdministrator,
    this.governmentGovernor,
    this.population,
    this.type,
    this.shapeArea,
    this.latitude,
    this.longitude,
    this.coordinates,
    this.mostInterventionType,
    this.leastInterventionType,
    this.noInterventionType,
  });

  int? stateId;
  String? stateNameEn;
  String? stateNameAr;
  String? statePcode;
  String? stateCapitalNameEn;
  String? stateCapitalNameAr;
  String? stateCapitalPcode;
  String? stateRegionNameEn;
  String? stateRegionNameAr;
  String? stateRegionPcode;
  String? countryEn;
  String? countryAr;
  String? countryPcode;
  String? governmentType;
  String? governmentChiefAdministrator;
  String? governmentGovernor;
  int? population;
  String? type;
  int? shapeArea;
  double? latitude;
  double? longitude;
  List<List<List<List<double>>>>? coordinates;
  String? mostInterventionType;
  String? leastInterventionType;
  String? noInterventionType;

  factory PoliticalMapStateModel.fromMap(Map<String, dynamic> json) => PoliticalMapStateModel(
    stateId: json["StateID"],
    stateNameEn: json["State_Name_EN"],
    stateNameAr: json["State_Name_AR"],
    statePcode: json["State_PCODE"],
    stateCapitalNameEn: json["State_Capital_Name_EN"],
    stateCapitalNameAr: json["State_Capital_Name_AR"],
    stateCapitalPcode: json["State_Capital_PCODE"],
    stateRegionNameEn: json["State_Region_Name_EN"],
    stateRegionNameAr: json["State_Region_Name_AR"],
    stateRegionPcode: json["State_Region_PCODE"],
    countryEn: json["Country_EN"],
    countryAr: json["Country_AR"],
    countryPcode: json["Country_PCODE"],
    governmentType: json["Government_Type"],
    governmentChiefAdministrator: json["Government_Chief_Administrator"],
    governmentGovernor: json["Government_Governor"],
    population: json["population"],
    type: json["Type"],
    shapeArea: json["Shape_Area"],
    latitude: json["Latitude"].toDouble(),
    longitude: json["Longitude"].toDouble(),
    coordinates: List<List<List<List<double>>>>.from(json["Coordinates"].map((x) => List<List<List<double>>>.from(x.map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))))),
    mostInterventionType: json["Most_Intervention_Type"],
    leastInterventionType: json["Least_Intervention_Type"],
    noInterventionType: json["No_Intervention_Type"],
  );

  Map<String, dynamic> toMap() => {
    "StateID": stateId,
    "State_Name_EN": stateNameEn,
    "State_Name_AR": stateNameAr,
    "State_PCODE": statePcode,
    "State_Capital_Name_EN": stateCapitalNameEn,
    "State_Capital_Name_AR": stateCapitalNameAr,
    "State_Capital_PCODE": stateCapitalPcode,
    "State_Region_Name_EN": stateRegionNameEn,
    "State_Region_Name_AR": stateRegionNameAr,
    "State_Region_PCODE": stateRegionPcode,
    "Country_EN": countryEn,
    "Country_AR": countryAr,
    "Country_PCODE": countryPcode,
    "Government_Type": governmentType,
    "Government_Chief_Administrator": governmentChiefAdministrator,
    "Government_Governor": governmentGovernor,
    "population": population,
    "Type": type,
    "Shape_Area": shapeArea,
    "Latitude": latitude,
    "Longitude": longitude,
    "Coordinates": List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))))),
    "Most_Intervention_Type": mostInterventionType,
    "Least_Intervention_Type": leastInterventionType,
    "No_Intervention_Type": noInterventionType,
  };

  factory PoliticalMapStateModel.fromJson(Map<String, dynamic> json) => PoliticalMapStateModel(
    stateId: json["StateID"],
    stateNameEn: json["State_Name_EN"],
    stateNameAr: json["State_Name_AR"],
    statePcode: json["State_PCODE"],
    stateCapitalNameEn: json["State_Capital_Name_EN"],
    stateCapitalNameAr: json["State_Capital_Name_AR"],
    stateCapitalPcode: json["State_Capital_PCODE"],
    stateRegionNameEn: json["State_Region_Name_EN"],
    stateRegionNameAr: json["State_Region_Name_AR"],
    stateRegionPcode: json["State_Region_PCODE"],
    countryEn: json["Country_EN"],
    countryAr: json["Country_AR"],
    countryPcode: json["Country_PCODE"],
    governmentType: json["Government_Type"],
    governmentChiefAdministrator: json["Government_Chief_Administrator"],
    governmentGovernor: json["Government_Governor"],
    population: json["population"],
    type: json["Type"],
    shapeArea: json["Shape_Area"],
    latitude: json["Latitude"].toDouble(),
    longitude: json["Longitude"].toDouble(),
    coordinates: List<List<List<List<double>>>>.from(json["Coordinates"].map((x) => List<List<List<double>>>.from(x.map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))))),
    mostInterventionType: json["Most_Intervention_Type"],
    leastInterventionType: json["Least_Intervention_Type"],
    noInterventionType: json["No_Intervention_Type"],
  );

  Map<String, dynamic> toJson() => {
    "StateID": stateId,
    "State_Name_EN": stateNameEn,
    "State_Name_AR": stateNameAr,
    "State_PCODE": statePcode,
    "State_Capital_Name_EN": stateCapitalNameEn,
    "State_Capital_Name_AR": stateCapitalNameAr,
    "State_Capital_PCODE": stateCapitalPcode,
    "State_Region_Name_EN": stateRegionNameEn,
    "State_Region_Name_AR": stateRegionNameAr,
    "State_Region_PCODE": stateRegionPcode,
    "Country_EN": countryEn,
    "Country_AR": countryAr,
    "Country_PCODE":countryPcode,
    "Government_Type": governmentType,
    "Government_Chief_Administrator": governmentChiefAdministrator,
    "Government_Governor": governmentGovernor,
    "population": population,
    "Type": type,
    "Shape_Area": shapeArea,
    "Latitude": latitude,
    "Longitude": longitude,
    "Coordinates": List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))))),
    "Most_Intervention_Type": mostInterventionType,
    "Least_Intervention_Type": leastInterventionType,
    "No_Intervention_Type": noInterventionType,
  };
}
