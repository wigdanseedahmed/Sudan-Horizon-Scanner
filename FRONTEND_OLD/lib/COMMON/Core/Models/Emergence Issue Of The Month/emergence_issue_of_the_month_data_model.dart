import 'package:sudan_horizon_scanner/imports.dart';

List<IssueOfMonthDataModel> emergenceIssueOfTheMonthDataModelFromJson(
        String str) =>
    List<IssueOfMonthDataModel>.from(
        json.decode(str).map((x) => IssueOfMonthDataModel.fromJson(x)));

String emergenceIssueOfTheMonthDataModelToJson(
        List<IssueOfMonthDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IssueOfMonthDataModel {
  String? source;
  String? sourceCategory;
  String? issueString;
  String? sentimentAnalysis;
  double? repetition;
  String? emergenceIssue;
  String? image;
  Color? color;
  List<String>? sdgTargeted;
  String? language;

  IssueOfMonthDataModel({
    this.source,
    this.sourceCategory,
    this.issueString,
    this.sentimentAnalysis,
    this.repetition,
    this.image,
    this.emergenceIssue,
    this.color,
    this.sdgTargeted,
    this.language,
  });

  factory IssueOfMonthDataModel.fromJson(Map<String, dynamic> json) =>
      IssueOfMonthDataModel(
        source: json["source"] ?? null,
        sourceCategory: json["sourceCategory"],
        issueString: json["issueString"],
        sentimentAnalysis: json["sentimentAnalysis"] ?? null,
        repetition:
            json["repetition"] == null ? null : json["repetition"].toDouble(),
        image: json["image"] ?? null,
        emergenceIssue: json["emergenceIssue"] ?? null,
        color: json["color"] ?? null,
        sdgTargeted: json["sdgTargeted"] == null
            ? null
            : List<String>.from(json["sdgTargeted"].map((x) => x)),
          language: json["language"] == null
              ? null
              : json["language"],
      );

  Map<String, dynamic> toJson() => {
        "source": source ?? null,
        "sourceCategory": sourceCategory ?? null,
        "issueString": issueString ?? null,
        "sentimentAnalysis": sentimentAnalysis ?? null,
        "repetition": repetition ?? null,
        "image": image ?? null,
        "emergenceIssue": emergenceIssue ?? null,
        "color": color ?? null,
        "sdgTargeted": sdgTargeted == null
            ? null
            : List<dynamic>.from(sdgTargeted!.map((x) => x)),
    "language": language == null
        ? null
        : language,
      };
}
