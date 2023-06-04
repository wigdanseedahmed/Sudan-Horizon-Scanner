import 'package:sudan_horizon_scanner/imports.dart';

List<StateModel> stateModelFromJson(String str) => List<StateModel>.from(json.decode(str).map((x) => StateModel.fromJson(x)));

String stateModelToJson(List<StateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<StateModel> stateModelFromMap(String str) => List<StateModel>.from(json.decode(str).map((x) => StateModel.fromMap(x)));

String stateModelToMap(List<StateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class StateModel {
  StateModel({
    this.stateId,
    this.stateNameEn,
    this.stateNameAr,
    this.statePcode,
    this.stateCapitalNameEn,
    this.stateCapitalNameAr,
    this.stateCapitalPcode,
    this.provinceNameEn,
    this.provinceNameAr,
    this.provincenPcode,
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
  String? provinceNameEn;
  String? provinceNameAr;
  String? provincenPcode;
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
  int? shapeArea;
  double? latitude;
  double? longitude;
  List<List<List<List<double>>>>? coordinates;
  String? mostInterventionType;
  String? leastInterventionType;
  String? noInterventionType;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    stateId: json["StateID"],
    stateNameEn: json["State_Name_EN"],
    stateNameAr: json["State_Name_AR"],
    statePcode: json["State_PCODE"],
    stateCapitalNameEn: json["State_Capital_Name_EN"],
    stateCapitalNameAr: json["State_Capital_Name_AR"],
    stateCapitalPcode: json["State_Capital_PCODE"],
    provinceNameEn: json["Province_Name_EN"],
    provinceNameAr: json["Province_Name_AR"],
    provincenPcode: json["Provincen_PCODE"],
    regionNameEn: json["Region_Name_EN"],
    regionNameAr: json["Region_Name_AR"],
    regionPcode: json["Region_PCODE"],
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
    "Province_Name_EN": provinceNameEn,
    "Province_Name_AR": provinceNameAr,
    "Provincen_PCODE": provincenPcode,
    "Region_Name_EN": regionNameEn,
    "Region_Name_AR": regionNameAr,
    "Region_PCODE": regionPcode,
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

  factory StateModel.fromMap(Map<String, dynamic> json) => StateModel(
    stateId: json["StateID"],
    stateNameEn: json["State_Name_EN"],
    stateNameAr: json["State_Name_AR"],
    statePcode: json["State_PCODE"],
    stateCapitalNameEn: json["State_Capital_Name_EN"],
    stateCapitalNameAr: json["State_Capital_Name_AR"],
    stateCapitalPcode: json["State_Capital_PCODE"],
    provinceNameEn: json["Province_Name_EN"],
    provinceNameAr: json["Province_Name_AR"],
    provincenPcode: json["Provincen_PCODE"],
    regionNameEn: json["Region_Name_EN"],
    regionNameAr: json["Region_Name_AR"],
    regionPcode: json["Region_PCODE"],
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
    "Province_Name_EN": provinceNameEn,
    "Province_Name_AR": provinceNameAr,
    "Provincen_PCODE": provincenPcode,
    "Region_Name_EN": regionNameEn,
    "Region_Name_AR": regionNameAr,
    "Region_PCODE": regionPcode,
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
}
