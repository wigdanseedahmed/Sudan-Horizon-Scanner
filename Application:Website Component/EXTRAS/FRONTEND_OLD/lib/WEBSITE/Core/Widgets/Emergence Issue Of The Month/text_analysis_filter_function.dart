import 'package:nb_utils/nb_utils.dart';
import 'package:sudan_horizon_scanner/imports.dart';

List<IssueOfMonthDataModel> textAnalysisFilterFunction(
    {required List<IssueOfMonthDataModel> readEmergenceIssueDataJsonFileContent,
    required List sourceFilterSelectedOption,
    required String searchQuery,
    required List sentimentAnalysisFilterSelectedOption,
    required List languageSelectedOption,
    required List sdgSelectedOption,
    required String numberFilterSelectedOption,
    required double minValue,
    required double maxValue,
    required double value}) {
  if (searchQuery.isEmptyOrNull) {
    if (sdgSelectedOption.isEmpty) {
      if (languageSelectedOption.isEmpty) {
        if (numberFilterSelectedOption == 'Choose One') {
          value = 0;
          maxValue = 0;
          minValue = 0;
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              // no search field input, display all items
              return readEmergenceIssueDataJsonFileContent;
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      sourceFilterSelectedOption.contains(element.source!))
                  .toList();
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) => sentimentAnalysisFilterSelectedOption
                      .contains(element.sentimentAnalysis!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      sourceFilterSelectedOption.contains(element.source!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            }
          }
        } else {
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition.isBetween(minValue, maxValue))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) => element.repetition!.isEqual(value))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isEqual(value) == false)
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where(
                        (element) => element.repetition!.isGreaterThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) => (element.repetition!.isEqual(value) ||
                        element.repetition!.isGreaterThan(value)))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) => element.repetition!.isLowerThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) => (element.repetition!.isEqual(value) ||
                        element.repetition!.isLowerThan(value)))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition.isBetween(minValue, maxValue) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isEqual(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isEqual(value) == false &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isGreaterThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isLowerThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isGreaterThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isGreaterThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          }
        }
      } else {
        if (numberFilterSelectedOption == 'Choose One') {
          value = 0;
          maxValue = 0;
          minValue = 0;
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      languageSelectedOption.contains(element.language!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      languageSelectedOption.contains(element.language!) &&
                      sourceFilterSelectedOption.contains(element.source!))
                  .toList();
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      languageSelectedOption.contains(element.language!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      languageSelectedOption.contains(element.language!) &&
                      sourceFilterSelectedOption.contains(element.source!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            }
          }
        } else {
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false)
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                            sentimentAnalysisFilterSelectedOption
                                .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          }
        }
      }
    } else {
      if (languageSelectedOption.isEmpty) {
        if (numberFilterSelectedOption == 'Choose One') {
          value = 0;
          maxValue = 0;
          minValue = 0;
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      sdgSelectedOption.contains(element.sdgTargeted!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      sourceFilterSelectedOption.contains(element.source!))
                  .toList();
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      sourceFilterSelectedOption.contains(element.source!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            }
          }
        } else {
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition.isBetween(minValue, maxValue))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) == false)
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isGreaterThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isLowerThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) == false &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isLowerThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isGreaterThan(value) &&
                            sentimentAnalysisFilterSelectedOption
                                .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          }
        }
      } else {
        if (numberFilterSelectedOption == 'Choose One') {
          value = 0;
          maxValue = 0;
          minValue = 0;
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((IssueOfMonthDataModel element) =>
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      languageSelectedOption.contains(element.language!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((IssueOfMonthDataModel element) =>
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      languageSelectedOption.contains(element.language!) &&
                      sourceFilterSelectedOption.contains(element.source!))
                  .toList();
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((IssueOfMonthDataModel element) =>
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      languageSelectedOption.contains(element.language!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((IssueOfMonthDataModel element) =>
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      languageSelectedOption.contains(element.language!) &&
                      sourceFilterSelectedOption.contains(element.source!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            }
          }
        } else {
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false)
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          }
        }
      }
    }
  } else {
    // readEmergenceIssueDataJsonFileContent = readEmergenceIssueDataJsonFileContent.where((element) => element.issueString!.toLowerCase().contains(searchQuery.toLowerCase())).toList();

    if (sdgSelectedOption.isEmpty) {
      if (languageSelectedOption.isEmpty) {
        if (numberFilterSelectedOption == 'Choose One') {
          value = 0;
          maxValue = 0;
          minValue = 0;
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              // no search field input, display all items
              return readEmergenceIssueDataJsonFileContent
                  .where((element) => element.issueString!
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sourceFilterSelectedOption.contains(element.source!))
                  .toList();
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sourceFilterSelectedOption.contains(element.source!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            }
          }
        } else {
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition.isBetween(minValue, maxValue))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isEqual(value))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isEqual(value) == false)
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isGreaterThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isLowerThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isEqual(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isEqual(value) == false &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isGreaterThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isLowerThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isGreaterThan(value) &&
                            sentimentAnalysisFilterSelectedOption
                                .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isGreaterThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          }
        }
      } else {
        if (numberFilterSelectedOption == 'Choose One') {
          value = 0;
          maxValue = 0;
          minValue = 0;
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      languageSelectedOption.contains(element.language!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      languageSelectedOption.contains(element.language!) &&
                      sourceFilterSelectedOption.contains(element.source!))
                  .toList();
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      languageSelectedOption.contains(element.language!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      languageSelectedOption.contains(element.language!) &&
                      sourceFilterSelectedOption.contains(element.source!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            }
          }
        } else {
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false)
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                            sentimentAnalysisFilterSelectedOption
                                .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          }
        }
      }
    } else {
      if (languageSelectedOption.isEmpty) {
        if (numberFilterSelectedOption == 'Choose One') {
          value = 0;
          maxValue = 0;
          minValue = 0;
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sdgSelectedOption.contains(element.sdgTargeted!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      sourceFilterSelectedOption.contains(element.source!))
                  .toList();
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      sourceFilterSelectedOption.contains(element.source!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            }
          }
        } else {
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition.isBetween(minValue, maxValue))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) == false)
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isGreaterThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isLowerThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) == false &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isLowerThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isGreaterThan(value) &&
                            sentimentAnalysisFilterSelectedOption
                                .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          }
        }
      } else {
        if (numberFilterSelectedOption == 'Choose One') {
          value = 0;
          maxValue = 0;
          minValue = 0;
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((IssueOfMonthDataModel element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      languageSelectedOption.contains(element.language!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((IssueOfMonthDataModel element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      languageSelectedOption.contains(element.language!) &&
                      sourceFilterSelectedOption.contains(element.source!))
                  .toList();
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              return readEmergenceIssueDataJsonFileContent
                  .where((IssueOfMonthDataModel element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      languageSelectedOption.contains(element.language!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            } else {
              return readEmergenceIssueDataJsonFileContent
                  .where((IssueOfMonthDataModel element) =>
                      element.issueString!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      sdgSelectedOption.contains(element.sdgTargeted!) &&
                      languageSelectedOption.contains(element.language!) &&
                      sourceFilterSelectedOption.contains(element.source!) &&
                      sentimentAnalysisFilterSelectedOption
                          .contains(element.sentimentAnalysis!))
                  .toList();
            }
          }
        } else {
          if (sentimentAnalysisFilterSelectedOption.isEmpty) {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false)
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          } else {
            if (sourceFilterSelectedOption.isEmpty) {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                            sentimentAnalysisFilterSelectedOption
                                .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        sdgSelectedOption.contains(element.sdgTargeted!) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis))
                    .toList();
              }
            } else {
              if (numberFilterSelectedOption == "Between") {
                value = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition.isBetween(minValue, maxValue) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Equals") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Does NOT Equal") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isEqual(value) == false &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Greater Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isGreaterThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Greater Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isGreaterThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption == "Less Than") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        element.repetition!.isLowerThan(value) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              } else if (numberFilterSelectedOption ==
                  "Less Than or Equal To") {
                maxValue = 0;
                minValue = 0;
                return readEmergenceIssueDataJsonFileContent
                    .where((element) =>
                        element.issueString!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        languageSelectedOption.contains(element.language!) &&
                        (element.repetition!.isEqual(value) ||
                            element.repetition!.isLowerThan(value)) &&
                        sentimentAnalysisFilterSelectedOption
                            .contains(element.sentimentAnalysis) &&
                        sourceFilterSelectedOption.contains(element.source))
                    .toList();
              }
            }
          }
        }
      }
    }
  }
  return readEmergenceIssueDataJsonFileContent;
}
