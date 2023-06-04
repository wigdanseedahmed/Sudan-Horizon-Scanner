import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class EmergenceIssueOfTheMonthScreenWS extends StatefulWidget {
  const EmergenceIssueOfTheMonthScreenWS({Key? key}) : super(key: key);

  @override
  State<EmergenceIssueOfTheMonthScreenWS> createState() =>
      EmergenceIssueOfTheMonthScreenWSState();
}

class EmergenceIssueOfTheMonthScreenWSState
    extends State<EmergenceIssueOfTheMonthScreenWS>
    with TickerProviderStateMixin {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  late List<IssueOfMonthModel> readEmergenceIssueJsonFileContent =
      <IssueOfMonthModel>[];

  /// Filter Chart Variables
  List<IssueOfMonthModel> emergenceIssueJsonFileContentFilter =
      <IssueOfMonthModel>[];

  var repetitionChartFilterSelectedOption = 0.0;

  Future<List<IssueOfMonthModel>> readEmergenceIssueFromJsonFile() async {
    /// Read Local Json File Directly
    /*String jsonString = await DefaultAssetBundle.of(context)
        .loadString('jsonDataFiles/interventions/project_data.json');*/
    //print(jsonString);

    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getEmergingIssues);

    /// Create Request to get data and response to read data
    final response = await http.get(
      uri,
      headers: {
        //"Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Content-Type, Access-Control-Allow-Origin, Accept",
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
      },
    );
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      setState(() {
        readEmergenceIssueJsonFileContent =
            emergenceIssueOfTheMonthModelFromJson(
                response.body); //(jsonString);

        if (repetitionChartFilterSelectedOption == 0) {
          emergenceIssueJsonFileContentFilter =
              readEmergenceIssueJsonFileContent;
        } else {
          emergenceIssueJsonFileContentFilter =
              emergenceIssueJsonFileContentFilter;
        }
      });

      return emergenceIssueJsonFileContentFilter;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  /// EMERGENCE ISSUES OF FILTER AND SEARCH VARIABLES
  var searchQuery = '';

  var sourceFilterSelectedOption = [];

  var sentimentAnalysisFilterSelectedOption = [];

  var languageSelectedOption = [];

  var sdgSelectedOption = [];

  var numberFilterSelectedOption = 'Choose One';
  var minValue = 0.0;
  var maxValue = 0.0;
  var value = 0.0;

  /// EMERGENCE ISSUES OF MONTH DATA VARIABLES

  List<IssueOfMonthDataModel> issueOfMonthFinalSearchDataList =
      <IssueOfMonthDataModel>[];

  late List<IssueOfMonthDataModel> readEmergenceIssueDataJsonFileContent =
      <IssueOfMonthDataModel>[];

  Future<List<IssueOfMonthDataModel>>
      readEmergenceIssueDataFromJsonFile() async {
    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getEmergingIssuesData);

    /// Create Request to get data and response to read data
    final response = await http.get(
      uri,
      headers: {
        //"Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Content-Type, Access-Control-Allow-Origin, Accept",
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
      },
    );
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      setState(() {
        readEmergenceIssueDataJsonFileContent =
            emergenceIssueOfTheMonthDataModelFromJson(
                response.body); //(jsonString);

        if (sourceFilterSelectedOption.isEmpty &&
            sentimentAnalysisFilterSelectedOption.isEmpty &&
            languageSelectedOption.isEmpty &&
            sdgSelectedOption.isEmpty &&
            numberFilterSelectedOption == 'Choose One' &&
            minValue == 0.0 &&
            maxValue == 0.0 &&
            value == 0.0 &&
            searchQuery == '') {
          issueOfMonthFinalSearchDataList =
              readEmergenceIssueDataJsonFileContent;

          _mainIssueOfTheMonthSocialMediaData =
              readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.sourceCategory == qualitativeDataSourceList[0])
                  .toList();
          _mainIssueOfTheMonthSongData = readEmergenceIssueDataJsonFileContent
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[1])
              .toList();
          _mainIssueOfTheMonthReligiousSpeechesData =
              readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.sourceCategory == qualitativeDataSourceList[2])
                  .toList();
          _mainIssueOfTheMonthInterviewsData =
              readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.sourceCategory == qualitativeDataSourceList[3])
                  .toList();
          _mainIssueOfTheMonthVisualAnthropologyData =
              readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.sourceCategory == qualitativeDataSourceList[4])
                  .toList();
          _mainIssueOfTheMonthGISData = readEmergenceIssueDataJsonFileContent
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[5])
              .toList();
          _mainIssueOfTheMonthForesightAndScenariosBuildingData =
              readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.sourceCategory == qualitativeDataSourceList[6])
                  .toList();
          _mainIssueOfTheMonthPublicPerceptionSurveyData =
              readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.sourceCategory == qualitativeDataSourceList[7])
                  .toList();
          _mainIssueOfTheMonthBehavioralDataData =
              readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.sourceCategory == qualitativeDataSourceList[8])
                  .toList();
          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
              readEmergenceIssueDataJsonFileContent
                  .where((element) =>
                      element.sourceCategory == qualitativeDataSourceList[9])
                  .toList();
        } else {
          issueOfMonthFinalSearchDataList = issueOfMonthFinalSearchDataList;

          _mainIssueOfTheMonthSocialMediaData =
              _mainIssueOfTheMonthSocialMediaData;
          _mainIssueOfTheMonthSongData = _mainIssueOfTheMonthSongData;
          _mainIssueOfTheMonthReligiousSpeechesData =
              _mainIssueOfTheMonthReligiousSpeechesData;
          _mainIssueOfTheMonthInterviewsData =
              _mainIssueOfTheMonthInterviewsData;
          _mainIssueOfTheMonthVisualAnthropologyData =
              _mainIssueOfTheMonthVisualAnthropologyData;
          _mainIssueOfTheMonthGISData = _mainIssueOfTheMonthGISData;
          _mainIssueOfTheMonthForesightAndScenariosBuildingData =
              _mainIssueOfTheMonthForesightAndScenariosBuildingData;
          _mainIssueOfTheMonthPublicPerceptionSurveyData =
              _mainIssueOfTheMonthPublicPerceptionSurveyData;
          _mainIssueOfTheMonthBehavioralDataData =
              _mainIssueOfTheMonthBehavioralDataData;
          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
              _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData;
        }
      });

      return issueOfMonthFinalSearchDataList;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    /// EMERGENCE ISSUES OF FILTER AND SEARCH VARIABLES
    sourceFilterSelectedOption.isEmpty;
    sentimentAnalysisFilterSelectedOption.isEmpty;
    languageSelectedOption.isEmpty;
    sdgSelectedOption.isEmpty;
    numberFilterSelectedOption == 'Choose One';
    minValue == 0.0;
    maxValue == 0.0;
    value == 0.0;
    searchQuery = '';

    /// EMERGENCE ISSUES OF MONTH DATA AND SEARCH VARIABLES
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readEmergenceIssueDataFromJsonFile().then((readEmergenceIssueData) {
        issueOfMonthFinalSearchDataList = readEmergenceIssueDataJsonFileContent;
        if (searchQuery != '') {
          issueOfMonthFinalSearchDataList.clear();
          readEmergenceIssueData.forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                issueOfMonthFinalSearchDataList.add(searchResult);
              });
            } else {
              issueOfMonthFinalSearchDataList;
            }
          });

          readEmergenceIssueData.forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                issueOfMonthFinalSearchDataList.add(searchResult);
              });
            } else {
              issueOfMonthFinalSearchDataList;

              _mainIssueOfTheMonthSocialMediaData;
              _mainIssueOfTheMonthSongData;
              _mainIssueOfTheMonthReligiousSpeechesData;
              _mainIssueOfTheMonthInterviewsData;
              _mainIssueOfTheMonthVisualAnthropologyData;
              _mainIssueOfTheMonthGISData;
              _mainIssueOfTheMonthForesightAndScenariosBuildingData;
              _mainIssueOfTheMonthPublicPerceptionSurveyData;
              _mainIssueOfTheMonthBehavioralDataData;
              _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData;
            }
          });

          readEmergenceIssueData
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[0])
              .forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _mainIssueOfTheMonthSocialMediaData.add(searchResult);
              });
            } else {
              _mainIssueOfTheMonthSocialMediaData;
            }
          });

          readEmergenceIssueData
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[1])
              .forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _mainIssueOfTheMonthSongData.add(searchResult);
              });
            } else {
              _mainIssueOfTheMonthSongData;
            }
          });

          readEmergenceIssueData
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[2])
              .forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _mainIssueOfTheMonthReligiousSpeechesData.add(searchResult);
              });
            } else {
              _mainIssueOfTheMonthReligiousSpeechesData;
            }
          });

          readEmergenceIssueData
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[3])
              .forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _mainIssueOfTheMonthInterviewsData.add(searchResult);
              });
            } else {
              _mainIssueOfTheMonthInterviewsData;
            }
          });

          readEmergenceIssueData
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[4])
              .forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _mainIssueOfTheMonthVisualAnthropologyData.add(searchResult);
              });
            } else {
              _mainIssueOfTheMonthVisualAnthropologyData;
            }
          });

          readEmergenceIssueData
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[5])
              .forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _mainIssueOfTheMonthGISData.add(searchResult);
              });
            } else {
              _mainIssueOfTheMonthGISData;
            }
          });

          readEmergenceIssueData
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[6])
              .forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _mainIssueOfTheMonthForesightAndScenariosBuildingData
                    .add(searchResult);
              });
            } else {
              _mainIssueOfTheMonthForesightAndScenariosBuildingData;
            }
          });

          readEmergenceIssueData
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[7])
              .forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _mainIssueOfTheMonthPublicPerceptionSurveyData
                    .add(searchResult);
              });
            } else {
              _mainIssueOfTheMonthPublicPerceptionSurveyData;
            }
          });

          readEmergenceIssueData
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[8])
              .forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _mainIssueOfTheMonthBehavioralDataData.add(searchResult);
              });
            } else {
              _mainIssueOfTheMonthBehavioralDataData;
            }
          });

          readEmergenceIssueData
              .where((element) =>
                  element.sourceCategory == qualitativeDataSourceList[9])
              .forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData
                    .add(searchResult);
              });
            } else {
              _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData;
            }
          });
        } else {
          setState(() {
            issueOfMonthFinalSearchDataList.clear();
            issueOfMonthFinalSearchDataList.addAll(readEmergenceIssueData);

            _mainIssueOfTheMonthSocialMediaData.clear();
            _mainIssueOfTheMonthSocialMediaData.addAll(
                readEmergenceIssueData.where((element) =>
                    element.sourceCategory == qualitativeDataSourceList[0]));

            _mainIssueOfTheMonthSongData.clear();
            _mainIssueOfTheMonthSongData.addAll(readEmergenceIssueData.where(
                (element) =>
                    element.sourceCategory == qualitativeDataSourceList[1]));

            _mainIssueOfTheMonthReligiousSpeechesData.clear();
            _mainIssueOfTheMonthReligiousSpeechesData.addAll(
                readEmergenceIssueData.where((element) =>
                    element.sourceCategory == qualitativeDataSourceList[2]));

            _mainIssueOfTheMonthInterviewsData.clear();
            _mainIssueOfTheMonthInterviewsData.addAll(
                readEmergenceIssueData.where((element) =>
                    element.sourceCategory == qualitativeDataSourceList[3]));

            _mainIssueOfTheMonthVisualAnthropologyData.clear();
            _mainIssueOfTheMonthVisualAnthropologyData.addAll(
                readEmergenceIssueData.where((element) =>
                    element.sourceCategory == qualitativeDataSourceList[4]));

            _mainIssueOfTheMonthGISData.clear();
            _mainIssueOfTheMonthGISData.addAll(readEmergenceIssueData.where(
                (element) =>
                    element.sourceCategory == qualitativeDataSourceList[5]));

            _mainIssueOfTheMonthForesightAndScenariosBuildingData.clear();
            _mainIssueOfTheMonthForesightAndScenariosBuildingData.addAll(
                readEmergenceIssueData.where((element) =>
                    element.sourceCategory == qualitativeDataSourceList[6]));

            _mainIssueOfTheMonthPublicPerceptionSurveyData.clear();
            _mainIssueOfTheMonthPublicPerceptionSurveyData.addAll(
                readEmergenceIssueData.where((element) =>
                    element.sourceCategory == qualitativeDataSourceList[7]));

            _mainIssueOfTheMonthBehavioralDataData.clear();
            _mainIssueOfTheMonthBehavioralDataData.addAll(
                readEmergenceIssueData.where((element) =>
                    element.sourceCategory == qualitativeDataSourceList[8]));

            _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData.clear();
            _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData.addAll(
                readEmergenceIssueData.where((element) =>
                    element.sourceCategory == qualitativeDataSourceList[9]));
          });
        }
      });
    });

    ///VARIABLES USED TO DETERMINE SCREEN SIZE
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    socialMediaSourceController.deselectAll();
    sentimentAnalysisController.deselectAll();
    languageController.deselectAll();
    sdgController.deselectAll();
    repetitionController.deselectAll();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return FutureBuilder(
      future: readEmergenceIssueDataFromJsonFile(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          return FutureBuilder(
            future: readEmergenceIssueFromJsonFile(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                return LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: buildAppBar(screenSize),
                    body: SafeArea(child: buildBody(screenSize)),
                  );
                });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  buildAppBar(Size screenSize) {
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: TopBarContentsWS(_opacity),
    );
  }

  buildBody(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          fit: FlexFit.loose,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  children: <Widget>[
                    IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildTopFiveEmergingIssuesOfTheMonth(screenSize),
                          SizedBox(height: screenSize.height * 0.05),
                          Row(
                            children: <Widget>[
                              buildIssuesOfTheMonthData(screenSize),
                              SizedBox(width: screenSize.width * 0.0095),
                              buildFilterData(screenSize),
                            ],
                          ),
                          SizedBox(height: screenSize.height / 10),
                          const BottomBar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///-------------------------- FOR TOP FIVE EMERGING ISSUES OF THE MONTH DATA --------------------------///

  buildTopFiveEmergingIssuesOfTheMonth(Size screenSize) {
    return IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.only(left: screenSize.width * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            EmergenceIssueOfTheMonthCardTileWS(
              emergingIssueName:
                  readEmergenceIssueJsonFileContent[0].emergingIssue!,
              time: readEmergenceIssueJsonFileContent[0].time == null
                  ? ""
                  : readEmergenceIssueJsonFileContent[0].time!,
              repetition:
                  readEmergenceIssueJsonFileContent[0].repetition == null
                      ? 0.0
                      : readEmergenceIssueJsonFileContent[0].repetition!,
              sdgTargeted:
                  readEmergenceIssueJsonFileContent[0].sdgTargeted == null
                      ? ""
                      : readEmergenceIssueJsonFileContent[0].sdgTargeted!,
            ),
            SizedBox(width: screenSize.width * 0.01),
            EmergenceIssueOfTheMonthCardTileWS(
              emergingIssueName:
                  readEmergenceIssueJsonFileContent[1].emergingIssue!,
              time: readEmergenceIssueJsonFileContent[1].time == null
                  ? ""
                  : readEmergenceIssueJsonFileContent[1].time!,
              repetition:
                  readEmergenceIssueJsonFileContent[1].repetition == null
                      ? 0.0
                      : readEmergenceIssueJsonFileContent[1].repetition!,
              sdgTargeted:
                  readEmergenceIssueJsonFileContent[1].sdgTargeted == null
                      ? ""
                      : readEmergenceIssueJsonFileContent[1].sdgTargeted!,
            ),
            SizedBox(width: screenSize.width * 0.01),
            EmergenceIssueOfTheMonthCardTileWS(
              emergingIssueName:
                  readEmergenceIssueJsonFileContent[2].emergingIssue!,
              time: readEmergenceIssueJsonFileContent[2].time == null
                  ? ""
                  : readEmergenceIssueJsonFileContent[2].time!,
              repetition:
                  readEmergenceIssueJsonFileContent[2].repetition == null
                      ? 0.0
                      : readEmergenceIssueJsonFileContent[2].repetition!,
              sdgTargeted:
                  readEmergenceIssueJsonFileContent[2].sdgTargeted == null
                      ? ""
                      : readEmergenceIssueJsonFileContent[2].sdgTargeted!,
            ),
            SizedBox(width: screenSize.width * 0.01),
            EmergenceIssueOfTheMonthCardTileWS(
              emergingIssueName:
                  readEmergenceIssueJsonFileContent[3].emergingIssue!,
              time: readEmergenceIssueJsonFileContent[3].time == null
                  ? ""
                  : readEmergenceIssueJsonFileContent[3].time!,
              repetition:
                  readEmergenceIssueJsonFileContent[3].repetition == null
                      ? 0.0
                      : readEmergenceIssueJsonFileContent[3].repetition!,
              sdgTargeted:
                  readEmergenceIssueJsonFileContent[3].sdgTargeted == null
                      ? ""
                      : readEmergenceIssueJsonFileContent[3].sdgTargeted!,
            ),
            SizedBox(width: screenSize.width * 0.01),
            EmergenceIssueOfTheMonthCardTileWS(
              emergingIssueName:
                  readEmergenceIssueJsonFileContent[4].emergingIssue!,
              time: readEmergenceIssueJsonFileContent[4].time == null
                  ? ""
                  : readEmergenceIssueJsonFileContent[4].time!,
              repetition:
                  readEmergenceIssueJsonFileContent[4].repetition == null
                      ? 0.0
                      : readEmergenceIssueJsonFileContent[4].repetition!,
              sdgTargeted:
                  readEmergenceIssueJsonFileContent[4].sdgTargeted == null
                      ? ""
                      : readEmergenceIssueJsonFileContent[4].sdgTargeted!,
            ),
          ],
        ),
      ),
    );
  }

  ///-------------------------- FOR ISSUES OF THE MONTH CHART --------------------------///

  void showIssuesOfTheMonthChartDialog(BuildContext context, Size screenSize) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, _setState) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Issues Of The Month',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    letterSpacing: 3,
                    fontFamily: 'Electrolize',
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.02,
                    //color: Colors.grey,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    repetitionChartFilterSelectedOption = 0.0;
                    emergenceIssueJsonFileContentFilter =
                        readEmergenceIssueJsonFileContent;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            content: SizedBox(
              width: screenSize.width * 0.75,
              height: screenSize.height * 0.75,
              child: Column(
                children: [
                  SizedBox(
                    width: screenSize.width * 0.45,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                _setState(() {
                                  repetitionChartFilterSelectedOption = 0.0;
                                  emergenceIssueJsonFileContentFilter =
                                      readEmergenceIssueJsonFileContent
                                          .where((element) => element
                                              .repetition!
                                              .toDouble()
                                              .isGreaterThan(0))
                                          .toList();
                                });
                              },
                              child: Row(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.bar_chart, size: 18),
                                    ],
                                  ),
                                  Row(
                                    children: const [Text("   > 0.0%")],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _setState(() {
                                  repetitionChartFilterSelectedOption = 20.0;
                                  emergenceIssueJsonFileContentFilter =
                                      readEmergenceIssueJsonFileContent
                                          .where((element) => element
                                              .repetition!
                                              .toDouble()
                                              .isGreaterThan(20))
                                          .toList();
                                });
                              },
                              child: Row(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.bar_chart, size: 18),
                                    ],
                                  ),
                                  Row(
                                    children: const [Text("   > 20.0%")],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _setState(() {
                                  repetitionChartFilterSelectedOption = 40.0;
                                  emergenceIssueJsonFileContentFilter =
                                      readEmergenceIssueJsonFileContent
                                          .where((element) => element
                                              .repetition!
                                              .toDouble()
                                              .isGreaterThan(40))
                                          .toList();
                                });
                              },
                              child: Row(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.bar_chart, size: 18),
                                    ],
                                  ),
                                  Row(
                                    children: const [Text("   > 40.0%")],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                _setState(() {
                                  repetitionChartFilterSelectedOption = 60.0;
                                  emergenceIssueJsonFileContentFilter =
                                      readEmergenceIssueJsonFileContent
                                          .where((element) => element
                                              .repetition!
                                              .toDouble()
                                              .isGreaterThan(60))
                                          .toList();
                                });
                              },
                              child: Row(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.bar_chart, size: 18),
                                    ],
                                  ),
                                  Row(
                                    children: const [Text("   > 60.0%")],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _setState(() {
                                  repetitionChartFilterSelectedOption = 80.0;
                                  emergenceIssueJsonFileContentFilter =
                                      readEmergenceIssueJsonFileContent
                                          .where((element) => element
                                              .repetition!
                                              .toDouble()
                                              .isGreaterThan(80))
                                          .toList();
                                });
                              },
                              child: Row(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.bar_chart, size: 18),
                                    ],
                                  ),
                                  Row(
                                    children: const [Text("   > 80.0%")],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _setState(() {
                                  repetitionChartFilterSelectedOption = 100.0;
                                  emergenceIssueJsonFileContentFilter =
                                      readEmergenceIssueJsonFileContent
                                          .where((element) => element
                                              .repetition!
                                              .toDouble()
                                              .isEqual(100))
                                          .toList();
                                });
                              },
                              child: Row(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.bar_chart, size: 18),
                                    ],
                                  ),
                                  Row(
                                    children: const [Text("   = 100.0%")],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buildIssuesOfTheMonthChart(
                      screenSize, emergenceIssueJsonFileContentFilter),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  buildIssuesOfTheMonthChart(Size screenSize,
      List<IssueOfMonthModel> emergenceIssueJsonFileContentFilterList) {
    return SizedBox(
      height: screenSize.height * 0.67,
      child: SfCartesianChart(
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          numberFormat: NumberFormat.decimalPercentPattern(),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        // Columns will be rendered back to back
        enableSideBySideSeriesPlacement: false,
        series: <ChartSeries<IssueOfMonthModel, String>>[
          BarSeries<IssueOfMonthModel, String>(
            name: "Issues Of The Month",
            dataSource: emergenceIssueJsonFileContentFilterList,
            xValueMapper: (IssueOfMonthModel data, _) =>
                data.emergingIssue == null ? "Issue" : data.emergingIssue!,
            yValueMapper: (IssueOfMonthModel data, _) =>
                data.repetition == null ? 0.0 : data.repetition! / 100,
            // pointColorMapper: (IssueOfMonthModel data, _) => Colors.grey.shade200,
            dataLabelSettings: const DataLabelSettings(
              isVisible: false,
            ),
            enableTooltip: true,
          ),
        ],
      ),
    );
  }

  ///-------------------------- FOR ISSUES OF THE MONTH DATA --------------------------///

  buildIssuesOfTheMonthData(Size screenSize) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: screenSize.height / 1.3,
        //screenSize.height * projectItems.length * 0.11 + 0.3,
        width: screenSize.width * 0.755,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 18,
                        left: screenSize.width * 0.01,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            // toast("Chart");
                            showIssuesOfTheMonthChartDialog(
                                context, screenSize);
                          },
                          onHover: (bool) {
                            toast(
                              "Showing the result of the AI as a chart",
                              bgColor: Colors.grey.shade200,
                            );
                          },
                          child: Material(
                            elevation: 2.0,
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            child: Icon(
                              Icons.bar_chart_sharp,
                              size: screenSize.width * 0.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.18),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Center(
                        child: Text(
                          "Data Analytics",
                          style: cardTitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        width: screenSize.width * 0.1,
                        height: screenSize.height * 0.05,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 5.0, bottom: 10.0),
                          child: TextField(
                            onChanged: (newSearchTerm) {
                              setState(() {
                                searchQuery = newSearchTerm;

                                issueOfMonthFinalSearchDataList =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                );

                                _mainIssueOfTheMonthSocialMediaData =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                )
                                        .where((element) =>
                                            element.sourceCategory ==
                                            qualitativeDataSourceList[0])
                                        .toList();

                                socialMediaDataPagerController
                                    .selectedPageIndex;

                                _mainIssueOfTheMonthSongData =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                )
                                        .where((element) =>
                                            element.sourceCategory ==
                                            qualitativeDataSourceList[1])
                                        .toList();

                                _mainIssueOfTheMonthReligiousSpeechesData =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                )
                                        .where((element) =>
                                            element.sourceCategory ==
                                            qualitativeDataSourceList[2])
                                        .toList();

                                _mainIssueOfTheMonthInterviewsData =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                )
                                        .where((element) =>
                                            element.sourceCategory ==
                                            qualitativeDataSourceList[3])
                                        .toList();

                                _mainIssueOfTheMonthVisualAnthropologyData =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                )
                                        .where((element) =>
                                            element.sourceCategory ==
                                            qualitativeDataSourceList[4])
                                        .toList();

                                _mainIssueOfTheMonthGISData =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                )
                                        .where((element) =>
                                            element.sourceCategory ==
                                            qualitativeDataSourceList[5])
                                        .toList();

                                _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                )
                                        .where((element) =>
                                            element.sourceCategory ==
                                            qualitativeDataSourceList[6])
                                        .toList();

                                _mainIssueOfTheMonthPublicPerceptionSurveyData =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                )
                                        .where((element) =>
                                            element.sourceCategory ==
                                            qualitativeDataSourceList[7])
                                        .toList();

                                _mainIssueOfTheMonthBehavioralDataData =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                )
                                        .where((element) =>
                                            element.sourceCategory ==
                                            qualitativeDataSourceList[8])
                                        .toList();

                                _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                                    textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                      readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                      sourceFilterSelectedOption,
                                  searchQuery: newSearchTerm.toLowerCase(),
                                  sentimentAnalysisFilterSelectedOption:
                                      sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption:
                                      languageSelectedOption,
                                  sdgSelectedOption: sdgSelectedOption,
                                  numberFilterSelectedOption:
                                      numberFilterSelectedOption,
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                )
                                        .where((element) =>
                                            element.sourceCategory ==
                                            qualitativeDataSourceList[9])
                                        .toList();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.005),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        width: screenSize.width * 0.04,
                        height: screenSize.height * 0.05,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 1.0, bottom: 10.0),
                          child: IconButton(
                            onPressed: () {
                              toast('Coming Soon');
                            },
                            icon: Icon(
                              Icons.print,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                buildSourcesDataContent(screenSize),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///-------------------------- FOR FILTER THROUGH ISSUES OF THE MONTH DATA --------------------------///

  MultiSelectController socialMediaSourceController = MultiSelectController();
  MultiSelectController sentimentAnalysisController = MultiSelectController();
  MultiSelectController languageController = MultiSelectController();
  MultiSelectController sdgController = MultiSelectController();
  MultiSelectController repetitionController = MultiSelectController();

  buildFilterData(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.77,
      width: screenSize.width * 0.205,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width / 5.5,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter',
                      style: cardTitleTextStyle,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          numberFilterSelectedOption = 'Choose One';
                          issueOfMonthFinalSearchDataList =
                              readEmergenceIssueDataJsonFileContent;

                          _mainIssueOfTheMonthSocialMediaData =
                              readEmergenceIssueDataJsonFileContent
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[0])
                                  .toList();
                          _mainIssueOfTheMonthSongData =
                              readEmergenceIssueDataJsonFileContent
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[1])
                                  .toList();
                          _mainIssueOfTheMonthReligiousSpeechesData =
                              readEmergenceIssueDataJsonFileContent
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[2])
                                  .toList();
                          _mainIssueOfTheMonthInterviewsData =
                              readEmergenceIssueDataJsonFileContent
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[3])
                                  .toList();
                          _mainIssueOfTheMonthVisualAnthropologyData =
                              readEmergenceIssueDataJsonFileContent
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[4])
                                  .toList();
                          _mainIssueOfTheMonthGISData =
                              readEmergenceIssueDataJsonFileContent
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[5])
                                  .toList();
                          _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                              readEmergenceIssueDataJsonFileContent
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[6])
                                  .toList();
                          _mainIssueOfTheMonthPublicPerceptionSurveyData =
                              readEmergenceIssueDataJsonFileContent
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[7])
                                  .toList();
                          _mainIssueOfTheMonthBehavioralDataData =
                              readEmergenceIssueDataJsonFileContent
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[8])
                                  .toList();
                          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              readEmergenceIssueDataJsonFileContent
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[9])
                                  .toList();

                          sourceFilterSelectedOption = [];

                          sentimentAnalysisFilterSelectedOption = [];

                          languageFilter = [];

                          sdgSelectedOption = [];
                          minValue = 0.0;
                          maxValue = 0.0;
                          value = 0.0;

                          socialMediaSourceController.deselectAll();
                          sentimentAnalysisController.deselectAll();
                          languageController.deselectAll();
                          sdgController.deselectAll();
                          repetitionController.deselectAll();
                        });
                      },
                      icon: const Icon(Icons.clear),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  maintainState: true,
                  title: const Text('Source'),
                  children: [
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                    ExpansionTile(
                      maintainState: true,
                      title: Text(qualitativeDataSourceList[0]),
                      children: [
                        MultiSelectCheckList(
                          controller: socialMediaSourceController,
                          maxSelectableCount: 5,
                          textStyles: const MultiSelectTextStyles(
                            selectedTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          itemsDecoration: MultiSelectDecorations(
                            selectedDecoration: BoxDecoration(
                              color: Colors.indigo.withOpacity(0.8),
                            ),
                          ),
                          listViewSettings: ListViewSettings(
                            separatorBuilder: (context, index) => const Divider(
                              height: 0,
                            ),
                          ),
                          items: List.generate(
                            socialMediaDataSource.length,
                            (index) => CheckListCard(
                              value: socialMediaDataSource[index],
                              title: Text(socialMediaDataSource[index]),
                              selectedColor: Colors.white,
                              checkColor: Colors.indigo,
                              selected: index == socialMediaDataSource.length,
                              enabled: !(index == socialMediaDataSource.length),
                              checkBoxBorderSide:
                                  const BorderSide(color: Colors.blue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onChange: (allSelectedItems, selectedItem) {
                            setState(() {
                              if (allSelectedItems.isNotEmpty) {
                                sourceFilterSelectedOption = allSelectedItems;
                              } else {
                                sourceFilterSelectedOption = [];
                              }

                              issueOfMonthFinalSearchDataList =
                                  textAnalysisFilterFunction(
                                readEmergenceIssueDataJsonFileContent:
                                    readEmergenceIssueDataJsonFileContent,
                                sourceFilterSelectedOption: allSelectedItems,
                                searchQuery: searchQuery,
                                sentimentAnalysisFilterSelectedOption:
                                    sentimentAnalysisFilterSelectedOption,
                                languageSelectedOption: languageSelectedOption,
                                sdgSelectedOption: sdgSelectedOption,
                                numberFilterSelectedOption:
                                    numberFilterSelectedOption,
                                minValue: minValue,
                                maxValue: maxValue,
                                value: value,
                              );

                              _mainIssueOfTheMonthSocialMediaData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[0])
                                      .toList();

                              _mainIssueOfTheMonthSongData = textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          allSelectedItems,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[1])
                                  .toList();

                              _mainIssueOfTheMonthReligiousSpeechesData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[2])
                                      .toList();

                              _mainIssueOfTheMonthInterviewsData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[3])
                                      .toList();

                              _mainIssueOfTheMonthVisualAnthropologyData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[4])
                                      .toList();

                              _mainIssueOfTheMonthGISData = textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          allSelectedItems,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[5])
                                  .toList();

                              _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[6])
                                      .toList();

                              _mainIssueOfTheMonthPublicPerceptionSurveyData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[7])
                                      .toList();

                              _mainIssueOfTheMonthBehavioralDataData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[8])
                                      .toList();

                              _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[9])
                                      .toList();
                            });
                          },
                          onMaximumSelected: (allSelectedItems, selectedItem) {
                            setState(() {
                              if (allSelectedItems.isNotEmpty) {
                                sourceFilterSelectedOption = allSelectedItems;
                              } else {
                                sourceFilterSelectedOption = [];
                              }

                              issueOfMonthFinalSearchDataList =
                                  textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          allSelectedItems,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value);

                              _mainIssueOfTheMonthSocialMediaData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[0])
                                      .toList();

                              _mainIssueOfTheMonthSongData = textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          allSelectedItems,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[1])
                                  .toList();

                              _mainIssueOfTheMonthReligiousSpeechesData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[2])
                                      .toList();

                              _mainIssueOfTheMonthInterviewsData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[3])
                                      .toList();

                              _mainIssueOfTheMonthVisualAnthropologyData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[4])
                                      .toList();

                              _mainIssueOfTheMonthGISData = textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          allSelectedItems,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[5])
                                  .toList();

                              _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[6])
                                      .toList();

                              _mainIssueOfTheMonthPublicPerceptionSurveyData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[7])
                                      .toList();

                              _mainIssueOfTheMonthBehavioralDataData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[8])
                                      .toList();

                              _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                                  textAnalysisFilterFunction(
                                          readEmergenceIssueDataJsonFileContent:
                                              readEmergenceIssueDataJsonFileContent,
                                          sourceFilterSelectedOption:
                                              allSelectedItems,
                                          searchQuery: searchQuery,
                                          sentimentAnalysisFilterSelectedOption:
                                              sentimentAnalysisFilterSelectedOption,
                                          languageSelectedOption:
                                              languageSelectedOption,
                                          sdgSelectedOption: sdgSelectedOption,
                                          numberFilterSelectedOption:
                                              numberFilterSelectedOption,
                                          minValue: minValue,
                                          maxValue: maxValue,
                                          value: value)
                                      .where((element) =>
                                          element.sourceCategory ==
                                          qualitativeDataSourceList[9])
                                      .toList();
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                    ExpansionTile(
                      maintainState: true,
                      title: Text(qualitativeDataSourceList[1]),
                      children: const [],
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                    ExpansionTile(
                      maintainState: true,
                      title: Text(qualitativeDataSourceList[2]),
                      children: const [],
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                    ExpansionTile(
                      maintainState: true,
                      title: Text(qualitativeDataSourceList[3]),
                      children: const [],
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                    ExpansionTile(
                      maintainState: true,
                      title: Text(qualitativeDataSourceList[4]),
                      children: const [],
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                    ExpansionTile(
                      maintainState: true,
                      title: Text(qualitativeDataSourceList[5]),
                      children: const [],
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                    ExpansionTile(
                      maintainState: true,
                      title: Text(qualitativeDataSourceList[6]),
                      children: const [],
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                    ExpansionTile(
                      maintainState: true,
                      title: Text(qualitativeDataSourceList[7]),
                      children: const [],
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                    ExpansionTile(
                      maintainState: true,
                      title: Text(qualitativeDataSourceList[8]),
                      children: const [],
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                    ExpansionTile(
                      maintainState: true,
                      title: Text(qualitativeDataSourceList[9]),
                      children: const [],
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  maintainState: true,
                  title: const Text('Sentiment Analysis'),
                  children: [
                    MultiSelectCheckList(
                      controller: sentimentAnalysisController,
                      maxSelectableCount: 5,
                      textStyles: const MultiSelectTextStyles(
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                      ),
                      listViewSettings: ListViewSettings(
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                      ),
                      items: List.generate(
                        sentimentAnalysisFilter.length,
                        (index) => CheckListCard(
                          value: sentimentAnalysisFilter[index],
                          title: Text(sentimentAnalysisFilter[index]),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected: index == sentimentAnalysisFilter.length,
                          enabled: !(index == sentimentAnalysisFilter.length),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            sentimentAnalysisFilterSelectedOption =
                                allSelectedItems;
                          } else {
                            sentimentAnalysisFilterSelectedOption = [];
                          }

                          issueOfMonthFinalSearchDataList =
                              textAnalysisFilterFunction(
                            readEmergenceIssueDataJsonFileContent:
                                readEmergenceIssueDataJsonFileContent,
                            sourceFilterSelectedOption:
                                sourceFilterSelectedOption,
                            searchQuery: searchQuery,
                            sentimentAnalysisFilterSelectedOption:
                                allSelectedItems,
                            languageSelectedOption: languageSelectedOption,
                            sdgSelectedOption: sdgSelectedOption,
                            numberFilterSelectedOption:
                                numberFilterSelectedOption,
                            minValue: minValue,
                            maxValue: maxValue,
                            value: value,
                          );

                          _mainIssueOfTheMonthSocialMediaData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[0])
                                  .toList();

                          _mainIssueOfTheMonthSongData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[1])
                                  .toList();

                          _mainIssueOfTheMonthReligiousSpeechesData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[2])
                                  .toList();

                          _mainIssueOfTheMonthInterviewsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[3])
                                  .toList();

                          _mainIssueOfTheMonthVisualAnthropologyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[4])
                                  .toList();

                          _mainIssueOfTheMonthGISData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[5])
                                  .toList();

                          _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[6])
                                  .toList();

                          _mainIssueOfTheMonthPublicPerceptionSurveyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[7])
                                  .toList();

                          _mainIssueOfTheMonthBehavioralDataData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[8])
                                  .toList();

                          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[9])
                                  .toList();
                        });
                      },
                      onMaximumSelected: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            sentimentAnalysisFilterSelectedOption =
                                allSelectedItems;
                          } else {
                            sentimentAnalysisFilterSelectedOption = [];
                          }
                          issueOfMonthFinalSearchDataList =
                              textAnalysisFilterFunction(
                            readEmergenceIssueDataJsonFileContent:
                                readEmergenceIssueDataJsonFileContent,
                            sourceFilterSelectedOption:
                                sourceFilterSelectedOption,
                            searchQuery: searchQuery,
                            sentimentAnalysisFilterSelectedOption:
                                allSelectedItems,
                            languageSelectedOption: languageSelectedOption,
                            sdgSelectedOption: sdgSelectedOption,
                            numberFilterSelectedOption:
                                numberFilterSelectedOption,
                            minValue: minValue,
                            maxValue: maxValue,
                            value: value,
                          );

                          _mainIssueOfTheMonthSocialMediaData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[0])
                                  .toList();

                          _mainIssueOfTheMonthSongData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[1])
                                  .toList();

                          _mainIssueOfTheMonthReligiousSpeechesData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[2])
                                  .toList();

                          _mainIssueOfTheMonthInterviewsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[3])
                                  .toList();

                          _mainIssueOfTheMonthVisualAnthropologyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[4])
                                  .toList();

                          _mainIssueOfTheMonthGISData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[5])
                                  .toList();

                          _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[6])
                                  .toList();

                          _mainIssueOfTheMonthPublicPerceptionSurveyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[7])
                                  .toList();

                          _mainIssueOfTheMonthBehavioralDataData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[8])
                                  .toList();

                          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          allSelectedItems,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[9])
                                  .toList();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  maintainState: true,
                  title: const Text('Repetition'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Number Filter',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.12,
                            height: screenSize.height * 0.05,
                            child: DropdownButton<String>(
                              key: Key(numberFilterSelectedOption),
                              underline:
                                  Container(height: 0.8, color: Colors.black45),
                              isExpanded: true,
                              value: numberFilterSelectedOption,
                              style: const TextStyle(fontSize: 12),
                              icon: const Icon(Icons.expand_more),
                              iconSize: 24,
                              elevation: 16,
                              onChanged: (String? newValue) {
                                setState(() {
                                  numberFilterSelectedOption = newValue!;

                                  minValue = 0.0;
                                  maxValue = 0.0;
                                  value = 0.0;

                                  issueOfMonthFinalSearchDataList =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  );

                                  _mainIssueOfTheMonthSocialMediaData =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  )
                                          .where((element) =>
                                              element.sourceCategory ==
                                              qualitativeDataSourceList[0])
                                          .toList();

                                  _mainIssueOfTheMonthSongData =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  )
                                          .where((element) =>
                                              element.sourceCategory ==
                                              qualitativeDataSourceList[1])
                                          .toList();

                                  _mainIssueOfTheMonthReligiousSpeechesData =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  )
                                          .where((element) =>
                                              element.sourceCategory ==
                                              qualitativeDataSourceList[2])
                                          .toList();

                                  _mainIssueOfTheMonthInterviewsData =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  )
                                          .where((element) =>
                                              element.sourceCategory ==
                                              qualitativeDataSourceList[3])
                                          .toList();

                                  _mainIssueOfTheMonthVisualAnthropologyData =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  )
                                          .where((element) =>
                                              element.sourceCategory ==
                                              qualitativeDataSourceList[4])
                                          .toList();

                                  _mainIssueOfTheMonthGISData =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  )
                                          .where((element) =>
                                              element.sourceCategory ==
                                              qualitativeDataSourceList[5])
                                          .toList();

                                  _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  )
                                          .where((element) =>
                                              element.sourceCategory ==
                                              qualitativeDataSourceList[6])
                                          .toList();

                                  _mainIssueOfTheMonthPublicPerceptionSurveyData =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  )
                                          .where((element) =>
                                              element.sourceCategory ==
                                              qualitativeDataSourceList[7])
                                          .toList();

                                  _mainIssueOfTheMonthBehavioralDataData =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  )
                                          .where((element) =>
                                              element.sourceCategory ==
                                              qualitativeDataSourceList[8])
                                          .toList();

                                  _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                                      textAnalysisFilterFunction(
                                    readEmergenceIssueDataJsonFileContent:
                                        readEmergenceIssueDataJsonFileContent,
                                    sourceFilterSelectedOption:
                                        sourceFilterSelectedOption,
                                    searchQuery: searchQuery,
                                    sentimentAnalysisFilterSelectedOption:
                                        sentimentAnalysisFilterSelectedOption,
                                    languageSelectedOption:
                                        languageSelectedOption,
                                    sdgSelectedOption: sdgSelectedOption,
                                    numberFilterSelectedOption: 'Choose One',
                                    minValue: minValue,
                                    maxValue: maxValue,
                                    value: value,
                                  )
                                          .where((element) =>
                                              element.sourceCategory ==
                                              qualitativeDataSourceList[9])
                                          .toList();
                                });
                              },
                              items: numberFilter.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    numberFilterSelectedOption == 'Choose One'
                        ? Container()
                        : numberFilterSelectedOption == "Between"
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: const Text(
                                            "Min Value",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: const Text(
                                            "Max Value",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: TextField(
                                            style:
                                                const TextStyle(fontSize: 12),
                                            onChanged: (newMinValue) {
                                              setState(() {
                                                value = 0.0;
                                                minValue =
                                                    newMinValue.toDouble();

                                                issueOfMonthFinalSearchDataList =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      numberFilterSelectedOption,
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                );

                                                _mainIssueOfTheMonthSocialMediaData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                0])
                                                        .toList();

                                                _mainIssueOfTheMonthSongData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                1])
                                                        .toList();

                                                _mainIssueOfTheMonthReligiousSpeechesData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                2])
                                                        .toList();

                                                _mainIssueOfTheMonthInterviewsData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                3])
                                                        .toList();

                                                _mainIssueOfTheMonthVisualAnthropologyData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                4])
                                                        .toList();

                                                _mainIssueOfTheMonthGISData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                5])
                                                        .toList();

                                                _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                6])
                                                        .toList();

                                                _mainIssueOfTheMonthPublicPerceptionSurveyData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                7])
                                                        .toList();

                                                _mainIssueOfTheMonthBehavioralDataData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                8])
                                                        .toList();

                                                _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue:
                                                      newMinValue.toDouble(),
                                                  maxValue: maxValue,
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                9])
                                                        .toList();
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: TextField(
                                            style:
                                                const TextStyle(fontSize: 12),
                                            onChanged: (newMaxValue) {
                                              setState(() {
                                                value = 0.0;
                                                maxValue =
                                                    newMaxValue.toDouble();

                                                issueOfMonthFinalSearchDataList =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      numberFilterSelectedOption,
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                );

                                                _mainIssueOfTheMonthSocialMediaData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                0])
                                                        .toList();

                                                _mainIssueOfTheMonthSongData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                1])
                                                        .toList();

                                                _mainIssueOfTheMonthReligiousSpeechesData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                2])
                                                        .toList();

                                                _mainIssueOfTheMonthInterviewsData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                3])
                                                        .toList();

                                                _mainIssueOfTheMonthVisualAnthropologyData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                4])
                                                        .toList();

                                                _mainIssueOfTheMonthGISData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                5])
                                                        .toList();

                                                _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                6])
                                                        .toList();

                                                _mainIssueOfTheMonthPublicPerceptionSurveyData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                7])
                                                        .toList();

                                                _mainIssueOfTheMonthBehavioralDataData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                8])
                                                        .toList();

                                                _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                                                    textAnalysisFilterFunction(
                                                  readEmergenceIssueDataJsonFileContent:
                                                      readEmergenceIssueDataJsonFileContent,
                                                  sourceFilterSelectedOption:
                                                      sourceFilterSelectedOption,
                                                  searchQuery: searchQuery,
                                                  sentimentAnalysisFilterSelectedOption:
                                                      sentimentAnalysisFilterSelectedOption,
                                                  languageSelectedOption:
                                                      languageSelectedOption,
                                                  sdgSelectedOption:
                                                      sdgSelectedOption,
                                                  numberFilterSelectedOption:
                                                      'Choose One',
                                                  minValue: minValue,
                                                  maxValue:
                                                      newMaxValue.toDouble(),
                                                  value: value,
                                                )
                                                        .where((element) =>
                                                            element
                                                                .sourceCategory ==
                                                            qualitativeDataSourceList[
                                                                9])
                                                        .toList();
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Value",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.11,
                                      child: TextField(
                                        style: const TextStyle(fontSize: 12),
                                        onChanged: (newValue) {
                                          setState(() {
                                            minValue = 0.0;
                                            maxValue = 0.0;
                                            value = newValue.toDouble();

                                            issueOfMonthFinalSearchDataList =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  numberFilterSelectedOption,
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            );

                                            _mainIssueOfTheMonthSocialMediaData =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  'Choose One',
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            )
                                                    .where((element) =>
                                                        element
                                                            .sourceCategory ==
                                                        qualitativeDataSourceList[
                                                            0])
                                                    .toList();

                                            _mainIssueOfTheMonthSongData =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  'Choose One',
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            )
                                                    .where((element) =>
                                                        element
                                                            .sourceCategory ==
                                                        qualitativeDataSourceList[
                                                            1])
                                                    .toList();

                                            _mainIssueOfTheMonthReligiousSpeechesData =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  'Choose One',
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            )
                                                    .where((element) =>
                                                        element
                                                            .sourceCategory ==
                                                        qualitativeDataSourceList[
                                                            2])
                                                    .toList();

                                            _mainIssueOfTheMonthInterviewsData =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  'Choose One',
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            )
                                                    .where((element) =>
                                                        element
                                                            .sourceCategory ==
                                                        qualitativeDataSourceList[
                                                            3])
                                                    .toList();

                                            _mainIssueOfTheMonthVisualAnthropologyData =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  'Choose One',
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            )
                                                    .where((element) =>
                                                        element
                                                            .sourceCategory ==
                                                        qualitativeDataSourceList[
                                                            4])
                                                    .toList();

                                            _mainIssueOfTheMonthGISData =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  'Choose One',
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            )
                                                    .where((element) =>
                                                        element
                                                            .sourceCategory ==
                                                        qualitativeDataSourceList[
                                                            5])
                                                    .toList();

                                            _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  'Choose One',
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            )
                                                    .where((element) =>
                                                        element
                                                            .sourceCategory ==
                                                        qualitativeDataSourceList[
                                                            6])
                                                    .toList();

                                            _mainIssueOfTheMonthPublicPerceptionSurveyData =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  'Choose One',
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            )
                                                    .where((element) =>
                                                        element
                                                            .sourceCategory ==
                                                        qualitativeDataSourceList[
                                                            7])
                                                    .toList();

                                            _mainIssueOfTheMonthBehavioralDataData =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  'Choose One',
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            )
                                                    .where((element) =>
                                                        element
                                                            .sourceCategory ==
                                                        qualitativeDataSourceList[
                                                            8])
                                                    .toList();

                                            _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                                                textAnalysisFilterFunction(
                                              readEmergenceIssueDataJsonFileContent:
                                                  readEmergenceIssueDataJsonFileContent,
                                              sourceFilterSelectedOption:
                                                  sourceFilterSelectedOption,
                                              searchQuery: searchQuery,
                                              sentimentAnalysisFilterSelectedOption:
                                                  sentimentAnalysisFilterSelectedOption,
                                              languageSelectedOption:
                                                  languageSelectedOption,
                                              sdgSelectedOption:
                                                  sdgSelectedOption,
                                              numberFilterSelectedOption:
                                                  'Choose One',
                                              minValue: minValue,
                                              maxValue: maxValue,
                                              value: newValue.toDouble(),
                                            )
                                                    .where((element) =>
                                                        element
                                                            .sourceCategory ==
                                                        qualitativeDataSourceList[
                                                            9])
                                                    .toList();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  maintainState: true,
                  title: const Text('Language'),
                  children: [
                    MultiSelectCheckList(
                      controller: languageController,
                      maxSelectableCount: 5,
                      textStyles: const MultiSelectTextStyles(
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                      ),
                      listViewSettings: ListViewSettings(
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                      ),
                      items: List.generate(
                        languageFilter.length,
                        (index) => CheckListCard(
                          value: languageFilter[index],
                          title: Text(languageFilter[index]),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected: index == languageFilter.length,
                          enabled: !(index == languageFilter.length),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            languageSelectedOption = allSelectedItems;
                          } else {
                            languageSelectedOption = [];
                          }

                          issueOfMonthFinalSearchDataList =
                              textAnalysisFilterFunction(
                            readEmergenceIssueDataJsonFileContent:
                                readEmergenceIssueDataJsonFileContent,
                            sourceFilterSelectedOption:
                                sourceFilterSelectedOption,
                            searchQuery: searchQuery,
                            sentimentAnalysisFilterSelectedOption:
                                sentimentAnalysisFilterSelectedOption,
                            languageSelectedOption: allSelectedItems,
                            sdgSelectedOption: sdgSelectedOption,
                            numberFilterSelectedOption:
                                numberFilterSelectedOption,
                            minValue: minValue,
                            maxValue: maxValue,
                            value: value,
                          );

                          _mainIssueOfTheMonthSocialMediaData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[0])
                                  .toList();

                          _mainIssueOfTheMonthSongData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[1])
                                  .toList();

                          _mainIssueOfTheMonthReligiousSpeechesData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[2])
                                  .toList();

                          _mainIssueOfTheMonthInterviewsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[3])
                                  .toList();

                          _mainIssueOfTheMonthVisualAnthropologyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[4])
                                  .toList();

                          _mainIssueOfTheMonthGISData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[5])
                                  .toList();

                          _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[6])
                                  .toList();

                          _mainIssueOfTheMonthPublicPerceptionSurveyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[7])
                                  .toList();

                          _mainIssueOfTheMonthBehavioralDataData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[8])
                                  .toList();

                          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[9])
                                  .toList();
                        });
                      },
                      onMaximumSelected: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            languageSelectedOption = allSelectedItems;
                          } else {
                            languageSelectedOption = [];
                          }

                          issueOfMonthFinalSearchDataList =
                              textAnalysisFilterFunction(
                            readEmergenceIssueDataJsonFileContent:
                                readEmergenceIssueDataJsonFileContent,
                            sourceFilterSelectedOption:
                                sourceFilterSelectedOption,
                            searchQuery: searchQuery,
                            sentimentAnalysisFilterSelectedOption:
                                sentimentAnalysisFilterSelectedOption,
                            languageSelectedOption: allSelectedItems,
                            sdgSelectedOption: sdgSelectedOption,
                            numberFilterSelectedOption:
                                numberFilterSelectedOption,
                            minValue: minValue,
                            maxValue: maxValue,
                            value: value,
                          );

                          _mainIssueOfTheMonthSocialMediaData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[0])
                                  .toList();

                          _mainIssueOfTheMonthSongData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[1])
                                  .toList();

                          _mainIssueOfTheMonthReligiousSpeechesData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[2])
                                  .toList();

                          _mainIssueOfTheMonthInterviewsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[3])
                                  .toList();

                          _mainIssueOfTheMonthVisualAnthropologyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[4])
                                  .toList();

                          _mainIssueOfTheMonthGISData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[5])
                                  .toList();

                          _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[6])
                                  .toList();

                          _mainIssueOfTheMonthPublicPerceptionSurveyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[7])
                                  .toList();

                          _mainIssueOfTheMonthBehavioralDataData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[8])
                                  .toList();

                          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption: allSelectedItems,
                                      sdgSelectedOption: sdgSelectedOption,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[9])
                                  .toList();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  maintainState: true,
                  title: const Text('SDG'),
                  children: [
                    MultiSelectCheckList(
                      controller: sdgController,
                      maxSelectableCount: 5,
                      textStyles: const MultiSelectTextStyles(
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                      ),
                      listViewSettings: ListViewSettings(
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                      ),
                      items: List.generate(
                        sdgGoalsList!.length,
                        (index) => CheckListCard(
                          value: sdgGoalsList![index],
                          title: Text(sdgGoalsList![index]),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected: index == sdgGoalsList!.length,
                          enabled: !(index == sdgGoalsList!.length),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            sdgSelectedOption = allSelectedItems;
                          } else {
                            sdgSelectedOption = [];
                          }

                          issueOfMonthFinalSearchDataList =
                              textAnalysisFilterFunction(
                            readEmergenceIssueDataJsonFileContent:
                                readEmergenceIssueDataJsonFileContent,
                            sourceFilterSelectedOption:
                                sourceFilterSelectedOption,
                            searchQuery: searchQuery,
                            sentimentAnalysisFilterSelectedOption:
                                sentimentAnalysisFilterSelectedOption,
                            languageSelectedOption: languageSelectedOption,
                            sdgSelectedOption: allSelectedItems,
                            numberFilterSelectedOption:
                                numberFilterSelectedOption,
                            minValue: minValue,
                            maxValue: maxValue,
                            value: value,
                          );

                          _mainIssueOfTheMonthSocialMediaData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[0])
                                  .toList();

                          _mainIssueOfTheMonthSongData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[1])
                                  .toList();

                          _mainIssueOfTheMonthReligiousSpeechesData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[2])
                                  .toList();

                          _mainIssueOfTheMonthInterviewsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[3])
                                  .toList();

                          _mainIssueOfTheMonthVisualAnthropologyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[4])
                                  .toList();

                          _mainIssueOfTheMonthGISData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[5])
                                  .toList();

                          _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[6])
                                  .toList();

                          _mainIssueOfTheMonthPublicPerceptionSurveyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[7])
                                  .toList();

                          _mainIssueOfTheMonthBehavioralDataData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[8])
                                  .toList();

                          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[9])
                                  .toList();
                        });
                      },
                      onMaximumSelected: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            sdgSelectedOption = allSelectedItems;
                          } else {
                            sdgSelectedOption = [];
                          }

                          issueOfMonthFinalSearchDataList =
                              textAnalysisFilterFunction(
                            readEmergenceIssueDataJsonFileContent:
                                readEmergenceIssueDataJsonFileContent,
                            sourceFilterSelectedOption:
                                sourceFilterSelectedOption,
                            searchQuery: searchQuery,
                            sentimentAnalysisFilterSelectedOption:
                                sentimentAnalysisFilterSelectedOption,
                            languageSelectedOption: languageSelectedOption,
                            sdgSelectedOption: allSelectedItems,
                            numberFilterSelectedOption:
                                numberFilterSelectedOption,
                            minValue: minValue,
                            maxValue: maxValue,
                            value: value,
                          );

                          _mainIssueOfTheMonthSocialMediaData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[0])
                                  .toList();

                          _mainIssueOfTheMonthSongData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[1])
                                  .toList();

                          _mainIssueOfTheMonthReligiousSpeechesData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[2])
                                  .toList();

                          _mainIssueOfTheMonthInterviewsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[3])
                                  .toList();

                          _mainIssueOfTheMonthVisualAnthropologyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[4])
                                  .toList();

                          _mainIssueOfTheMonthGISData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[5])
                                  .toList();

                          _mainIssueOfTheMonthForesightAndScenariosBuildingData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[6])
                                  .toList();

                          _mainIssueOfTheMonthPublicPerceptionSurveyData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[7])
                                  .toList();

                          _mainIssueOfTheMonthBehavioralDataData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[8])
                                  .toList();

                          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              textAnalysisFilterFunction(
                                      readEmergenceIssueDataJsonFileContent:
                                          readEmergenceIssueDataJsonFileContent,
                                      sourceFilterSelectedOption:
                                          sourceFilterSelectedOption,
                                      searchQuery: searchQuery,
                                      sentimentAnalysisFilterSelectedOption:
                                          sentimentAnalysisFilterSelectedOption,
                                      languageSelectedOption:
                                          languageSelectedOption,
                                      sdgSelectedOption: allSelectedItems,
                                      numberFilterSelectedOption:
                                          numberFilterSelectedOption,
                                      minValue: minValue,
                                      maxValue: maxValue,
                                      value: value)
                                  .where((element) =>
                                      element.sourceCategory ==
                                      qualitativeDataSourceList[9])
                                  .toList();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  ///-------------------------- FOR BUILDING THE PAGINATION --------------------------///

  ///BUILD PAGES VARIABLES
  static const double dataPagerHeight = 70.0;

  ///BUILD PAGES WIDGET

  void rebuildList() {
    setState(() {});
  }

  buildSourcesDataContent(Size screenSize) {
    return Column(
      children: [
        buildSocialMediaDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[0],
          _mainIssueOfTheMonthSocialMediaData,
        ),
        buildSongDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[1],
          _mainIssueOfTheMonthSongData,
        ),
        buildReligiousSpeechesDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[2],
          _mainIssueOfTheMonthReligiousSpeechesData,
        ),
        buildInterviewsDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[3],
          _mainIssueOfTheMonthInterviewsData,
        ),
        buildVisualAnthropologyDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[4],
          _mainIssueOfTheMonthVisualAnthropologyData,
        ),
        buildGISDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[5],
          _mainIssueOfTheMonthGISData,
        ),
        buildForesightAndScenariosBuildingDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[6],
          _mainIssueOfTheMonthForesightAndScenariosBuildingData,
        ),
        buildPublicPerceptionSurveyDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[7],
          _mainIssueOfTheMonthPublicPerceptionSurveyData,
        ),
        buildBehavioralDataDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[8],
          _mainIssueOfTheMonthBehavioralDataData,
        ),
        buildOpinionDynamicsAndSociophysicsDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[9],
          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData,
        ),
      ],
    );
  }

  buildSourcesDataContentHeader(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox(width: 2),
        SizedBox(
          width: screenSize.width * 0.25,
          child: const Text(
            'Source',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          width: screenSize.width * 0.25,
          child: const Text(
            'String',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          width: screenSize.width * 0.1,
          child: const Text(
            'Repetition',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const Text(
          'Sentiment Analysis',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  ///-------------------------------- SOCIAL MEDIA --------------------------------///

  bool showSocialMediaLoadingIndicator = false;

  double socialMediaPageCount = 0;

  late DataPagerController socialMediaDataPagerController = DataPagerController();

  buildSocialMediaDataContentWithHeading(
      Size screenSize,
      String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_mainIssueOfTheMonthSocialMediaData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _mainIssueOfTheMonthSocialMediaData.isEmpty
                      ? Container()
                      : buildSocialMediaDataContent(screenSize),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildSocialMediaDataContent(Size screenSize) {
    socialMediaPageCount =
        (_mainIssueOfTheMonthSocialMediaData.length / _rowsPerPage)
            .ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadSocialMediaListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                controller: socialMediaDataPagerController,
                // key: PageStorageKey(_mainIssueOfTheMonthSocialMediaData),
                pageCount: socialMediaPageCount,
                /* availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _socialMediaRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },*/
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showSocialMediaLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showSocialMediaLoadingIndicator = false;
                  });
                },
                delegate:
                    CustomSliverChildBuilderDelegateMainIssueOfTheMonthSocialMediaData(
                  indexSocialMediaBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadSocialMediaListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_mainIssueOfTheMonthSocialMediaData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate:
                CustomSliverChildBuilderDelegateMainIssueOfTheMonthSocialMediaData(
                    indexSocialMediaBuilder),
          ),
        );
      }

      if (showSocialMediaLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexSocialMediaBuilder(BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _mainPaginatedIssueOfTheMonthSocialMediaData[index]
                                        .source ==
                                    null
                                ? ""
                                : _mainPaginatedIssueOfTheMonthSocialMediaData[
                                        index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              _mainPaginatedIssueOfTheMonthSocialMediaData[
                                              index]
                                          .source ==
                                      null
                                  ? ""
                                  : _mainPaginatedIssueOfTheMonthSocialMediaData[
                                          index]
                                      .source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthSocialMediaData[index]
                                    .issueString ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthSocialMediaData[
                                    index]
                                .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthSocialMediaData[index]
                                    .repetition ==
                                null
                            ? ""
                            : '${_mainPaginatedIssueOfTheMonthSocialMediaData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthSocialMediaData[index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthSocialMediaData[
                                    index]
                                .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _mainPaginatedIssueOfTheMonthSocialMediaData[index]
                                  .sentimentAnalysis ==
                              "Negative"
                          ? Colors.red
                          : _mainPaginatedIssueOfTheMonthSocialMediaData[index]
                                      .sentimentAnalysis ==
                                  "Neutral"
                              ? Colors.yellow
                              : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///-------------------------------- SONG --------------------------------///

  bool showSongLoadingIndicator = false;

  double songPageCount = 0;

  buildSongDataContentWithHeading(
      Size screenSize,
      String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_mainIssueOfTheMonthSongData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _mainIssueOfTheMonthSongData.isEmpty
                      ? Container()
                      : buildSongDataContent(screenSize),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildSongDataContent(Size screenSize) {
    songPageCount =
        (_mainIssueOfTheMonthSongData.length / _rowsPerPage).ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadSongListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: songPageCount,
                /* availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _songRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },*/
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showSongLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showSongLoadingIndicator = false;
                  });
                },
                delegate:
                    CustomSliverChildBuilderDelegateMainIssueOfTheMonthSongData(
                  indexSongBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadSongListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_mainIssueOfTheMonthSongData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate:
                CustomSliverChildBuilderDelegateMainIssueOfTheMonthSongData(
                    indexSongBuilder),
          ),
        );
      }

      if (showSongLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexSongBuilder(BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _mainPaginatedIssueOfTheMonthSongData[index]
                                        .source ==
                                    null
                                ? ""
                                : _mainPaginatedIssueOfTheMonthSongData[index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              _mainPaginatedIssueOfTheMonthSongData[index]
                                          .source ==
                                      null
                                  ? ""
                                  : _mainPaginatedIssueOfTheMonthSongData[index]
                                      .source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthSongData[index]
                                    .issueString ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthSongData[index]
                                .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthSongData[index]
                                    .repetition ==
                                null
                            ? ""
                            : '${_mainPaginatedIssueOfTheMonthSongData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthSongData[index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthSongData[index]
                                .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _mainPaginatedIssueOfTheMonthSongData[index]
                                  .sentimentAnalysis ==
                              "Negative"
                          ? Colors.red
                          : _mainPaginatedIssueOfTheMonthSongData[index]
                                      .sentimentAnalysis ==
                                  "Neutral"
                              ? Colors.yellow
                              : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///-------------------------------- Religious Speeches (Friday prayer's Khutbah)--------------------------------///

  bool showReligiousSpeechesLoadingIndicator = false;

  double religiousSpeechesPageCount = 0;

  buildReligiousSpeechesDataContentWithHeading(
      Size screenSize,
      String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_mainIssueOfTheMonthReligiousSpeechesData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _mainIssueOfTheMonthReligiousSpeechesData.isEmpty
                      ? Container()
                      : buildReligiousSpeechesDataContent(screenSize),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildReligiousSpeechesDataContent(Size screenSize) {
    religiousSpeechesPageCount =
        (_mainIssueOfTheMonthReligiousSpeechesData.length / _rowsPerPage)
            .ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadReligiousSpeechesListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: religiousSpeechesPageCount,
                /*availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _religiousSpeechesRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },*/
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showReligiousSpeechesLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showReligiousSpeechesLoadingIndicator = false;
                  });
                },
                delegate:
                    CustomSliverChildBuilderDelegateMainIssueOfTheMonthReligiousSpeechesData(
                        indexReligiousSpeechesBuilder)
                      ..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadReligiousSpeechesListView(
      BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_mainIssueOfTheMonthReligiousSpeechesData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate:
                CustomSliverChildBuilderDelegateMainIssueOfTheMonthReligiousSpeechesData(
                    indexReligiousSpeechesBuilder),
          ),
        );
      }

      if (showReligiousSpeechesLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexReligiousSpeechesBuilder(BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                            index]
                                        .source ==
                                    null
                                ? ""
                                : _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                        index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                              index]
                                          .source ==
                                      null
                                  ? ""
                                  : _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                          index]
                                      .source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                        index]
                                    .issueString ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                    index]
                                .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                        index]
                                    .repetition ==
                                null
                            ? ""
                            : '${_mainPaginatedIssueOfTheMonthReligiousSpeechesData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                        index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                    index]
                                .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                      index]
                                  .sentimentAnalysis ==
                              "Negative"
                          ? Colors.red
                          : _mainPaginatedIssueOfTheMonthReligiousSpeechesData[
                                          index]
                                      .sentimentAnalysis ==
                                  "Neutral"
                              ? Colors.yellow
                              : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///-------------------------------- Interviews --------------------------------///

  bool showInterviewsLoadingIndicator = false;

  double interviewsPageCount = 0;

  buildInterviewsDataContentWithHeading(
      Size screenSize,
      String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_mainIssueOfTheMonthInterviewsData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _mainIssueOfTheMonthInterviewsData.isEmpty
                      ? Container()
                      : buildInterviewsDataContent(screenSize),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildInterviewsDataContent(Size screenSize) {
    interviewsPageCount =
        (_mainIssueOfTheMonthInterviewsData.length / _rowsPerPage)
            .ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadInterviewsListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: interviewsPageCount,
                /* availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _interviewsRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },*/
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showInterviewsLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showInterviewsLoadingIndicator = false;
                  });
                },
                delegate:
                    CustomSliverChildBuilderDelegateMainIssueOfTheMonthInterviewsData(
                  indexInterviewsBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadInterviewsListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_mainIssueOfTheMonthInterviewsData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate:
                CustomSliverChildBuilderDelegateMainIssueOfTheMonthInterviewsData(
                    indexInterviewsBuilder),
          ),
        );
      }

      if (showInterviewsLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexInterviewsBuilder(BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _mainPaginatedIssueOfTheMonthInterviewsData[index]
                                        .source ==
                                    null
                                ? ""
                                : _mainPaginatedIssueOfTheMonthInterviewsData[
                                        index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              _mainPaginatedIssueOfTheMonthInterviewsData[index]
                                          .source ==
                                      null
                                  ? ""
                                  : _mainPaginatedIssueOfTheMonthInterviewsData[
                                          index]
                                      .source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthInterviewsData[index]
                                    .issueString ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthInterviewsData[index]
                                .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthInterviewsData[index]
                                    .repetition ==
                                null
                            ? ""
                            : '${_mainPaginatedIssueOfTheMonthInterviewsData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthInterviewsData[index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthInterviewsData[index]
                                .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _mainPaginatedIssueOfTheMonthInterviewsData[index]
                                  .sentimentAnalysis ==
                              "Negative"
                          ? Colors.red
                          : _mainPaginatedIssueOfTheMonthInterviewsData[index]
                                      .sentimentAnalysis ==
                                  "Neutral"
                              ? Colors.yellow
                              : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///-------------------------------- Visual Anthropology --------------------------------///

  bool showVisualAnthropologyLoadingIndicator = false;

  double visualAnthropologyPageCount = 0;

  buildVisualAnthropologyDataContentWithHeading(
      Size screenSize,
      String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_mainIssueOfTheMonthVisualAnthropologyData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _mainIssueOfTheMonthVisualAnthropologyData.isEmpty
                      ? Container()
                      : buildVisualAnthropologyDataContent(screenSize),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildVisualAnthropologyDataContent(Size screenSize) {
    visualAnthropologyPageCount =
        (_mainIssueOfTheMonthVisualAnthropologyData.length / _rowsPerPage)
            .ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadVisualAnthropologyListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: visualAnthropologyPageCount,
                /*availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _visualAnthropologyRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },*/
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showVisualAnthropologyLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showVisualAnthropologyLoadingIndicator = false;
                  });
                },
                delegate:
                    CustomSliverChildBuilderDelegateMainIssueOfTheMonthVisualAnthropologyData(
                  indexVisualAnthropologyBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadVisualAnthropologyListView(
      BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_mainIssueOfTheMonthVisualAnthropologyData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate:
                CustomSliverChildBuilderDelegateMainIssueOfTheMonthVisualAnthropologyData(
                    indexVisualAnthropologyBuilder),
          ),
        );
      }

      if (showVisualAnthropologyLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexVisualAnthropologyBuilder(BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                            index]
                                        .source ==
                                    null
                                ? ""
                                : _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                        index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                              index]
                                          .source ==
                                      null
                                  ? ""
                                  : _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                          index]
                                      .source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                        index]
                                    .issueString ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                    index]
                                .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                        index]
                                    .repetition ==
                                null
                            ? ""
                            : '${_mainPaginatedIssueOfTheMonthVisualAnthropologyData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                        index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                    index]
                                .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                      index]
                                  .sentimentAnalysis ==
                              "Negative"
                          ? Colors.red
                          : _mainPaginatedIssueOfTheMonthVisualAnthropologyData[
                                          index]
                                      .sentimentAnalysis ==
                                  "Neutral"
                              ? Colors.yellow
                              : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///-------------------------------- GIS --------------------------------///

  bool showGISLoadingIndicator = false;

  double gisPageCount = 0;

  buildGISDataContentWithHeading(
      Size screenSize,
      String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_mainIssueOfTheMonthGISData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _mainIssueOfTheMonthGISData.isEmpty
                      ? Container()
                      : buildGISDataContent(screenSize),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildGISDataContent(Size screenSize) {
    gisPageCount =
        (_mainIssueOfTheMonthGISData.length / _rowsPerPage).ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadGISListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: gisPageCount,
                /*availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _gisRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },*/
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showGISLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showGISLoadingIndicator = false;
                  });
                },
                delegate:
                    CustomSliverChildBuilderDelegateMainIssueOfTheMonthGISData(
                  indexGISBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadGISListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_mainIssueOfTheMonthGISData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate:
                CustomSliverChildBuilderDelegateMainIssueOfTheMonthGISData(
                    indexGISBuilder),
          ),
        );
      }

      if (showGISLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexGISBuilder(BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _mainPaginatedIssueOfTheMonthGISData[index]
                                        .source ==
                                    null
                                ? ""
                                : _mainPaginatedIssueOfTheMonthGISData[index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              _mainPaginatedIssueOfTheMonthGISData[index]
                                          .source ==
                                      null
                                  ? ""
                                  : _mainPaginatedIssueOfTheMonthGISData[index]
                                      .source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthGISData[index]
                                    .issueString ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthGISData[index]
                                .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthGISData[index]
                                    .repetition ==
                                null
                            ? ""
                            : '${_mainPaginatedIssueOfTheMonthGISData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthGISData[index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthGISData[index]
                                .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _mainPaginatedIssueOfTheMonthGISData[index]
                                  .sentimentAnalysis ==
                              "Negative"
                          ? Colors.red
                          : _mainPaginatedIssueOfTheMonthGISData[index]
                                      .sentimentAnalysis ==
                                  "Neutral"
                              ? Colors.yellow
                              : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///-------------------------------- Foresight and Scenarios Building --------------------------------///

  bool showForesightAndScenariosBuildingLoadingIndicator = false;

  double foresightAndScenariosBuildingPageCount = 0;

  buildForesightAndScenariosBuildingDataContentWithHeading(
      Size screenSize,
      String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_mainIssueOfTheMonthForesightAndScenariosBuildingData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _mainIssueOfTheMonthForesightAndScenariosBuildingData.isEmpty
                      ? Container()
                      : buildForesightAndScenariosBuildingDataContent(
                          screenSize),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildForesightAndScenariosBuildingDataContent(Size screenSize) {
    foresightAndScenariosBuildingPageCount =
        (_mainIssueOfTheMonthForesightAndScenariosBuildingData.length /
                _rowsPerPage)
            .ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadForesightAndScenariosBuildingListView(
                  constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: foresightAndScenariosBuildingPageCount,
                /*availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _foresightAndScenariosBuildingRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },*/
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showForesightAndScenariosBuildingLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showForesightAndScenariosBuildingLoadingIndicator = false;
                  });
                },
                delegate:
                    CustomSliverChildBuilderDelegateMainIssueOfTheMonthForesightAndScenariosBuildingData(
                  indexForesightAndScenariosBuildingBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadForesightAndScenariosBuildingListView(
      BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_mainIssueOfTheMonthForesightAndScenariosBuildingData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate:
                CustomSliverChildBuilderDelegateMainIssueOfTheMonthForesightAndScenariosBuildingData(
                    indexForesightAndScenariosBuildingBuilder),
          ),
        );
      }

      if (showForesightAndScenariosBuildingLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexForesightAndScenariosBuildingBuilder(
      BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                            index]
                                        .source ==
                                    null
                                ? ""
                                : _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                        index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                              index]
                                          .source ==
                                      null
                                  ? ""
                                  : _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                          index]
                                      .source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                        index]
                                    .issueString ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                    index]
                                .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                        index]
                                    .repetition ==
                                null
                            ? ""
                            : '${_mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                        index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                    index]
                                .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                      index]
                                  .sentimentAnalysis ==
                              "Negative"
                          ? Colors.red
                          : _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData[
                                          index]
                                      .sentimentAnalysis ==
                                  "Neutral"
                              ? Colors.yellow
                              : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///-------------------------------- Public Perception Survey--------------------------------///

  bool showPublicPerceptionSurveyLoadingIndicator = false;

  double publicPerceptionSurveyPageCount = 0;

  buildPublicPerceptionSurveyDataContentWithHeading(
      Size screenSize,
      String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_mainIssueOfTheMonthPublicPerceptionSurveyData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _mainIssueOfTheMonthPublicPerceptionSurveyData.isEmpty
                      ? Container()
                      : buildPublicPerceptionSurveyDataContent(screenSize),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildPublicPerceptionSurveyDataContent(Size screenSize) {
    publicPerceptionSurveyPageCount =
        (_mainIssueOfTheMonthPublicPerceptionSurveyData.length / _rowsPerPage)
            .ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadPublicPerceptionSurveyListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: publicPerceptionSurveyPageCount,
                /*availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _publicPerceptionSurveyRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },*/
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showPublicPerceptionSurveyLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showPublicPerceptionSurveyLoadingIndicator = false;
                  });
                },
                delegate:
                    CustomSliverChildBuilderDelegateMainIssueOfTheMonthPublicPerceptionSurveyData(
                  indexPublicPerceptionSurveyBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadPublicPerceptionSurveyListView(
      BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_mainIssueOfTheMonthPublicPerceptionSurveyData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate:
                CustomSliverChildBuilderDelegateMainIssueOfTheMonthPublicPerceptionSurveyData(
                    indexPublicPerceptionSurveyBuilder),
          ),
        );
      }

      if (showPublicPerceptionSurveyLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexPublicPerceptionSurveyBuilder(BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                            index]
                                        .source ==
                                    null
                                ? ""
                                : _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                        index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                              index]
                                          .source ==
                                      null
                                  ? ""
                                  : _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                          index]
                                      .source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                        index]
                                    .issueString ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                    index]
                                .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                        index]
                                    .repetition ==
                                null
                            ? ""
                            : '${_mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                        index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                    index]
                                .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                      index]
                                  .sentimentAnalysis ==
                              "Negative"
                          ? Colors.red
                          : _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData[
                                          index]
                                      .sentimentAnalysis ==
                                  "Neutral"
                              ? Colors.yellow
                              : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///-------------------------------- Behavioral Data --------------------------------///

  bool showBehavioralDataLoadingIndicator = false;

  double behavioralDataPageCount = 0;

  buildBehavioralDataDataContentWithHeading(
      Size screenSize,
      String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_mainIssueOfTheMonthBehavioralDataData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _mainIssueOfTheMonthBehavioralDataData.isEmpty
                      ? Container()
                      : buildBehavioralDataDataContent(screenSize),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildBehavioralDataDataContent(Size screenSize) {
    behavioralDataPageCount =
        (_mainIssueOfTheMonthBehavioralDataData.length / _rowsPerPage)
            .ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadBehavioralDataListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: behavioralDataPageCount,
                /*availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _behavioralDataRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },*/
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showBehavioralDataLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showBehavioralDataLoadingIndicator = false;
                  });
                },
                delegate:
                    CustomSliverChildBuilderDelegateMainIssueOfTheMonthBehavioralDataData(
                  indexBehavioralDataBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadBehavioralDataListView(
      BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_mainIssueOfTheMonthBehavioralDataData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate:
                CustomSliverChildBuilderDelegateMainIssueOfTheMonthBehavioralDataData(
                    indexBehavioralDataBuilder),
          ),
        );
      }

      if (showBehavioralDataLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexBehavioralDataBuilder(BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _mainPaginatedIssueOfTheMonthBehavioralDataData[
                                            index]
                                        .source ==
                                    null
                                ? ""
                                : _mainPaginatedIssueOfTheMonthBehavioralDataData[
                                        index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              _mainPaginatedIssueOfTheMonthBehavioralDataData[
                                              index]
                                          .source ==
                                      null
                                  ? ""
                                  : _mainPaginatedIssueOfTheMonthBehavioralDataData[
                                          index]
                                      .source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthBehavioralDataData[index]
                                    .issueString ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthBehavioralDataData[
                                    index]
                                .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthBehavioralDataData[index]
                                    .repetition ==
                                null
                            ? ""
                            : '${_mainPaginatedIssueOfTheMonthBehavioralDataData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthBehavioralDataData[index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthBehavioralDataData[
                                    index]
                                .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          _mainPaginatedIssueOfTheMonthBehavioralDataData[index]
                                      .sentimentAnalysis ==
                                  "Negative"
                              ? Colors.red
                              : _mainPaginatedIssueOfTheMonthBehavioralDataData[
                                              index]
                                          .sentimentAnalysis ==
                                      "Neutral"
                                  ? Colors.yellow
                                  : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///-------------------------------- Opinion dynamics and Sociophysics --------------------------------///

  bool showOpinionDynamicsAndSociophysicsLoadingIndicator = false;

  double opinionDynamicsAndSociophysicsPageCount = 0;

  buildOpinionDynamicsAndSociophysicsDataContentWithHeading(
      Size screenSize,
      String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData.isEmpty
                      ? Container()
                      : buildOpinionDynamicsAndSociophysicsDataContent(
                          screenSize),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildOpinionDynamicsAndSociophysicsDataContent(Size screenSize) {
    opinionDynamicsAndSociophysicsPageCount =
        (_mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData.length /
                _rowsPerPage)
            .ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadOpinionDynamicsAndSociophysicsListView(
                  constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: opinionDynamicsAndSociophysicsPageCount,
                /* availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _opinionDynamicsAndSociophysicsRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },*/
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showOpinionDynamicsAndSociophysicsLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showOpinionDynamicsAndSociophysicsLoadingIndicator = false;
                  });
                },
                delegate:
                    CustomSliverChildBuilderDelegateMainIssueOfTheMonthOpinionDynamicsAndSociophysicsData(
                  indexOpinionDynamicsAndSociophysicsBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadOpinionDynamicsAndSociophysicsListView(
      BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate:
                CustomSliverChildBuilderDelegateMainIssueOfTheMonthOpinionDynamicsAndSociophysicsData(
                    indexOpinionDynamicsAndSociophysicsBuilder),
          ),
        );
      }

      if (showOpinionDynamicsAndSociophysicsLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  Widget indexOpinionDynamicsAndSociophysicsBuilder(
      BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                            index]
                                        .source ==
                                    null
                                ? ""
                                : _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                        index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                              index]
                                          .source ==
                                      null
                                  ? ""
                                  : _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                          index]
                                      .source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                        index]
                                    .issueString ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                    index]
                                .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                        index]
                                    .repetition ==
                                null
                            ? ""
                            : '${_mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                        index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                    index]
                                .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                      index]
                                  .sentimentAnalysis ==
                              "Negative"
                          ? Colors.red
                          : _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[
                                          index]
                                      .sentimentAnalysis ==
                                  "Neutral"
                              ? Colors.yellow
                              : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

