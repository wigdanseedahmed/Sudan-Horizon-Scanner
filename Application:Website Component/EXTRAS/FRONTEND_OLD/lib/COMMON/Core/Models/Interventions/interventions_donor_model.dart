import 'package:sudan_horizon_scanner/imports.dart';

class InterventionsDonorModel {
  InterventionsDonorModel({
    this.donorName,
    this.donorEmail,
    this.donorWebsite,
    this.donorPhotoUrl,
    this.donorProjectList,
    this.donationAmount
  });

  String? donorName;
  String? donorEmail;
  String? donorWebsite;
  String? donorPhotoUrl;
  List<String>? donorProjectList;
  int? donationAmount;

  factory InterventionsDonorModel.fromJson(Map<String, dynamic> json) => InterventionsDonorModel(
    donorName: json["donorName"],
    donorEmail: json["donorEmail"],
    donorWebsite: json["donorWebsite"],
    donorPhotoUrl: json["donorPhotoUrl"],
    donorProjectList: List<String>.from(json["donorProjectList"].map((x) => x)),
    donationAmount: json["donationAmount"],
  );

  Map<String, dynamic> toJson() => {
    "donorName": donorName,
    "donorEmail": donorEmail,
    "donorWebsite": donorWebsite,
    "donorPhotoUrl": donorPhotoUrl,
    "donorProjectList": List<dynamic>.from(donorProjectList!.map((x) => x)),
    "donationAmount": donationAmount,
  };

  factory InterventionsDonorModel.fromMap(Map<String, dynamic> json) => InterventionsDonorModel(
    donorName: json["donorName"],
    donorEmail: json["donorEmail"],
    donorWebsite: json["donorWebsite"],
    donorPhotoUrl: json["donorPhotoUrl"],
    donorProjectList: List<String>.from(json["donorProjectList"].map((x) => x)),
    donationAmount: json["donationAmount"],
  );

  Map<String, dynamic> toMap() => {
    "donorName": donorName,
    "donorEmail": donorEmail,
    "donorWebsite": donorWebsite,
    "donorPhotoUrl": donorPhotoUrl,
    "donorProjectList": List<dynamic>.from(donorProjectList!.map((x) => x)),
    "donationAmount": donationAmount,
  };
}
