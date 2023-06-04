import 'package:sudan_horizon_scanner/imports.dart';

class InterventionsExecutingAgencyModel {
  InterventionsExecutingAgencyModel({
    this.executingAgencyName,
    this.executingAgencyDepartment,
    this.executingAgencyTeam,
    this.executingAgencyEmail,
    this.executingAgencyWebsite,
    this.executingAgencyPhotoUrl,
    this.executingAgencyProjectList,
  });

  String? executingAgencyName;
  String? executingAgencyDepartment;
  String? executingAgencyTeam;
  String? executingAgencyEmail;
  String? executingAgencyWebsite;
  String? executingAgencyPhotoUrl;
  List<String>? executingAgencyProjectList;

  factory InterventionsExecutingAgencyModel.fromJson(Map<String, dynamic> json) => InterventionsExecutingAgencyModel(
    executingAgencyName: json["executingAgencyName"],
    executingAgencyDepartment: json["executingAgencyDepartment"],
    executingAgencyTeam: json["executingAgencyTeam"],
    executingAgencyEmail: json["executingAgencyEmail"],
    executingAgencyWebsite: json["executingAgencyWebsite"],
    executingAgencyPhotoUrl: json["executingAgencyPhotoUrl"],
    executingAgencyProjectList: json["executingAgencyProjectList"] == null ? null : List<String>.from(json["executingAgencyProjectList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "executingAgencyName": executingAgencyName,
    "executingAgencyDepartment": executingAgencyDepartment,
    "executingAgencyTeam": executingAgencyTeam,
    "executingAgencyEmail": executingAgencyEmail,
    "executingAgencyWebsite": executingAgencyWebsite,
    "executingAgencyPhotoUrl": executingAgencyPhotoUrl,
    "executingAgencyProjectList": executingAgencyProjectList == null ? null : List<dynamic>.from(executingAgencyProjectList!.map((x) => x)),
  };

  factory InterventionsExecutingAgencyModel.fromMap(Map<String, dynamic> json) => InterventionsExecutingAgencyModel(
    executingAgencyName: json["executingAgencyName"],
    executingAgencyDepartment: json["executingAgencyDepartment"],
    executingAgencyTeam: json["executingAgencyTeam"],
    executingAgencyEmail: json["executingAgencyEmail"],
    executingAgencyWebsite: json["executingAgencyWebsite"],
    executingAgencyPhotoUrl: json["executingAgencyPhotoUrl"],
    executingAgencyProjectList: json["executingAgencyProjectList"] == null ? null : List<String>.from(json["executingAgencyProjectList"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "executingAgencyName": executingAgencyName,
    "executingAgencyDepartment": executingAgencyDepartment,
    "executingAgencyTeam": executingAgencyTeam,
    "executingAgencyEmail": executingAgencyEmail,
    "executingAgencyWebsite": executingAgencyWebsite,
    "executingAgencyPhotoUrl": executingAgencyPhotoUrl,
    "executingAgencyProjectList": executingAgencyProjectList == null ? null : List<dynamic>.from(executingAgencyProjectList!.map((x) => x)),
  };
}