///------------------------------------------------------------------------------------ DETERMINE CONTENT FOR NEXT PAGE ------------------------------------------------------------------------------------///

int _rowsPerPage = 10;

///-------------------------------- Social Media --------------------------------///

List<IssueOfMonthDataModel> _mainPaginatedIssueOfTheMonthSocialMediaData = [];
List<IssueOfMonthDataModel> _mainIssueOfTheMonthSocialMediaData = [];

// int _socialMediaRowsPerPage = 10;

class CustomSliverChildBuilderDelegateMainIssueOfTheMonthSocialMediaData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateMainIssueOfTheMonthSocialMediaData(builder)
      : super(builder);

  @override
  int get childCount => _mainPaginatedIssueOfTheMonthSocialMediaData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex > _mainIssueOfTheMonthSocialMediaData.length) {
      endRowIndex = _mainIssueOfTheMonthSocialMediaData.length;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _mainPaginatedIssueOfTheMonthSocialMediaData =
        _mainIssueOfTheMonthSocialMediaData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);

    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateMainIssueOfTheMonthSocialMediaData
          oldDelegate) {
    return true;
  }
}

///-------------------------------- Song --------------------------------///

List<IssueOfMonthDataModel> _mainPaginatedIssueOfTheMonthSongData = [];
List<IssueOfMonthDataModel> _mainIssueOfTheMonthSongData = [];

