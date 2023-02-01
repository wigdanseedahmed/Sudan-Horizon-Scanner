import 'package:sudan_horizon_scanner/imports.dart';

List<IssueOfMonthModel> emergenceIssueOfTheMonthModelFromJson(String str) =>
    List<IssueOfMonthModel>.from(
        json.decode(str).map((x) => IssueOfMonthModel.fromJson(x)));

String emergenceIssueOfTheMonthModelToJson(List<IssueOfMonthModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IssueOfMonthModel {
  String? emergingIssue;
  double? repetition;
  int? totalDataCount;
  int? positiveSentimentAnalysisDataCount;
  int? neutralSentimentAnalysisDataCount;
  int? negativeSentimentAnalysisDataCount;
  String? time;
  String? summary;
  String? sdgTargeted;
  List<String>? sources;

  IssueOfMonthModel({
    this.emergingIssue,
    this.repetition,
    this.totalDataCount,
    this.positiveSentimentAnalysisDataCount,
    this.neutralSentimentAnalysisDataCount,
    this.negativeSentimentAnalysisDataCount,
    this.summary,
    this.time,
    this.sdgTargeted,
    this.sources,
  });

  factory IssueOfMonthModel.fromJson(Map<String, dynamic> json) =>
      IssueOfMonthModel(
        emergingIssue: json["emergingIssue"],
        repetition:
            json["repetition"] == null ? null : json["repetition"].toDouble(),
        totalDataCount: json["totalDataCount"] ?? null,
        positiveSentimentAnalysisDataCount:
            json["positiveSentimentAnalysisDataCount"] ?? null,
        neutralSentimentAnalysisDataCount:
            json["neutralSentimentAnalysisDataCount"] ?? null,
        negativeSentimentAnalysisDataCount:
            json["negativeSentimentAnalysisDataCount"] ?? null,
        sdgTargeted: json["sdgTargeted"] ?? null,
        summary: json["summary"] ?? null,
        time: json["time"] ?? null,
        sources: json["sources"] == null
            ? null
            : List<String>.from(json["sources"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "emergingIssue": emergingIssue ?? null,
        "repetition": repetition ?? null,
    "totalDataCount": totalDataCount?? null,
        "positiveSentimentAnalysisDataCount":
            positiveSentimentAnalysisDataCount ?? null,
        "neutralSentimentAnalysisDataCount":
            neutralSentimentAnalysisDataCount ?? null,
        "negativeSentimentAnalysisDataCount":
            negativeSentimentAnalysisDataCount ?? null,
        "summary": summary ?? null,
        "time": time ?? null,
        "sdgTargeted": sdgTargeted ?? null,
        "sources":
            sources == null ? null : List<dynamic>.from(sources!.map((x) => x)),
      };
}
