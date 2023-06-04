import 'package:sudan_horizon_scanner/imports.dart';

List<PoliticalMappingIndividualModel> politicalMappingIndividualModelFromJson(
        String str) =>
    List<PoliticalMappingIndividualModel>.from(json
        .decode(str)
        .map((x) => PoliticalMappingIndividualModel.fromJson(x)));

String politicalMappingIndividualModelToJson(
        List<PoliticalMappingIndividualModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoliticalMappingIndividualModel {
  PoliticalMappingIndividualModel({
    this.actorId,
    this.actorNameEn,
    this.actorNameAr,
    this.actorTypeEn,
    this.actorTypeAr,
    this.actorAffiliationGroupPartyTypeEn,
    this.actorAffiliationGroupPartyTypeAr,
    this.actorAffiliationGroupPartyNameEn,
    this.actorAffiliationGroupPartyNameAr,
    this.photoUrl,
    this.jobTitle,
    this.status,
    this.startDate,
    this.endDate,
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
  String? actorAffiliationGroupPartyNameEn;
  String? actorAffiliationGroupPartyNameAr;
  String? photoUrl;
  String? jobTitle;
  String? status;
  String? startDate;
  String? endDate;
  PoliticalMappingIndividualActorDetailModel? actorDetailEn;
  PoliticalMappingIndividualActorDetailModel? actorDetailAr;
  List<String>? coalitionNameEn;
  List<String>? coalitionNameAr;
  List<String>? consequenceSignEn;
  List<String>? consequenceSignAr;
  String? dataReliability;

  factory PoliticalMappingIndividualModel.fromJson(Map<String, dynamic> json) =>
      PoliticalMappingIndividualModel(
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
        actorAffiliationGroupPartyNameEn:
            json["actorAffiliationGroupPartyNameEN"] == null
                ? null
                : json["actorAffiliationGroupPartyNameEN"],
        actorAffiliationGroupPartyNameAr:
            json["actorAffiliationGroupPartyNameAR"] == null
                ? null
                : json["actorAffiliationGroupPartyNameAR"],
        photoUrl: json["photoURL"] == null ? null : json["photoURL"],
        jobTitle: json["jobTitle"] == null ? null : json["jobTitle"],
        status: json["status"] == null ? null : json["status"],
        startDate: json["startDate"] == null ? null : json["startDate"],
        endDate: json["endDate"] == null ? null : json["endDate"],
        actorDetailEn: json["actorDetailEN"] == null
            ? null
            : PoliticalMappingIndividualActorDetailModel.fromJson(
                json["actorDetailEN"]),
        actorDetailAr: json["actorDetailAR"] == null
            ? null
            : PoliticalMappingIndividualActorDetailModel.fromJson(
                json["actorDetailAR"]),
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
        "actorAffiliationGroupPartyNameEN":
            actorAffiliationGroupPartyNameEn == null
                ? null
                : actorAffiliationGroupPartyNameEn,
        "actorAffiliationGroupPartyNameAR":
            actorAffiliationGroupPartyNameAr == null
                ? null
                : actorAffiliationGroupPartyNameAr,
        "photoURL": photoUrl == null ? null : photoUrl,
        "jobTitle": jobTitle == null ? null : jobTitle,
        "status": status == null ? null : status,
        "startDate": startDate == null ? null : startDate,
        "endDate": endDate == null ? null : endDate,
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

class PoliticalMappingIndividualActorDetailModel {
  PoliticalMappingIndividualActorDetailModel({
    this.overview,
    this.personalBackground,
    this.educationBackground,
    this.earlyAndInternationalCareer,
    this.politicalCareer,
    this.views,
    this.predictions,
    this.summary,
    this.references,
  });

  String? overview;
  String? personalBackground;
  String? educationBackground;
  String? earlyAndInternationalCareer;
  String? politicalCareer;
  String? views;
  String? predictions;
  String? summary;
  List<ReferenceModel>? references;

  factory PoliticalMappingIndividualActorDetailModel.fromJson(
          Map<String, dynamic> json) =>
      PoliticalMappingIndividualActorDetailModel(
        overview: json["overview"] == null ? null : json["overview"],
        personalBackground: json["personalBackground"] == null
            ? null
            : json["personalBackground"],
        educationBackground: json["educationBackground"] == null
            ? null
            : json["educationBackground"],
        earlyAndInternationalCareer: json["earlyAndInternationalCareer"] == null
            ? null
            : json["earlyAndInternationalCareer"],
        politicalCareer:
            json["politicalCareer"] == null ? null : json["politicalCareer"],
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
        "personalBackground":
            personalBackground == null ? null : personalBackground,
        "educationBackground":
            educationBackground == null ? null : educationBackground,
        "earlyAndInternationalCareer": earlyAndInternationalCareer == null
            ? null
            : earlyAndInternationalCareer,
        "politicalCareer": politicalCareer == null ? null : politicalCareer,
        "views": views == null ? null : views,
        "predictions": predictions == null ? null : predictions,
        "summary": summary == null ? null : summary,
        "references": references == null
            ? null
            : List<dynamic>.from(references!.map((x) => x.toJson())),
      };
}