// int _songRowsPerPage = 10;

class CustomSliverChildBuilderDelegateMainIssueOfTheMonthSongData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateMainIssueOfTheMonthSongData(builder)
      : super(builder);

  @override
  int get childCount => _mainPaginatedIssueOfTheMonthSongData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex > _mainIssueOfTheMonthSongData.length) {
      endRowIndex = _mainIssueOfTheMonthSongData.length;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _mainPaginatedIssueOfTheMonthSongData = _mainIssueOfTheMonthSongData
        .getRange(startRowIndex, endRowIndex)
        .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateMainIssueOfTheMonthSongData
          oldDelegate) {
    return true;
  }
}

///-------------------------------- Religious Speeches --------------------------------///

List<IssueOfMonthDataModel> _mainPaginatedIssueOfTheMonthReligiousSpeechesData =
    [];
List<IssueOfMonthDataModel> _mainIssueOfTheMonthReligiousSpeechesData = [];

// int _religiousSpeechesRowsPerPage = 10;

class CustomSliverChildBuilderDelegateMainIssueOfTheMonthReligiousSpeechesData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateMainIssueOfTheMonthReligiousSpeechesData(
      builder)
      : super(builder);

  @override
  int get childCount =>
      _mainPaginatedIssueOfTheMonthReligiousSpeechesData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex > _mainIssueOfTheMonthReligiousSpeechesData.length) {
      endRowIndex = _mainIssueOfTheMonthReligiousSpeechesData.length;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _mainPaginatedIssueOfTheMonthReligiousSpeechesData =
        _mainIssueOfTheMonthReligiousSpeechesData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateMainIssueOfTheMonthReligiousSpeechesData
          oldDelegate) {
    return true;
  }
}

