import 'package:sudan_horizon_scanner/imports.dart';

List<PoliticalMappingCoalitionModel> politicalMappingCoalitionModelFromJson(String str) => List<PoliticalMappingCoalitionModel>.from(json.decode(str).map((x) => PoliticalMappingCoalitionModel.fromJson(x)));

String politicalMappingCoalitionModelToJson(List<PoliticalMappingCoalitionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoliticalMappingCoalitionModel {
  PoliticalMappingCoalitionModel({
    this.coalitionsId,
    this.coalitionsNameEn,
    this.coalitionsNameAr,
    this.photoUrl,
    this.coalitionTypeEn,
    this.coalitionTypeAr,
    this.coalitionMediatorEn,
    this.coalitionMediatorAr,
    this.coalitionsDetailEn,
    this.coalitionsDetailAr,
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
    this.consequenceSignEn,
    this.consequenceSignAr,
    this.dataReliability,
  });

  String? coalitionsId;
  String? coalitionsNameEn;
  String? coalitionsNameAr;
  String? photoUrl;
  String? coalitionTypeEn;
  String? coalitionTypeAr;
  String? coalitionMediatorEn;
  List<String>? coalitionMediatorAr;
  PoliticalMappingCoalitionsDetailModel? coalitionsDetailEn;
  PoliticalMappingCoalitionsDetailModel? coalitionsDetailAr;
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
  List<String>? consequenceSignEn;
  List<String>? consequenceSignAr;
  String? dataReliability;

  factory PoliticalMappingCoalitionModel.fromJson(Map<String, dynamic> json) => PoliticalMappingCoalitionModel(
    coalitionsId: json["coalitionsID"] == null ? null : json["coalitionsID"],
    coalitionsNameEn: json["coalitionsNameEN"] == null ? null : json["coalitionsNameEN"],
    coalitionsNameAr: json["coalitionsNameAR"] == null ? null : json["coalitionsNameAR"],
    photoUrl: json["photoURL"] == null ? null : json["photoURL"],
    coalitionTypeEn: json["coalitionTypeEN"] == null ? null : json["coalitionTypeEN"],
    coalitionTypeAr: json["coalitionTypeAR"] == null ? null : json["coalitionTypeAR"],
    coalitionMediatorEn: json["coalitionMediatorEN"] == null ? null : json["coalitionMediatorEN"],
    coalitionMediatorAr: json["coalitionMediatorAR"] == null ? null : List<String>.from(json["coalitionMediatorAR"].map((x) => x)),
    coalitionsDetailEn: json["coalitionsDetailEN"] == null ? null : PoliticalMappingCoalitionsDetailModel.fromJson(json["coalitionsDetailEN"]),
    coalitionsDetailAr: json["coalitionsDetailAR"] == null ? null : PoliticalMappingCoalitionsDetailModel.fromJson(json["coalitionsDetailAR"]),
    startDate: json["startDate"] == null ? null :json["startDate"],
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
    consequenceSignEn: json["consequenceSignEN"] == null ? null : List<String>.from(json["consequenceSignEN"].map((x) => x)),
    consequenceSignAr: json["consequenceSignAR"] == null ? null : List<String>.from(json["consequenceSignAR"].map((x) => x)),
    dataReliability: json["dataReliability"] == null ? null : json["dataReliability"],
  );

  Map<String, dynamic> toJson() => {
    "coalitionsID": coalitionsId == null ? null : coalitionsId,
    "coalitionsNameEN": coalitionsNameEn == null ? null : coalitionsNameEn,
    "coalitionsNameAR": coalitionsNameAr == null ? null : coalitionsNameAr,
    "photoURL": photoUrl == null ? null : photoUrl,
    "coalitionTypeEN": coalitionTypeEn == null ? null : coalitionTypeEn,
    "coalitionTypeAR": coalitionTypeAr == null ? null : coalitionTypeAr,
    "coalitionMediatorEN": coalitionMediatorEn == null ? null : coalitionMediatorEn,
    "coalitionMediatorAR": coalitionMediatorAr == null ? null : List<dynamic>.from(coalitionMediatorAr!.map((x) => x)),
    "coalitionsDetailEN": coalitionsDetailEn == null ? null : coalitionsDetailEn!.toJson(),
    "coalitionsDetailAR": coalitionsDetailAr == null ? null : coalitionsDetailAr!.toJson(),
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
    "consequenceSignEN": consequenceSignEn == null ? null : List<dynamic>.from(consequenceSignEn!.map((x) => x)),
    "consequenceSignAR": consequenceSignAr == null ? null : List<dynamic>.from(consequenceSignAr!.map((x) => x)),
    "dataReliability": dataReliability == null ? null : dataReliability,
  };
}

class PoliticalMappingCoalitionsDetailModel {
  PoliticalMappingCoalitionsDetailModel({
    this.overview,
    this.historicalBackground,
    this.details,
    this.effectedOnPeople,
    this.effectOnPartiesGroups,
    this.outcome,
    this.summary,
    this.references,
  });

  String? overview;
  String? historicalBackground;
  String? details;
  String? effectedOnPeople;
  String? effectOnPartiesGroups;
  String? outcome;
  String? summary;
  List<ReferenceModel>? references;

  factory PoliticalMappingCoalitionsDetailModel.fromJson(Map<String, dynamic> json) => PoliticalMappingCoalitionsDetailModel(
    overview: json["overview"] == null ? null : json["overview"],
    historicalBackground: json["historicalBackground"] == null ? null : json["historicalBackground"],
    details: json["details"] == null ? null : json["details"],
    effectedOnPeople: json["effectedOnPeople"] == null ? null : json["effectedOnPeople"],
    effectOnPartiesGroups: json["effectOnPartiesGroups"] == null ? null : json["effectOnPartiesGroups"],
    outcome: json["outcome"] == null ? null : json["outcome"],
    summary: json["summary"] == null ? null : json["summary"],
    references: json["references"] == null ? null : List<ReferenceModel>.from(json["references"].map((x) => ReferenceModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overview": overview == null ? null : overview,
    "historicalBackground": historicalBackground == null ? null : historicalBackground,
    "details": details == null ? null : details,
    "effectedOnPeople": effectedOnPeople == null ? null : effectedOnPeople,
    "effectOnPartiesGroups": effectOnPartiesGroups == null ? null : effectOnPartiesGroups,
    "outcome": outcome == null ? null : outcome,
    "summary": summary == null ? null : summary,
    "references": references == null ? null : List<dynamic>.from(references!.map((x) => x.toJson())),
  };
}
