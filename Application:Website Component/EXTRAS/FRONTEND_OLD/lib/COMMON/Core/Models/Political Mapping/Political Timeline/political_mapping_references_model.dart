import 'package:sudan_horizon_scanner/imports.dart';

class ReferenceModel {
  ReferenceModel({
    this.link,
    this.createdBy,
  });

  String? link;
  String? createdBy;

  factory ReferenceModel.fromJson(Map<String, dynamic> json) => ReferenceModel(
    link: json["link"] == null ? null : json["link"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "link": link == null ? null : link,
    "createdBy": createdBy == null ? null : createdBy,
  };
}