///-------------------------------- Interviews --------------------------------///

List<IssueOfMonthDataModel> _mainPaginatedIssueOfTheMonthInterviewsData = [];
List<IssueOfMonthDataModel> _mainIssueOfTheMonthInterviewsData = [];

// int _interviewsRowsPerPage = 10;

class CustomSliverChildBuilderDelegateMainIssueOfTheMonthInterviewsData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateMainIssueOfTheMonthInterviewsData(builder)
      : super(builder);

  @override
  int get childCount => _mainPaginatedIssueOfTheMonthInterviewsData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex > _mainIssueOfTheMonthInterviewsData.length) {
      endRowIndex = _mainIssueOfTheMonthInterviewsData.length;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _mainPaginatedIssueOfTheMonthInterviewsData =
        _mainIssueOfTheMonthInterviewsData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateMainIssueOfTheMonthInterviewsData
          oldDelegate) {
    return true;
  }
}

///-------------------------------- Visual Anthropology --------------------------------///

List<IssueOfMonthDataModel>
    _mainPaginatedIssueOfTheMonthVisualAnthropologyData = [];
List<IssueOfMonthDataModel> _mainIssueOfTheMonthVisualAnthropologyData = [];

// int _visualAnthropologyRowsPerPage = 10;

class CustomSliverChildBuilderDelegateMainIssueOfTheMonthVisualAnthropologyData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateMainIssueOfTheMonthVisualAnthropologyData(
      builder)
      : super(builder);

  @override
  int get childCount =>
      _mainPaginatedIssueOfTheMonthVisualAnthropologyData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex > _mainIssueOfTheMonthVisualAnthropologyData.length) {
      endRowIndex = _mainIssueOfTheMonthVisualAnthropologyData.length;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _mainPaginatedIssueOfTheMonthVisualAnthropologyData =
        _mainIssueOfTheMonthVisualAnthropologyData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateMainIssueOfTheMonthVisualAnthropologyData
          oldDelegate) {
    return true;
  }
}

