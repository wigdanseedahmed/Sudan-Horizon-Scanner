import 'package:sudan_horizon_scanner/imports.dart';

List<ClusterModel> digitalAvatarListClusterModelFromJson(String str) => List<ClusterModel>.from(json.decode(str).map((x) => ClusterModel.fromJson(x)));

String digitalAvatarListClusterModelToJson(List<ClusterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ClusterModel digitalAvatarClusterModelFromJson(String str) => ClusterModel.fromJson(json.decode(str));

String digitalAvatarClusterModelToJson(ClusterModel data) => json.encode(data.toJson());

class ClusterModel {
  ClusterModel({
    this.cluster,
    this.subCluster,
    this.dataSet,
    this.indicators,
    this.geographicalCoverage,
    this.time,
    this.startDate,
    this.endDate,
    this.duration,
  });

  String? cluster;
  String? subCluster;
  String? dataSet;
  String? indicators;
  String? geographicalCoverage;
  String? time;
  String? startDate;
  String? endDate;
  int? duration;

  factory ClusterModel.fromJson(Map<String, dynamic> json) => ClusterModel(
    cluster: json["cluster"] ?? null,
    subCluster: json["subCluster"],
    dataSet: json["dataSet"] ?? null,
    indicators: json["indicators "] ?? null,
    geographicalCoverage: json["geographicalCoverage"] ?? null,
    time: json["time "] ?? null,
    startDate: json["startDate"] ?? null,
    endDate: json["endDate"] ?? null,
    duration: json["duration"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "cluster": cluster ?? null,
    "subCluster": subCluster,
    "dataSet": dataSet ?? null,
    "Indicators ": indicators ?? null,
    "geographicalCoverage": geographicalCoverage ?? null,
    "time ": time ?? null,
    "startDate": startDate ?? null,
    "endDate": endDate ?? null,
    "duration": duration ?? null,
  };
}
