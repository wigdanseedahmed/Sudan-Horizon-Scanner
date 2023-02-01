import 'package:sudan_horizon_scanner/imports.dart';

List<PoliticalMappingPartyGroupModel> politicalMappingPartyGroupModelFromJson(
        String str) =>
    List<PoliticalMappingPartyGroupModel>.from(json
        .decode(str)
        .map((x) => PoliticalMappingPartyGroupModel.fromJson(x)));

String politicalMappingPartyGroupModelToJson(
        List<PoliticalMappingPartyGroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoliticalMappingPartyGroupModel {
  PoliticalMappingPartyGroupModel({
    this.actorId,
    this.actorNameEn,
    this.actorNameAr,
    this.actorTypeEn,
    this.actorTypeAr,
    this.actorAffiliationGroupPartyTypeEn,
    this.actorAffiliationGroupPartyTypeAr,
    this.actorMemberNamesEn,
    this.actorMemberNamesAr,
    this.photoUrl,
    this.status,
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
    this.actorLeaderEn,
    this.actorLeaderAr,
    this.actorDetailEn,
    this.actorDetailAr,
    this.coalitionNameEn,
    this.coalitionNameAr,
    this.consequenceSignEn,
    this.consequenceSignAr,
    this.dataReliability,
  });

  String? actorId;
  String? actorNameEn;
  String? actorNameAr;
  String? actorTypeEn;
  String? actorTypeAr;
  String? actorAffiliationGroupPartyTypeEn;
  String? actorAffiliationGroupPartyTypeAr;
  List<String>? actorMemberNamesEn;
  List<String>? actorMemberNamesAr;
  String? photoUrl;
  String? status;
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
  String? actorLeaderEn;
  String? actorLeaderAr;
  ActorDetail? actorDetailEn;
  ActorDetail? actorDetailAr;
  List<String>? coalitionNameEn;
  List<String>? coalitionNameAr;
  List<String>? consequenceSignEn;
  List<String>? consequenceSignAr;
  String? dataReliability;

  factory PoliticalMappingPartyGroupModel.fromJson(Map<String, dynamic> json) =>
      PoliticalMappingPartyGroupModel(
        actorId: json["actorID"] == null ? null : json["actorID"],
        actorNameEn: json["actorNameEN"] == null ? null : json["actorNameEN"],
        actorNameAr: json["actorNameAR"] == null ? null : json["actorNameAR"],
        actorTypeEn: json["actorTypeEN"] == null ? null : json["actorTypeEN"],
        actorTypeAr: json["actorTypeAR"] == null ? null : json["actorTypeAR"],
        actorAffiliationGroupPartyTypeEn:
            json["actorAffiliationGroupPartyTypeEN"] == null
                ? null
                : json["actorAffiliationGroupPartyTypeEN"],
        actorAffiliationGroupPartyTypeAr:
            json["actorAffiliationGroupPartyTypeAR"] == null
                ? null
                : json["actorAffiliationGroupPartyTypeAR"],
        actorMemberNamesEn: json["actorMemberNamesEN"] == null
            ? null
            : List<String>.from(json["actorMemberNamesEN"].map((x) => x)),
        actorMemberNamesAr: json["actorMemberNamesAR"] == null
            ? null
            : List<String>.from(json["actorMemberNamesAR"].map((x) => x)),
        photoUrl: json["photoURL"] == null ? null : json["photoURL"],
        status: json["status"] == null ? null : json["status"],
        startDate: json["startDate"] == null ? null : json["startDate"],
        endDate: json["endDate"] == null ? null : json["endDate"],
        localityNameEn:
            json["Locality_Name_EN"] == null ? null : json["Locality_Name_EN"],
        localityNameAr:
            json["Locality_Name_AR"] == null ? null : json["Locality_Name_AR"],
        localityNamePcode: json["Locality_Name_PCODE"] == null
            ? null
            : json["Locality_Name_PCODE"],
        stateNameEn:
            json["State_Name_EN"] == null ? null : json["State_Name_EN"],
        stateNameAr:
            json["State_Name_AR"] == null ? null : json["State_Name_AR"],
        stateNamePcode:
            json["State_Name_PCODE"] == null ? null : json["State_Name_PCODE"],
        countryEn: json["Country_EN"] == null ? null : json["Country_EN"],
        countryAr: json["Country_AR"] == null ? null : json["Country_AR"],
        actorLeaderEn:
            json["actorLeaderEN"] == null ? null : json["actorLeaderEN"],
        actorLeaderAr:
            json["actorLeaderAR"] == null ? null : json["actorLeaderAR"],
        actorDetailEn: json["actorDetailEN"] == null
            ? null
            : ActorDetail.fromJson(json["actorDetailEN"]),
        actorDetailAr: json["actorDetailAR"] == null
            ? null
            : ActorDetail.fromJson(json["actorDetailAR"]),
        coalitionNameEn: json["coalitionNameEN"] == null
            ? null
            : List<String>.from(json["coalitionNameEN"].map((x) => x)),
        coalitionNameAr: json["coalitionNameAR"] == null
            ? null
            : List<String>.from(json["coalitionNameAR"].map((x) => x)),
        consequenceSignEn: json["consequenceSignEN"] == null
            ? null
            : List<String>.from(json["consequenceSignEN"].map((x) => x)),
        consequenceSignAr: json["consequenceSignAR"] == null
            ? null
            : List<String>.from(json["consequenceSignAR"].map((x) => x)),
        dataReliability:
            json["dataReliability"] == null ? null : json["dataReliability"],
      );

  Map<String, dynamic> toJson() => {
        "actorID": actorId == null ? null : actorId,
        "actorNameEN": actorNameEn == null ? null : actorNameEn,
        "actorNameAR": actorNameAr == null ? null : actorNameAr,
        "actorTypeEN": actorTypeEn == null ? null : actorTypeEn,
        "actorTypeAR": actorTypeAr == null ? null : actorTypeAr,
        "actorAffiliationGroupPartyTypeEN":
            actorAffiliationGroupPartyTypeEn == null
                ? null
                : actorAffiliationGroupPartyTypeEn,
        "actorAffiliationGroupPartyTypeAR":
            actorAffiliationGroupPartyTypeAr == null
                ? null
                : actorAffiliationGroupPartyTypeAr,
        "actorMemberNamesEN": actorMemberNamesEn == null
            ? null
            : List<dynamic>.from(actorMemberNamesEn!.map((x) => x)),
        "actorMemberNamesAR": actorMemberNamesAr == null
            ? null
            : List<dynamic>.from(actorMemberNamesAr!.map((x) => x)),
        "photoURL": photoUrl == null ? null : photoUrl,
        "status": status == null ? null : status,
        "startDate": startDate == null ? null : startDate,
        "endDate": endDate == null ? null : endDate,
        "Locality_Name_EN": localityNameEn == null ? null : localityNameEn,
        "Locality_Name_AR": localityNameAr == null ? null : localityNameAr,
        "Locality_Name_PCODE":
            localityNamePcode == null ? null : localityNamePcode,
        "State_Name_EN": stateNameEn == null ? null : stateNameEn,
        "State_Name_AR": stateNameAr == null ? null : stateNameAr,
        "State_Name_PCODE": stateNamePcode == null ? null : stateNamePcode,
        "Country_EN": countryEn == null ? null : countryEn,
        "Country_AR": countryAr == null ? null : countryAr,
        "actorLeaderEN": actorLeaderEn == null ? null : actorLeaderEn,
        "actorLeaderAR": actorLeaderAr == null ? null : actorLeaderAr,
        "actorDetailEN": actorDetailEn == null ? null : actorDetailEn!.toJson(),
        "actorDetailAR": actorDetailAr == null ? null : actorDetailAr!.toJson(),
        "coalitionNameEN": coalitionNameEn == null
            ? null
            : List<dynamic>.from(coalitionNameEn!.map((x) => x)),
        "coalitionNameAR": coalitionNameAr == null
            ? null
            : List<dynamic>.from(coalitionNameAr!.map((x) => x)),
        "consequenceSignEN": consequenceSignEn == null
            ? null
            : List<dynamic>.from(consequenceSignEn!.map((x) => x)),
        "consequenceSignAR": consequenceSignAr == null
            ? null
            : List<dynamic>.from(consequenceSignAr!.map((x) => x)),
        "dataReliability": dataReliability == null ? null : dataReliability,
      };
}

class ActorDetail {
  ActorDetail({
    this.overview,
    this.actorBackground,
    this.politicalCareer,
    this.ideologies,
    this.views,
    this.predictions,
    this.summary,
    this.references,
  });

  String? overview;
  String? actorBackground;
  String? politicalCareer;
  List<String>? ideologies;
  String? views;
  String? predictions;
  String? summary;
  List<ReferenceModel>? references;

  factory ActorDetail.fromJson(Map<String, dynamic> json) => ActorDetail(
        overview: json["overview"] == null ? null : json["overview"],
        actorBackground:
            json["actorBackground"] == null ? null : json["actorBackground"],
        politicalCareer:
            json["politicalCareer"] == null ? null : json["politicalCareer"],
        ideologies: json["ideologies"] == null
            ? null
            : List<String>.from(json["ideologies"].map((x) => x)),
        views: json["views"] == null ? null : json["views"],
        predictions: json["predictions"] == null ? null : json["predictions"],
        summary: json["summary"] == null ? null : json["summary"],
        references: json["references"] == null
            ? null
            : List<ReferenceModel>.from(
                json["references"].map((x) => ReferenceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "overview": overview == null ? null : overview,
        "actorBackground": actorBackground == null ? null : actorBackground,
        "politicalCareer": politicalCareer == null ? null : politicalCareer,
        "ideologies": ideologies == null
            ? null
            : List<dynamic>.from(ideologies!.map((x) => x)),
        "views": views == null ? null : views,
        "predictions": predictions == null ? null : predictions,
        "summary": summary == null ? null : summary,
        "references": references == null
            ? null
            : List<dynamic>.from(references!.map((x) => x.toJson())),
      };
}