///-------------------------------- GIS --------------------------------///

List<IssueOfMonthDataModel> _mainPaginatedIssueOfTheMonthGISData = [];
List<IssueOfMonthDataModel> _mainIssueOfTheMonthGISData = [];

// int _gisRowsPerPage = 10;

class CustomSliverChildBuilderDelegateMainIssueOfTheMonthGISData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateMainIssueOfTheMonthGISData(builder)
      : super(builder);

  @override
  int get childCount => _mainPaginatedIssueOfTheMonthGISData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex > _mainIssueOfTheMonthGISData.length) {
      endRowIndex = _mainIssueOfTheMonthGISData.length;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _mainPaginatedIssueOfTheMonthGISData = _mainIssueOfTheMonthGISData
        .getRange(startRowIndex, endRowIndex)
        .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateMainIssueOfTheMonthGISData
          oldDelegate) {
    return true;
  }
}

///-------------------------------- Foresight And Scenarios Building --------------------------------///

List<IssueOfMonthDataModel>
    _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData = [];
List<IssueOfMonthDataModel>
    _mainIssueOfTheMonthForesightAndScenariosBuildingData = [];

// int _foresightAndScenariosBuildingRowsPerPage = 10;

class CustomSliverChildBuilderDelegateMainIssueOfTheMonthForesightAndScenariosBuildingData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateMainIssueOfTheMonthForesightAndScenariosBuildingData(
      builder)
      : super(builder);

  @override
  int get childCount =>
      _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex >
        _mainIssueOfTheMonthForesightAndScenariosBuildingData.length) {
      endRowIndex =
          _mainIssueOfTheMonthForesightAndScenariosBuildingData.length;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _mainPaginatedIssueOfTheMonthForesightAndScenariosBuildingData =
        _mainIssueOfTheMonthForesightAndScenariosBuildingData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateMainIssueOfTheMonthForesightAndScenariosBuildingData
          oldDelegate) {
    return true;
  }
}

