import 'package:mongo_dart/mongo_dart.dart';
import 'package:sudan_horizon_scanner/imports.dart';

List<InterventionsProjectModel> interventionsProjectModelFromJson(String str) => List<InterventionsProjectModel>.from(json.decode(str).map((x) => InterventionsProjectModel.fromJson(x)));

String interventionsProjectModelToJson(List<InterventionsProjectModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InterventionsProjectModel {
  InterventionsProjectModel({
    this.id,
    this.projectNo,
    this.projectName,
    this.projectDetail,
    this.photoUrl,
    this.executingAgency,
    this.status,
    this.theme,
    this.estimatedCost,
    this.budget,
    this.totalDonatedAmount,
    this.startDate,
    this.endDate,
    this.latitude,
    this.longitude,
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
    this.donor,
    this.contribution,
    this.dataReliability,
  });

  String? id;
  int? projectNo;
  String? projectName;
  String? projectDetail;
  String? photoUrl;
  List<InterventionsExecutingAgencyModel>? executingAgency;
  String? status;
  List<String>? theme;
  int? estimatedCost;
  int? budget;
  int? totalDonatedAmount;
  DateTime? startDate;
  DateTime? endDate;
  double? latitude;
  double? longitude;
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
  List<InterventionsDonorModel>? donor;
  String? contribution;
  String? dataReliability;

  factory InterventionsProjectModel.fromJson(Map<String, dynamic> json) => InterventionsProjectModel(
    id: json["id"],
    projectNo: json["projectNo"],
    projectName: json["projectName"],
    projectDetail: json["projectDetail"],
    photoUrl: json["photoURL"],
    executingAgency: List<InterventionsExecutingAgencyModel>.from(json["executingAgency"].map((x) => InterventionsExecutingAgencyModel.fromJson(x))),
    status: json["status"],
    theme: List<String>.from(json["theme"].map((x) => x)),
    estimatedCost: json["estimatedCost"],
    budget: json["budget"],
    totalDonatedAmount: json["totalDonatedAmount"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    latitude: json["Latitude"].toDouble(),
    longitude: json["Longitude"].toDouble(),
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
    donor: List<InterventionsDonorModel>.from(json["donor"].map((x) => InterventionsDonorModel.fromJson(x))),
    contribution: json["contribution"],
    dataReliability: json["dataReliability"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "projectNo": projectNo,
    "projectName": projectName,
    "projectDetail": projectDetail,
    "photoURL": photoUrl,
    "executingAgency": List<dynamic>.from(executingAgency!.map((x) => x.toJson())),
    "status": status,
    "theme": List<dynamic>.from(theme!.map((x) => x)),
    "estimatedCost": estimatedCost,
    "budget": budget,
    "totalDonatedAmount": totalDonatedAmount,
    "startDate": startDate!.toIso8601String(),
    "endDate": endDate!.toIso8601String(),
    "Latitude": latitude,
    "Longitude": longitude,
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
    "donor": List<dynamic>.from(donor!.map((x) => x.toJson())),
    "contribution": contribution,
    "dataReliability": dataReliability,
  };

  factory InterventionsProjectModel.fromMap(Map<String, dynamic> json) => InterventionsProjectModel(
    id: json["id"],
    projectNo: json["projectNo"],
    projectName: json["projectName"],
    projectDetail: json["projectDetail"],
    photoUrl: json["photoURL"],
    executingAgency: List<InterventionsExecutingAgencyModel>.from(json["executingAgency"].map((x) => InterventionsExecutingAgencyModel.fromMap(x))),
    status: json["status"],
    theme: List<String>.from(json["theme"].map((x) => x)),
    estimatedCost: json["estimatedCost"],
    budget: json["budget"],
    totalDonatedAmount: json["totalDonatedAmount"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    latitude: json["Latitude"].toDouble(),
    longitude: json["Longitude"].toDouble(),
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
    donor: List<InterventionsDonorModel>.from(json["donor"].map((x) => InterventionsDonorModel.fromMap(x))),
    contribution: json["contribution"],
    dataReliability: json["dataReliability"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "projectNo": projectNo,
    "projectName": projectName,
    "projectDetail": projectDetail,
    "photoURL": photoUrl,
    "executingAgency": List<dynamic>.from(executingAgency!.map((x) => x.toMap())),
    "status": status,
    "theme": List<dynamic>.from(theme!.map((x) => x)),
    "estimatedCost": estimatedCost,
    "budget": budget,
    "totalDonatedAmount": totalDonatedAmount,
    "startDate": startDate!.toIso8601String(),
    "endDate": endDate!.toIso8601String(),
    "Latitude": latitude,
    "Longitude": longitude,
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
    "donor": List<dynamic>.from(donor!.map((x) => x.toMap())),
    "contribution": contribution,
    "dataReliability": dataReliability,
  };
}