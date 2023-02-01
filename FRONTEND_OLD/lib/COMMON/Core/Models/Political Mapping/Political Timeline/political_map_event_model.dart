import 'package:sudan_horizon_scanner/imports.dart';

List<PoliticalMappingEventModel> politicalMappingEventModelFromJson(String str) => List<PoliticalMappingEventModel>.from(json.decode(str).map((x) => PoliticalMappingEventModel.fromJson(x)));

String politicalMappingEventModelToJson(List<PoliticalMappingEventModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoliticalMappingEventModel {
  PoliticalMappingEventModel({
    this.eventId,
    this.eventNameEn,
    this.eventNameAr,
    this.photoUrl,
    this.eventDetailEn,
    this.eventDetailAr,
    this.startDate,
    this.endDate,
    this.localityNameEn,
    this.localityNameAr,
    this.localityNamePcode,
    this.stateNameEn,
    this.stateNameAr,
    this.stateNamePcode,
    this.countryEn,
    this.countryAr,
    this.countryPcode,
    this.peopleInvolvedEn,
    this.peopleInvolvedAr,
    this.partyGroupInvolvedEn,
    this.partyGroupInvolvedAr,
    this.peopleAffectedPositivelyEn,
    this.peopleAffectedPositivelyAr,
    this.partyGroupAffectedPositivelyEn,
    this.partyGroupAffectedPositivelyAr,
    this.peopleAffectedNegativelyEn,
    this.peopleAffectedNegativelyAr,
    this.partyGroupAffectedNegativelyEn,
    this.partyGroupAffectedNegativelyAr,
    this.dataReliability,
  });

  String? eventId;
  String? eventNameEn;
  String? eventNameAr;
  String? photoUrl;
  PoliticalMappingEventDetailModel? eventDetailEn;
  PoliticalMappingEventDetailModel? eventDetailAr;
  String? startDate;
  String? endDate;
  String? localityNameEn;
  String? localityNameAr;
  String? localityNamePcode;
  String? stateNameEn;
  String? stateNameAr;
  String? stateNamePcode;
  String? countryEn;
  String? countryAr;
  String? countryPcode;
  List<String>? peopleInvolvedEn;
  List<String>? peopleInvolvedAr;
  List<String>? partyGroupInvolvedEn;
  List<String>? partyGroupInvolvedAr;
  List<String>? peopleAffectedPositivelyEn;
  List<String>? peopleAffectedPositivelyAr;
  List<String>? partyGroupAffectedPositivelyEn;
  List<String>? partyGroupAffectedPositivelyAr;
  List<String>? peopleAffectedNegativelyEn;
  List<String>? peopleAffectedNegativelyAr;
  List<String>? partyGroupAffectedNegativelyEn;
  List<String>? partyGroupAffectedNegativelyAr;
  String? dataReliability;

  factory PoliticalMappingEventModel.fromJson(Map<String, dynamic> json) => PoliticalMappingEventModel(
    eventId: json["eventID"] == null ? null : json["eventID"],
    eventNameEn: json["eventNameEN"] == null ? null : json["eventNameEN"],
    eventNameAr: json["eventNameAR"] == null ? null : json["eventNameAR"],
    photoUrl: json["photoURL"] == null ? null : json["photoURL"],
    eventDetailEn: json["eventDetailEN"] == null ? null : PoliticalMappingEventDetailModel.fromJson(json["eventDetailEN"]),
    eventDetailAr: json["eventDetailAR"] == null ? null : PoliticalMappingEventDetailModel.fromJson(json["eventDetailAR"]),
    startDate: json["startDate"] == null ? null : json["startDate"],
    endDate: json["endDate"] == null ? null : json["endDate"],
    localityNameEn: json["Locality_Name_EN"] == null ? null : json["Locality_Name_EN"],
    localityNameAr: json["Locality_Name_AR"] == null ? null : json["Locality_Name_AR"],
    localityNamePcode: json["Locality_Name_PCODE"] == null ? null : json["Locality_Name_PCODE"],
    stateNameEn: json["State_Name_EN"] == null ? null : json["State_Name_EN"],
    stateNameAr: json["State_Name_AR"] == null ? null : json["State_Name_AR"],
    stateNamePcode: json["State_Name_PCODE"] == null ? null : json["State_Name_PCODE"],
    countryEn: json["Country_EN"] == null ? null : json["Country_EN"],
    countryAr: json["Country_AR"] == null ? null : json["Country_AR"],
    countryPcode: json["Country_PCODE"] == null ? null : json["Country_PCODE"],
    peopleInvolvedEn: json["peopleInvolvedEN"] == null ? null : List<String>.from(json["peopleInvolvedEN"].map((x) => x)),
    peopleInvolvedAr: json["peopleInvolvedAR"] == null ? null : List<String>.from(json["peopleInvolvedAR"].map((x) => x)),
    partyGroupInvolvedEn: json["partyGroupInvolvedEN"] == null ? null : List<String>.from(json["partyGroupInvolvedEN"].map((x) => x)),
    partyGroupInvolvedAr: json["partyGroupInvolvedAR"] == null ? null : List<String>.from(json["partyGroupInvolvedAR"].map((x) => x)),
    peopleAffectedPositivelyEn: json["peopleAffectedPositivelyEN"] == null ? null : List<String>.from(json["peopleAffectedPositivelyEN"].map((x) => x)),
    peopleAffectedPositivelyAr: json["peopleAffectedPositivelyAR"] == null ? null : List<String>.from(json["peopleAffectedPositivelyAR"].map((x) => x)),
    partyGroupAffectedPositivelyEn: json["partyGroupAffectedPositivelyEN"] == null ? null : List<String>.from(json["partyGroupAffectedPositivelyEN"].map((x) => x)),
    partyGroupAffectedPositivelyAr: json["partyGroupAffectedPositivelyAR"] == null ? null : List<String>.from(json["partyGroupAffectedPositivelyAR"].map((x) => x)),
    peopleAffectedNegativelyEn: json["peopleAffectedNegativelyEN"] == null ? null : List<String>.from(json["peopleAffectedNegativelyEN"].map((x) => x)),
    peopleAffectedNegativelyAr: json["peopleAffectedNegativelyAR"] == null ? null : List<String>.from(json["peopleAffectedNegativelyAR"].map((x) => x)),
    partyGroupAffectedNegativelyEn: json["partyGroupAffectedNegativelyEN"] == null ? null : List<String>.from(json["partyGroupAffectedNegativelyEN"].map((x) => x)),
    partyGroupAffectedNegativelyAr: json["partyGroupAffectedNegativelyAR"] == null ? null : List<String>.from(json["partyGroupAffectedNegativelyAR"].map((x) => x)),
    dataReliability: json["dataReliability"] == null ? null : json["dataReliability"],
  );

  Map<String, dynamic> toJson() => {
    "eventID": eventId == null ? null : eventId,
    "eventNameEN": eventNameEn == null ? null : eventNameEn,
    "eventNameAR": eventNameAr == null ? null : eventNameAr,
    "photoURL": photoUrl == null ? null : photoUrl,
    "eventDetailEN": eventDetailEn == null ? null : eventDetailEn!.toJson(),
    "eventDetailAR": eventDetailAr == null ? null : eventDetailAr!.toJson(),
    "startDate": startDate == null ? null : startDate,
    "endDate": endDate == null ? null : endDate,
    "Locality_Name_EN": localityNameEn == null ? null : localityNameEn,
    "Locality_Name_AR": localityNameAr == null ? null : localityNameAr,
    "Locality_Name_PCODE": localityNamePcode == null ? null : localityNamePcode,
    "State_Name_EN": stateNameEn == null ? null : stateNameEn,
    "State_Name_AR": stateNameAr == null ? null : stateNameAr,
    "State_Name_PCODE": stateNamePcode == null ? null : stateNamePcode,
    "Country_EN": countryEn == null ? null : countryEn,
    "Country_AR": countryAr == null ? null : countryAr,
    "Country_PCODE": countryPcode == null ? null : countryPcode,
    "peopleInvolvedEN": peopleInvolvedEn == null ? null : List<dynamic>.from(peopleInvolvedEn!.map((x) => x)),
    "peopleInvolvedAR": peopleInvolvedAr == null ? null : List<dynamic>.from(peopleInvolvedAr!.map((x) => x)),
    "partyGroupInvolvedEN": partyGroupInvolvedEn == null ? null : List<dynamic>.from(partyGroupInvolvedEn!.map((x) => x)),
    "partyGroupInvolvedAR": partyGroupInvolvedAr == null ? null : List<dynamic>.from(partyGroupInvolvedAr!.map((x) => x)),
    "peopleAffectedPositivelyEN": peopleAffectedPositivelyEn == null ? null : List<dynamic>.from(peopleAffectedPositivelyEn!.map((x) => x)),
    "peopleAffectedPositivelyAR": peopleAffectedPositivelyAr == null ? null : List<dynamic>.from(peopleAffectedPositivelyAr!.map((x) => x)),
    "partyGroupAffectedPositivelyEN": partyGroupAffectedPositivelyEn == null ? null : List<dynamic>.from(partyGroupAffectedPositivelyEn!.map((x) => x)),
    "partyGroupAffectedPositivelyAR": partyGroupAffectedPositivelyAr == null ? null : List<dynamic>.from(partyGroupAffectedPositivelyAr!.map((x) => x)),
    "peopleAffectedNegativelyEN": peopleAffectedNegativelyEn == null ? null : List<dynamic>.from(peopleAffectedNegativelyEn!.map((x) => x)),
    "peopleAffectedNegativelyAR": peopleAffectedNegativelyAr == null ? null : List<dynamic>.from(peopleAffectedNegativelyAr!.map((x) => x)),
    "partyGroupAffectedNegativelyEN": partyGroupAffectedNegativelyEn == null ? null : List<dynamic>.from(partyGroupAffectedNegativelyEn!.map((x) => x)),
    "partyGroupAffectedNegativelyAR": partyGroupAffectedNegativelyAr == null ? null : List<dynamic>.from(partyGroupAffectedNegativelyAr!.map((x) => x)),
    "dataReliability": dataReliability == null ? null : dataReliability,
  };
}

class PoliticalMappingEventDetailModel {
  PoliticalMappingEventDetailModel({
    this.overview,
    this.details,
    this.effectedOnPeople,
    this.effectOnPartiesGroups,
    this.summary,
    this.references,
  });

  String? overview;
  String?  details;
  String?  effectedOnPeople;
  String?  effectOnPartiesGroups;
  String?  summary;
  List<ReferenceModel>? references;

  factory PoliticalMappingEventDetailModel.fromJson(Map<String, dynamic> json) => PoliticalMappingEventDetailModel(
    overview: json["overview"] == null ? null : json["overview"],
    details: json["details"] == null ? null : json["details"],
    effectedOnPeople: json["effectedOnPeople"] == null ? null : json["effectedOnPeople"],
    effectOnPartiesGroups: json["effectOnPartiesGroups"] == null ? null : json["effectOnPartiesGroups"],
    summary: json["summary"] == null ? null : json["summary"],
    references: json["references"] == null ? null : List<ReferenceModel>.from(json["references"].map((x) => ReferenceModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overview": overview == null ? null : overview,
    "details": details == null ? null : details,
    "effectedOnPeople": effectedOnPeople == null ? null : effectedOnPeople,
    "effectOnPartiesGroups": effectOnPartiesGroups == null ? null : effectOnPartiesGroups,
    "summary": summary == null ? null : summary,
    "references": references == null ? null : List<dynamic>.from(references!.map((x) => x.toJson())),
  };
}