///-------------------------------- Public Perception Survey --------------------------------///

List<IssueOfMonthDataModel>
    _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData = [];
List<IssueOfMonthDataModel> _mainIssueOfTheMonthPublicPerceptionSurveyData = [];

// int _publicPerceptionSurveyRowsPerPage = 10;

class CustomSliverChildBuilderDelegateMainIssueOfTheMonthPublicPerceptionSurveyData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateMainIssueOfTheMonthPublicPerceptionSurveyData(
      builder)
      : super(builder);

  @override
  int get childCount =>
      _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex > _mainIssueOfTheMonthPublicPerceptionSurveyData.length) {
      endRowIndex = _mainIssueOfTheMonthPublicPerceptionSurveyData.length;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _mainPaginatedIssueOfTheMonthPublicPerceptionSurveyData =
        _mainIssueOfTheMonthPublicPerceptionSurveyData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateMainIssueOfTheMonthPublicPerceptionSurveyData
          oldDelegate) {
    return true;
  }
}

///-------------------------------- Behavioural Data --------------------------------///

List<IssueOfMonthDataModel> _mainPaginatedIssueOfTheMonthBehavioralDataData =
    [];
List<IssueOfMonthDataModel> _mainIssueOfTheMonthBehavioralDataData = [];

// int _behavioralDataRowsPerPage = 10;

class CustomSliverChildBuilderDelegateMainIssueOfTheMonthBehavioralDataData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateMainIssueOfTheMonthBehavioralDataData(builder)
      : super(builder);

  @override
  int get childCount => _mainPaginatedIssueOfTheMonthBehavioralDataData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex > _mainIssueOfTheMonthBehavioralDataData.length) {
      endRowIndex = _mainIssueOfTheMonthBehavioralDataData.length;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _mainPaginatedIssueOfTheMonthBehavioralDataData =
        _mainIssueOfTheMonthBehavioralDataData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateMainIssueOfTheMonthBehavioralDataData
          oldDelegate) {
    return true;
  }
}

///-------------------------------- Opinion dynamics and Sociophysics --------------------------------///

List<IssueOfMonthDataModel>
    _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData = [];
List<IssueOfMonthDataModel>
    _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData = [];

// int _opinionDynamicsAndSociophysicsRowsPerPage = 10;

class CustomSliverChildBuilderDelegateMainIssueOfTheMonthOpinionDynamicsAndSociophysicsData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateMainIssueOfTheMonthOpinionDynamicsAndSociophysicsData(
      builder)
      : super(builder);

  @override
  int get childCount =>
      _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex >
        _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData.length) {
      endRowIndex =
          _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData.length;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _mainPaginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
        _mainIssueOfTheMonthOpinionDynamicsAndSociophysicsData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateMainIssueOfTheMonthOpinionDynamicsAndSociophysicsData
          oldDelegate) {
    return true;
  }
}
