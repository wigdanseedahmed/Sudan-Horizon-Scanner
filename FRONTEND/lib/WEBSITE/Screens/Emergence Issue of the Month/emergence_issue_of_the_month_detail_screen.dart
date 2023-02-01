import 'package:nb_utils/nb_utils.dart';
import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

class EmergenceIssueOfTheMonthScreenDetailScreenWS extends StatefulWidget {
  final String emergingIssueName;

  const EmergenceIssueOfTheMonthScreenDetailScreenWS({
    Key? key,
    required this.emergingIssueName,
  }) : super(key: key);

  @override
  State<EmergenceIssueOfTheMonthScreenDetailScreenWS> createState() =>
      _EmergenceIssueOfTheMonthScreenDetailScreenWSState();
}

class _EmergenceIssueOfTheMonthScreenDetailScreenWSState
    extends State<EmergenceIssueOfTheMonthScreenDetailScreenWS>
    with TickerProviderStateMixin {

  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  late IssueOfMonthModel readJsonFileContent = IssueOfMonthModel();

  late List<IssueOfMonthModelChartData> issueOfMonthModelChartData =
      <IssueOfMonthModelChartData>[];

  Future<IssueOfMonthModel> readEmergingIssueOfTheMonthFromJsonFile() async {
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
        readJsonFileContent =
            emergenceIssueOfTheMonthModelFromJson(response.body)
                .where((element) =>
                    element.emergingIssue == widget.emergingIssueName)
                .toList()[0];

        issueOfMonthModelChartData = [
          IssueOfMonthModelChartData(
              "Negative (${readJsonFileContent.negativeSentimentAnalysisDataCount})",
              ((readJsonFileContent.negativeSentimentAnalysisDataCount! /
                          readJsonFileContent.totalDataCount!) *
                      100)
                  .toStringAsFixed(2)
                  .toDouble(),
              Colors.grey),
          IssueOfMonthModelChartData(
              "Neutral (${readJsonFileContent.neutralSentimentAnalysisDataCount})",
              ((readJsonFileContent.neutralSentimentAnalysisDataCount! /
                          readJsonFileContent.totalDataCount!) *
                      100)
                  .toStringAsFixed(2)
                  .toDouble(),
              Colors.lightGreenAccent),
          IssueOfMonthModelChartData(
              "Positive (${readJsonFileContent.positiveSentimentAnalysisDataCount})",
              ((readJsonFileContent.positiveSentimentAnalysisDataCount! /
                          readJsonFileContent.totalDataCount!) *
                      100)
                  .toStringAsFixed(2)
                  .toDouble(),
              Colors.tealAccent),
        ]; //(jsonString);
      });
      return readJsonFileContent;
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
            emergenceIssueOfTheMonthDataModelFromJson(response.body)
                .where((element) =>
                    element.emergenceIssue == widget.emergingIssueName)
                .toList(); //(jsonString);

        _issueOfTheMonthSocialMediaData = readEmergenceIssueDataJsonFileContent.where((element) => element.emergenceIssue == widget.emergingIssueName && element.sourceCategory == qualitativeDataSourceList[0]).toList();
        _issueOfTheMonthSongData = readEmergenceIssueDataJsonFileContent.where((element) => element.emergenceIssue == widget.emergingIssueName && element.sourceCategory == qualitativeDataSourceList[1]).toList();
        _issueOfTheMonthReligiousSpeechesData = readEmergenceIssueDataJsonFileContent.where((element) => element.emergenceIssue == widget.emergingIssueName && element.sourceCategory == qualitativeDataSourceList[2]).toList();
        _issueOfTheMonthInterviewsData = readEmergenceIssueDataJsonFileContent.where((element) => element.emergenceIssue == widget.emergingIssueName && element.sourceCategory == qualitativeDataSourceList[3]).toList();
        _issueOfTheMonthVisualAnthropologyData = readEmergenceIssueDataJsonFileContent.where((element) => element.emergenceIssue == widget.emergingIssueName && element.sourceCategory == qualitativeDataSourceList[4]).toList();
        _issueOfTheMonthGISData = readEmergenceIssueDataJsonFileContent.where((element) => element.emergenceIssue == widget.emergingIssueName && element.sourceCategory == qualitativeDataSourceList[5]).toList();
        _issueOfTheMonthForesightAndScenariosBuildingData = readEmergenceIssueDataJsonFileContent.where((element) => element.emergenceIssue == widget.emergingIssueName && element.sourceCategory == qualitativeDataSourceList[6]).toList();
        _issueOfTheMonthPublicPerceptionSurveyData = readEmergenceIssueDataJsonFileContent.where((element) => element.emergenceIssue == widget.emergingIssueName && element.sourceCategory == qualitativeDataSourceList[7]).toList();
        _issueOfTheMonthBehavioralDataData = readEmergenceIssueDataJsonFileContent.where((element) => element.emergenceIssue == widget.emergingIssueName && element.sourceCategory == qualitativeDataSourceList[8]).toList();
        _issueOfTheMonthOpinionDynamicsAndSociophysicsData = readEmergenceIssueDataJsonFileContent.where((element) => element.emergenceIssue == widget.emergingIssueName && element.sourceCategory == qualitativeDataSourceList[9]).toList();

      });
      return readEmergenceIssueDataJsonFileContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  /// LIVE COMMENT VARIABLES

  late TooltipBehavior _tooltipBehavior;
  Timer? timer;

  List<CommentChartDataModel> chartData = <CommentChartDataModel>[];
  late int count;
  ChartSeriesController? _chartSeriesController;

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

    /// LIVE COMMENT VARIABLES
    _tooltipBehavior = TooltipBehavior(enable: true);
    timer = Timer.periodic(const Duration(milliseconds: 10), _updateDataSource);

    count = 19;
    chartData = <CommentChartDataModel>[
      CommentChartDataModel("1/6/2022", 47),
      CommentChartDataModel("2/6/2022", 33),
      CommentChartDataModel("3/6/2022", 49),
      CommentChartDataModel("4/6/2022", 54),
      CommentChartDataModel("5/6/2022", 41),
      CommentChartDataModel("6/6/2022", 58),
      CommentChartDataModel("7/6/2022", 51),
      CommentChartDataModel("8/6/2022", 98),
      CommentChartDataModel("9/6/2022", 41),
      CommentChartDataModel("10/6/2022", 53),
      CommentChartDataModel("11/6/2022", 72),
      CommentChartDataModel("12/6/2022", 86),
      CommentChartDataModel("13/6/2022", 52),
      CommentChartDataModel("14/6/2022", 94),
      CommentChartDataModel("15/6/2022", 92),
      CommentChartDataModel("16/6/2022", 86),
      CommentChartDataModel("17/6/2022", 72),
      CommentChartDataModel("18/6/2022", 94),
      CommentChartDataModel("19/6/2022", 42),
    ];

    /// EMERGENCE ISSUES OF FILTER AND SEARCH VARIABLES
    sourceFilterSelectedOption = [];
    sentimentAnalysisFilterSelectedOption = [];
    languageSelectedOption = [];
    sdgSelectedOption = [];
    numberFilterSelectedOption == 'Choose One';
    minValue == 0.0;
    maxValue == 0.0;
    value == 0.0;

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

              _issueOfTheMonthSocialMediaData;
              _issueOfTheMonthSongData;
              _issueOfTheMonthReligiousSpeechesData;
              _issueOfTheMonthInterviewsData;
              _issueOfTheMonthVisualAnthropologyData;
              _issueOfTheMonthGISData;
              _issueOfTheMonthForesightAndScenariosBuildingData;
              _issueOfTheMonthPublicPerceptionSurveyData;
              _issueOfTheMonthBehavioralDataData;
              _issueOfTheMonthOpinionDynamicsAndSociophysicsData;
            }
          });

          readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[0]).forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _issueOfTheMonthSocialMediaData.add(searchResult);
              });
            } else {
              _issueOfTheMonthSocialMediaData;
            }
          });

          readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[1]).forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _issueOfTheMonthSongData.add(searchResult);
              });
            } else {
              _issueOfTheMonthSongData;
            }
          });

          readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[2]).forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _issueOfTheMonthReligiousSpeechesData.add(searchResult);
              });
            } else {
              _issueOfTheMonthReligiousSpeechesData;
            }
          });

          readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[3]).forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _issueOfTheMonthInterviewsData.add(searchResult);
              });
            } else {
              _issueOfTheMonthInterviewsData;
            }
          });

          readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[4]).forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _issueOfTheMonthVisualAnthropologyData.add(searchResult);
              });
            } else {
              _issueOfTheMonthVisualAnthropologyData;
            }
          });

          readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[5]).forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _issueOfTheMonthGISData.add(searchResult);
              });
            } else {
              _issueOfTheMonthGISData;
            }
          });

          readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[6]).forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _issueOfTheMonthForesightAndScenariosBuildingData.add(searchResult);
              });
            } else {
              _issueOfTheMonthForesightAndScenariosBuildingData;
            }
          });

          readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[7]).forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _issueOfTheMonthPublicPerceptionSurveyData.add(searchResult);
              });
            } else {
              _issueOfTheMonthPublicPerceptionSurveyData;
            }
          });

          readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[8]).forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _issueOfTheMonthBehavioralDataData.add(searchResult);
              });
            } else {
              _issueOfTheMonthBehavioralDataData;
            }
          });

          readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[9]).forEach((IssueOfMonthDataModel searchResult) {
            if (searchResult.issueString!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) {
              setState(() {
                _issueOfTheMonthOpinionDynamicsAndSociophysicsData.add(searchResult);
              });
            } else {
              _issueOfTheMonthOpinionDynamicsAndSociophysicsData;
            }
          });



        } else {
          setState(() {
            issueOfMonthFinalSearchDataList.clear();
            issueOfMonthFinalSearchDataList.addAll(readEmergenceIssueData);

            _issueOfTheMonthSocialMediaData.clear();
            _issueOfTheMonthSocialMediaData.addAll(readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[0]));

            _issueOfTheMonthSongData.clear();
            _issueOfTheMonthSongData.addAll(readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[1]));

            _issueOfTheMonthReligiousSpeechesData.clear();
            _issueOfTheMonthReligiousSpeechesData.addAll(readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[2]));

            _issueOfTheMonthInterviewsData.clear();
            _issueOfTheMonthInterviewsData.addAll(readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[3]));

            _issueOfTheMonthVisualAnthropologyData.clear();
            _issueOfTheMonthVisualAnthropologyData.addAll(readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[4]));

            _issueOfTheMonthGISData.clear();
            _issueOfTheMonthGISData.addAll(readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[5]));

            _issueOfTheMonthForesightAndScenariosBuildingData.clear();
            _issueOfTheMonthForesightAndScenariosBuildingData.addAll(readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[6]));

            _issueOfTheMonthPublicPerceptionSurveyData.clear();
            _issueOfTheMonthPublicPerceptionSurveyData.addAll(readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[7]));

            _issueOfTheMonthBehavioralDataData.clear();
            _issueOfTheMonthBehavioralDataData.addAll(readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[8]));

            _issueOfTheMonthOpinionDynamicsAndSociophysicsData.clear();
            _issueOfTheMonthOpinionDynamicsAndSociophysicsData.addAll(readEmergenceIssueData.where((element) => element.sourceCategory == qualitativeDataSourceList[9]));
          });
        }

      });
    });

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    chartData.clear();
    _chartSeriesController = null;
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

    final List<Color> emergenceIssueDataLiveFeedChartColour = <Color>[];
    emergenceIssueDataLiveFeedChartColour.add(Colors.blue[50]!);
    emergenceIssueDataLiveFeedChartColour.add(Colors.blue[200]!);
    emergenceIssueDataLiveFeedChartColour.add(Colors.blue);

    final List<double> emergenceIssueDataLiveFeedChartColourStops = <double>[];
    emergenceIssueDataLiveFeedChartColourStops.add(0.0);
    emergenceIssueDataLiveFeedChartColourStops.add(0.5);
    emergenceIssueDataLiveFeedChartColourStops.add(1.0);

    return FutureBuilder(
      future: readEmergenceIssueDataFromJsonFile(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          return FutureBuilder(
            future: readEmergingIssueOfTheMonthFromJsonFile(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                return Scaffold(
                    appBar: buildAppBar(screenSize),
                    body: SafeArea(
                      child: buildBody(
                        screenSize,
                        emergenceIssueDataLiveFeedChartColour,
                        emergenceIssueDataLiveFeedChartColourStops,
                      ),
                    ));
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

  buildBody(Size screenSize, List<Color> emergenceIssueDataLiveFeedChartColour,
      List<double> emergenceIssueDataLiveFeedChartColourStops) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: screenSize.height * 0.2,
                      width: screenSize.width * 0.95,
                      child: Center(
                        child: ListView.builder(
                          itemCount: sdgGoalsIconList!.length,
                          padding: const EdgeInsets.all(0.0),
                          shrinkWrap: true,
                          //physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  readJsonFileContent.sdgTargeted ==
                                          sdgGoalsList![index]
                                      ? Container(
                                          width: screenSize.width * 0.05,
                                          height: screenSize.height * 0.05,
                                          color: sdgGoalsColoursList![index],
                                        )
                                      : Container(),
                                  Positioned(
                                    top: screenSize.height * -0.05,
                                    child: Image.asset(
                                      sdgGoalsIconList![index],
                                      fit: BoxFit.fill,
                                      width: screenSize.width * 0.05,
                                      height: screenSize.height * 0.1,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.05),
                    IntrinsicHeight(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              widget.emergingIssueName,
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.1),
                          Padding(
                            padding:
                                EdgeInsets.only(right: screenSize.width * 0.03),
                            child: Text(
                              'An issue that is recognized as very important by the scientific community, but are not yet receiving adequate attention from the policy community. The issue could be positive or negative. Significant opportunities may be lost or undesired effects may occur in future, if not addressed.\nHERE A SUMMARY OF EACH ISSUE WILL BE ADDED.',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.015,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          readJsonFileContent.totalDataCount == 0
                              ? Container()
                              : SizedBox(height: screenSize.height * 0.1),
                          readJsonFileContent.totalDataCount == 0
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.only(
                                      right: screenSize.width * 0.015),
                                  child: SizedBox(
                                    width: screenSize.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        buildSentimentAnalysisChart(screenSize),
                                        buildLiveDataStreamChart(
                                            screenSize,
                                            emergenceIssueDataLiveFeedChartColour,
                                            emergenceIssueDataLiveFeedChartColourStops),
                                      ],
                                    ),
                                  ),
                                ),
                          SizedBox(height: screenSize.height * 0.05),
                          Padding(
                            padding: EdgeInsets.only(
                                right: screenSize.width * 0.015),
                            child: SizedBox(
                              width: screenSize.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  readJsonFileContent.repetition == null
                                      ? Container(
                                          height: screenSize.height * 0.5,
                                          width: screenSize.width * 0.45,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        )
                                      : buildDataAccuracyChart(screenSize),
                                  buildChart2(screenSize),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.1),
                    IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          buildIssuesOfTheMonthData(screenSize),
                          const SizedBox(
                            width: 10,
                          ),
                          buildFilterData(screenSize),
                        ],
                      ),
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
    );
  }

  ///-------------------------- FOR SENTIMENT ANALYSIS CHART --------------------------///

  buildSentimentAnalysisChart(Size screenSize) {
    return Container(
      height: screenSize.height * 0.5,
      width: screenSize.width * 0.45,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SENTIMENT ANALYSIS",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.015,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width * 0.008,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "${readJsonFileContent.negativeSentimentAnalysisDataCount} ",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.008,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      TextSpan(
                        text: "negative sentiment analysis.",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.008,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w100,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.01),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width * 0.008,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "${readJsonFileContent.neutralSentimentAnalysisDataCount} ",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.008,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      TextSpan(
                        text: "neutral sentiment analysis.",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.008,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w100,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.01),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width * 0.008,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "${readJsonFileContent.positiveSentimentAnalysisDataCount} ",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.008,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      TextSpan(
                        text: "positive sentiment analysis.",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.008,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w100,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            SfCircularChart(
              //tooltipBehavior: _tooltipBehavior,
              legend: Legend(
                position: LegendPosition.top,
                isVisible: true,
                isResponsive: true,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              series: <CircularSeries>[
                DoughnutSeries<IssueOfMonthModelChartData, String>(
                  dataSource: issueOfMonthModelChartData,
                  pointColorMapper: (IssueOfMonthModelChartData data, _) =>
                      data.color,
                  xValueMapper: (IssueOfMonthModelChartData data, _) => data.x,
                  yValueMapper: (IssueOfMonthModelChartData data, _) => data.y,
                  // Radius of doughnut's inner circle
                  innerRadius: '80%',
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      // Positioning the data label
                      labelPosition: ChartDataLabelPosition.outside),
                  enableTooltip: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///-------------------------- FOR LIVE DATA STREAM CHART --------------------------///

  buildLiveDataStreamChart(Size screenSize, List<Color> emergenceIssueDataLiveFeedChartColour, List<double> emergenceIssueDataLiveFeedChartColourStops) {
    return Container(
      height: screenSize.height * 0.5,
      width: screenSize.width * 0.45,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        /*gradient: const LinearGradient(
                                                      colors: [
                                                        Color.fromRGBO(111, 88, 255, 1),
                                                        Color.fromRGBO(157, 86, 248, 1),
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    ),*/
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenSize.width * 0.41,
              child: SfCartesianChart(
                //TODO: EmergenceIssueDataLiveFeedChart()
                // TODO: Change to https://github.com/syncfusion/flutter-examples/blob/master/lib/samples/chart/cartesian_charts/user_interactions/pagination.dart
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                ),
                // Chart title
                title: ChartTitle(
                  text: 'Comments',
                  textStyle: TextStyle(
                    fontSize: screenSize.width * 0.015,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                // Enable legend
                legend: Legend(isVisible: false),
                // Enable tooltip
                tooltipBehavior: _tooltipBehavior,
                series: <AreaSeries<CommentChartDataModel, String>>[
                  AreaSeries<CommentChartDataModel, String>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    animationDuration: 0,
                    dataSource: chartData,
                    xValueMapper: (CommentChartDataModel sales, _) => sales.day,
                    yValueMapper: (CommentChartDataModel sales, _) =>
                        sales.dataCount,
                    // Enable data label
                    dataLabelSettings:
                        const DataLabelSettings(isVisible: false),
                    gradient: LinearGradient(
                        colors: emergenceIssueDataLiveFeedChartColour,
                        stops: emergenceIssueDataLiveFeedChartColourStops),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///-------------------------- FOR DATA ACCURACY CHART --------------------------///

  buildDataAccuracyChart(Size screenSize) {
    return Container(
      height: screenSize.height * 0.5,
      width: screenSize.width * 0.45,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Accuracy",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.015,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SfCircularChart(
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: Text(
                    readJsonFileContent.repetition == null
                        ? ""
                        : '${readJsonFileContent.repetition!}%',
                    style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
              series: <CircularSeries>[
                DoughnutSeries<IssueOfMonthModel, String>(
                  dataSource: [readJsonFileContent, IssueOfMonthModel()],
                  xValueMapper: (IssueOfMonthModel data, _) =>
                      data.emergingIssue == null ? "" : data.emergingIssue!,
                  yValueMapper: (IssueOfMonthModel data, _) =>
                      data.repetition == null
                          ? 1 - readJsonFileContent.repetition! / 100
                          : data.repetition! / 100,
                  pointColorMapper: (IssueOfMonthModel data, _) =>
                      data.emergingIssue == null
                          ? Colors.transparent
                          : Colors.tealAccent,
                  // Radius of doughnut's inner circle
                  innerRadius: '80%',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///-------------------------- FOR SDG DISPLAY CHART --------------------------///

  buildChart2(Size screenSize) {
    return Container(
      height: screenSize.height * 0.5,
      width: screenSize.width * 0.45,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*
            Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              mainAxisAlignment:
              MainAxisAlignment
                  .center,
              children: [
                Text(
                  "Accuracy",
                  style:
                  TextStyle(
                    fontSize:
                    screenSize.width * 0.015,
                    fontFamily:
                    'Montserrat',
                    fontWeight:
                    FontWeight.bold,
                    letterSpacing:
                    1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SfCircularChart(
              //tooltipBehavior: _tooltipBehavior,
              legend:
              Legend(
                position:
                LegendPosition.top,
                isVisible:
                true,
                isResponsive:
                true,
                overflowMode:
                LegendItemOverflowMode.wrap,
              ),
              series: <
                  CircularSeries>[
                DoughnutSeries<
                    IssueOfMonthModel,
                    String>(
                  dataSource: [readJsonFileContent],
                  xValueMapper: (IssueOfMonthModel data, _) =>
                  data.emergingIssue,
                  yValueMapper: (IssueOfMonthModel data, _) =>
                  data.repetition! / 100,
                  // Radius of doughnut's inner circle
                  innerRadius:
                  '80%',
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      // Positioning the data label
                      labelPosition: ChartDataLabelPosition.outside),
                  enableTooltip:
                  true,
                ),
                DoughnutSeries<
                    IssueOfMonthModel,
                    String>(
                  dataSource: [readJsonFileContent],
                  xValueMapper: (IssueOfMonthModel data, _) =>
                  data.emergingIssue,
                  yValueMapper: (IssueOfMonthModel data, _) =>
                  1 - data.repetition! / 100,
                  // Radius of doughnut's inner circle
                  innerRadius:
                  '80%',
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      // Positioning the data label
                      labelPosition: ChartDataLabelPosition.outside),
                  enableTooltip:
                  true,
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  /// Continuously updating the data source based on timer.
  void _updateDataSource(Timer timer) {
    chartData.add(CommentChartDataModel(
        "${count}/6/2022", _getRandomInt(0, 30).toDouble()));
    if (chartData.length == 20) {
      chartData.removeAt(0);
      _chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[chartData.length - 1],
        removedDataIndexes: <int>[0],
      );
    } else {
      _chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[chartData.length - 1],
      );
    }
    count = count + 1;
  }

  ///Get the random data
  int _getRandomInt(int min, int max) {
    final math.Random random = math.Random();
    return min + random.nextInt(max - min);
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
        width: screenSize.width * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Center(
                    child: Text(
                      'Data Analytics',
                      style: cardTitleTextStyle,
                    ),
                  ),
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
                            key: Key(searchQuery),
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


                                _issueOfTheMonthSocialMediaData =
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

                                _issueOfTheMonthSongData = textAnalysisFilterFunction(
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
                                element.sourceCategory == qualitativeDataSourceList[1])
                                    .toList();

                                _issueOfTheMonthReligiousSpeechesData =
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

                                _issueOfTheMonthInterviewsData =
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

                                _issueOfTheMonthVisualAnthropologyData =
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

                                _issueOfTheMonthGISData = textAnalysisFilterFunction(
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
                                element.sourceCategory == qualitativeDataSourceList[5])
                                    .toList();

                                _issueOfTheMonthForesightAndScenariosBuildingData =
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

                                _issueOfTheMonthPublicPerceptionSurveyData =
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

                                _issueOfTheMonthBehavioralDataData =
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

                                _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
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
                            onSubmitted: (newSearchTerm) {
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

                                _issueOfTheMonthSocialMediaData =
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

                                _issueOfTheMonthSongData = textAnalysisFilterFunction(
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
                                element.sourceCategory == qualitativeDataSourceList[1])
                                    .toList();

                                _issueOfTheMonthReligiousSpeechesData =
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

                                _issueOfTheMonthInterviewsData =
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

                                _issueOfTheMonthVisualAnthropologyData =
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

                                _issueOfTheMonthGISData = textAnalysisFilterFunction(
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
                                element.sourceCategory == qualitativeDataSourceList[5])
                                    .toList();

                                _issueOfTheMonthForesightAndScenariosBuildingData =
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

                                _issueOfTheMonthPublicPerceptionSurveyData =
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

                                _issueOfTheMonthBehavioralDataData =
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

                                _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
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
                ListView.builder(
                  itemCount: qualitativeDataSourceList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return buildDataContent(
                      screenSize,
                      qualitativeDataSourceList[index],
                      issueOfMonthFinalSearchDataList,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildHeader(Size screenSize) {
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

  buildDataContent(Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${issueOfMonthData.where((element) => element.sourceCategory == selectedDataSourceCategory).length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  issueOfMonthData
                          .where((element) =>
                              element.sourceCategory ==
                              selectedDataSourceCategory)
                          .isEmpty
                      ? Container()
                      : buildDataContentPerSource(
                          // key: PageStorageKey(issueOfMonthData),
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

                          _issueOfTheMonthSocialMediaData = readEmergenceIssueDataJsonFileContent.where((element) => element.sourceCategory == qualitativeDataSourceList[0]).toList();
                          _issueOfTheMonthSongData = readEmergenceIssueDataJsonFileContent.where((element) => element.sourceCategory == qualitativeDataSourceList[1]).toList();
                          _issueOfTheMonthReligiousSpeechesData = readEmergenceIssueDataJsonFileContent.where((element) => element.sourceCategory == qualitativeDataSourceList[2]).toList();
                          _issueOfTheMonthInterviewsData = readEmergenceIssueDataJsonFileContent.where((element) => element.sourceCategory == qualitativeDataSourceList[3]).toList();
                          _issueOfTheMonthVisualAnthropologyData = readEmergenceIssueDataJsonFileContent.where((element) => element.sourceCategory == qualitativeDataSourceList[4]).toList();
                          _issueOfTheMonthGISData = readEmergenceIssueDataJsonFileContent.where((element) => element.sourceCategory == qualitativeDataSourceList[5]).toList();
                          _issueOfTheMonthForesightAndScenariosBuildingData = readEmergenceIssueDataJsonFileContent.where((element) => element.sourceCategory == qualitativeDataSourceList[6]).toList();
                          _issueOfTheMonthPublicPerceptionSurveyData = readEmergenceIssueDataJsonFileContent.where((element) => element.sourceCategory == qualitativeDataSourceList[7]).toList();
                          _issueOfTheMonthBehavioralDataData = readEmergenceIssueDataJsonFileContent.where((element) => element.sourceCategory == qualitativeDataSourceList[8]).toList();
                          _issueOfTheMonthOpinionDynamicsAndSociophysicsData = readEmergenceIssueDataJsonFileContent.where((element) => element.sourceCategory == qualitativeDataSourceList[9]).toList();



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

                              _issueOfTheMonthSocialMediaData =
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

                              _issueOfTheMonthSongData = textAnalysisFilterFunction(
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
                              element.sourceCategory == qualitativeDataSourceList[1])
                                  .toList();

                              _issueOfTheMonthReligiousSpeechesData =
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

                              _issueOfTheMonthInterviewsData =
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

                              _issueOfTheMonthVisualAnthropologyData =
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

                              _issueOfTheMonthGISData = textAnalysisFilterFunction(
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
                              element.sourceCategory == qualitativeDataSourceList[5])
                                  .toList();

                              _issueOfTheMonthForesightAndScenariosBuildingData =
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

                              _issueOfTheMonthPublicPerceptionSurveyData =
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

                              _issueOfTheMonthBehavioralDataData =
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

                              _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
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

                              rebuildList();
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

                              _issueOfTheMonthSocialMediaData =
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

                              _issueOfTheMonthSongData = textAnalysisFilterFunction(
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
                              element.sourceCategory == qualitativeDataSourceList[1])
                                  .toList();

                              _issueOfTheMonthReligiousSpeechesData =
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

                              _issueOfTheMonthInterviewsData =
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

                              _issueOfTheMonthVisualAnthropologyData =
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

                              _issueOfTheMonthGISData = textAnalysisFilterFunction(
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
                              element.sourceCategory == qualitativeDataSourceList[5])
                                  .toList();

                              _issueOfTheMonthForesightAndScenariosBuildingData =
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

                              _issueOfTheMonthPublicPerceptionSurveyData =
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

                              _issueOfTheMonthBehavioralDataData =
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

                              _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
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

                          _issueOfTheMonthSocialMediaData =
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

                          _issueOfTheMonthSongData = textAnalysisFilterFunction(
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
                          element.sourceCategory == qualitativeDataSourceList[1])
                              .toList();

                          _issueOfTheMonthReligiousSpeechesData =
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

                          _issueOfTheMonthInterviewsData =
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

                          _issueOfTheMonthVisualAnthropologyData =
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

                          _issueOfTheMonthGISData = textAnalysisFilterFunction(
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
                          element.sourceCategory == qualitativeDataSourceList[5])
                              .toList();

                          _issueOfTheMonthForesightAndScenariosBuildingData =
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

                          _issueOfTheMonthPublicPerceptionSurveyData =
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

                          _issueOfTheMonthBehavioralDataData =
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

                          _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
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

                          _issueOfTheMonthSocialMediaData =
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

                          _issueOfTheMonthSongData = textAnalysisFilterFunction(
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
                          element.sourceCategory == qualitativeDataSourceList[1])
                              .toList();

                          _issueOfTheMonthReligiousSpeechesData =
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

                          _issueOfTheMonthInterviewsData =
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

                          _issueOfTheMonthVisualAnthropologyData =
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

                          _issueOfTheMonthGISData = textAnalysisFilterFunction(
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
                          element.sourceCategory == qualitativeDataSourceList[5])
                              .toList();

                          _issueOfTheMonthForesightAndScenariosBuildingData =
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

                          _issueOfTheMonthPublicPerceptionSurveyData =
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

                          _issueOfTheMonthBehavioralDataData =
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

                          _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
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

                                  _issueOfTheMonthSocialMediaData =
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

                                  _issueOfTheMonthSongData = textAnalysisFilterFunction(
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
                                  element.sourceCategory == qualitativeDataSourceList[1])
                                      .toList();

                                  _issueOfTheMonthReligiousSpeechesData =
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

                                  _issueOfTheMonthInterviewsData =
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

                                  _issueOfTheMonthVisualAnthropologyData =
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
                                        value: value,)
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[4])
                                          .toList();

                                  _issueOfTheMonthGISData = textAnalysisFilterFunction(
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
                                  element.sourceCategory == qualitativeDataSourceList[5])
                                      .toList();

                                  _issueOfTheMonthForesightAndScenariosBuildingData =
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
                                        value: value,)
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[6])
                                          .toList();

                                  _issueOfTheMonthPublicPerceptionSurveyData =
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
                                        value: value,)
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[7])
                                          .toList();

                                  _issueOfTheMonthBehavioralDataData =
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

                                  _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
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

                                      _issueOfTheMonthSocialMediaData =
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
                                            minValue: newMinValue.toDouble(),
                                            maxValue: maxValue,
                                            value: value,
                                          )
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[0])
                                              .toList();

                                      _issueOfTheMonthSongData = textAnalysisFilterFunction(
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
                                        minValue: newMinValue.toDouble(),
                                        maxValue: maxValue,
                                        value: value,
                                      )
                                          .where((element) =>
                                      element.sourceCategory == qualitativeDataSourceList[1])
                                          .toList();

                                      _issueOfTheMonthReligiousSpeechesData =
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
                                            minValue: newMinValue.toDouble(),
                                            maxValue: maxValue,
                                            value: value,
                                          )
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[2])
                                              .toList();

                                      _issueOfTheMonthInterviewsData =
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
                                            minValue: newMinValue.toDouble(),
                                            maxValue: maxValue,
                                            value: value,
                                          )
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[3])
                                              .toList();

                                      _issueOfTheMonthVisualAnthropologyData =
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
                                            minValue: newMinValue.toDouble(),
                                            maxValue: maxValue,
                                            value: value,)
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[4])
                                              .toList();

                                      _issueOfTheMonthGISData = textAnalysisFilterFunction(
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
                                        minValue: newMinValue.toDouble(),
                                        maxValue: maxValue,
                                        value: value,
                                      )
                                          .where((element) =>
                                      element.sourceCategory == qualitativeDataSourceList[5])
                                          .toList();

                                      _issueOfTheMonthForesightAndScenariosBuildingData =
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
                                            minValue: newMinValue.toDouble(),
                                            maxValue: maxValue,
                                            value: value,)
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[6])
                                              .toList();

                                      _issueOfTheMonthPublicPerceptionSurveyData =
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
                                            minValue: newMinValue.toDouble(),
                                            maxValue: maxValue,
                                            value: value,)
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[7])
                                              .toList();

                                      _issueOfTheMonthBehavioralDataData =
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
                                            minValue: newMinValue.toDouble(),
                                            maxValue: maxValue,
                                            value: value,
                                          )
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[8])
                                              .toList();

                                      _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
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
                                            minValue: newMinValue.toDouble(),
                                            maxValue: maxValue,
                                            value: value,
                                          )
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[9])
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

                                      _issueOfTheMonthSocialMediaData =
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
                                            maxValue: newMaxValue.toDouble(),
                                            value: value,
                                          )
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[0])
                                              .toList();

                                      _issueOfTheMonthSongData = textAnalysisFilterFunction(
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
                                        maxValue: newMaxValue.toDouble(),
                                        value: value,
                                      )
                                          .where((element) =>
                                      element.sourceCategory == qualitativeDataSourceList[1])
                                          .toList();

                                      _issueOfTheMonthReligiousSpeechesData =
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
                                            maxValue: newMaxValue.toDouble(),
                                            value: value,
                                          )
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[2])
                                              .toList();

                                      _issueOfTheMonthInterviewsData =
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
                                            maxValue: newMaxValue.toDouble(),
                                            value: value,
                                          )
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[3])
                                              .toList();

                                      _issueOfTheMonthVisualAnthropologyData =
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
                                            maxValue: newMaxValue.toDouble(),
                                            value: value,)
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[4])
                                              .toList();

                                      _issueOfTheMonthGISData = textAnalysisFilterFunction(
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
                                        maxValue: newMaxValue.toDouble(),
                                        value: value,
                                      )
                                          .where((element) =>
                                      element.sourceCategory == qualitativeDataSourceList[5])
                                          .toList();

                                      _issueOfTheMonthForesightAndScenariosBuildingData =
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
                                            maxValue: newMaxValue.toDouble(),
                                            value: value,)
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[6])
                                              .toList();

                                      _issueOfTheMonthPublicPerceptionSurveyData =
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
                                            maxValue: newMaxValue.toDouble(),
                                            value: value,)
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[7])
                                              .toList();

                                      _issueOfTheMonthBehavioralDataData =
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
                                            maxValue: newMaxValue.toDouble(),
                                            value: value,
                                          )
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[8])
                                              .toList();

                                      _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
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
                                            maxValue: newMaxValue.toDouble(),
                                            value: value,
                                          )
                                              .where((element) =>
                                          element.sourceCategory ==
                                              qualitativeDataSourceList[9])
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


                                  _issueOfTheMonthSocialMediaData =
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
                                        value: newValue.toDouble(),
                                      )
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[0])
                                          .toList();

                                  _issueOfTheMonthSongData = textAnalysisFilterFunction(
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
                                    value: newValue.toDouble(),
                                  )
                                      .where((element) =>
                                  element.sourceCategory == qualitativeDataSourceList[1])
                                      .toList();

                                  _issueOfTheMonthReligiousSpeechesData =
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
                                        value: newValue.toDouble(),
                                      )
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[2])
                                          .toList();

                                  _issueOfTheMonthInterviewsData =
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
                                        value: newValue.toDouble(),
                                      )
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[3])
                                          .toList();

                                  _issueOfTheMonthVisualAnthropologyData =
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
                                        value: newValue.toDouble(),
                                      )
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[4])
                                          .toList();

                                  _issueOfTheMonthGISData = textAnalysisFilterFunction(
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
                                    value: newValue.toDouble(),
                                  )
                                      .where((element) =>
                                  element.sourceCategory == qualitativeDataSourceList[5])
                                      .toList();

                                  _issueOfTheMonthForesightAndScenariosBuildingData =
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
                                        value: newValue.toDouble(),
                                      )
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[6])
                                          .toList();

                                  _issueOfTheMonthPublicPerceptionSurveyData =
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
                                        value: newValue.toDouble(),)
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[7])
                                          .toList();

                                  _issueOfTheMonthBehavioralDataData =
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
                                        value: newValue.toDouble(),
                                      )
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[8])
                                          .toList();

                                  _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
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
                                        value: newValue.toDouble(),
                                      )
                                          .where((element) =>
                                      element.sourceCategory ==
                                          qualitativeDataSourceList[9])
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

                          _issueOfTheMonthSocialMediaData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthSongData = textAnalysisFilterFunction(
                              readEmergenceIssueDataJsonFileContent:
                              readEmergenceIssueDataJsonFileContent,
                              sourceFilterSelectedOption:
                              sourceFilterSelectedOption,
                              searchQuery: searchQuery,
                              sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                              languageSelectedOption: allSelectedItems,
                              sdgSelectedOption: sdgSelectedOption,
                              numberFilterSelectedOption:
                              numberFilterSelectedOption,
                              minValue: minValue,
                              maxValue: maxValue,
                              value: value)
                              .where((element) =>
                          element.sourceCategory == qualitativeDataSourceList[1])
                              .toList();

                          _issueOfTheMonthReligiousSpeechesData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthInterviewsData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthVisualAnthropologyData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthGISData = textAnalysisFilterFunction(
                              readEmergenceIssueDataJsonFileContent:
                              readEmergenceIssueDataJsonFileContent,
                              sourceFilterSelectedOption:
                              sourceFilterSelectedOption,
                              searchQuery: searchQuery,
                              sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                              languageSelectedOption: allSelectedItems,
                              sdgSelectedOption: sdgSelectedOption,
                              numberFilterSelectedOption:
                              numberFilterSelectedOption,
                              minValue: minValue,
                              maxValue: maxValue,
                              value: value)
                              .where((element) =>
                          element.sourceCategory == qualitativeDataSourceList[5])
                              .toList();

                          _issueOfTheMonthForesightAndScenariosBuildingData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthPublicPerceptionSurveyData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthBehavioralDataData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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


                          _issueOfTheMonthSocialMediaData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthSongData = textAnalysisFilterFunction(
                              readEmergenceIssueDataJsonFileContent:
                              readEmergenceIssueDataJsonFileContent,
                              sourceFilterSelectedOption:
                              sourceFilterSelectedOption,
                              searchQuery: searchQuery,
                              sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                              languageSelectedOption: allSelectedItems,
                              sdgSelectedOption: sdgSelectedOption,
                              numberFilterSelectedOption:
                              numberFilterSelectedOption,
                              minValue: minValue,
                              maxValue: maxValue,
                              value: value)
                              .where((element) =>
                          element.sourceCategory == qualitativeDataSourceList[1])
                              .toList();

                          _issueOfTheMonthReligiousSpeechesData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthInterviewsData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthVisualAnthropologyData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthGISData = textAnalysisFilterFunction(
                              readEmergenceIssueDataJsonFileContent:
                              readEmergenceIssueDataJsonFileContent,
                              sourceFilterSelectedOption:
                              sourceFilterSelectedOption,
                              searchQuery: searchQuery,
                              sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                              languageSelectedOption: allSelectedItems,
                              sdgSelectedOption: sdgSelectedOption,
                              numberFilterSelectedOption:
                              numberFilterSelectedOption,
                              minValue: minValue,
                              maxValue: maxValue,
                              value: value)
                              .where((element) =>
                          element.sourceCategory == qualitativeDataSourceList[5])
                              .toList();

                          _issueOfTheMonthForesightAndScenariosBuildingData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthPublicPerceptionSurveyData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthBehavioralDataData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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

                          _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
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


                          _issueOfTheMonthSocialMediaData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthSongData = textAnalysisFilterFunction(
                              readEmergenceIssueDataJsonFileContent:
                              readEmergenceIssueDataJsonFileContent,
                              sourceFilterSelectedOption:
                              sourceFilterSelectedOption,
                              searchQuery: searchQuery,
                              sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                              languageSelectedOption: languageSelectedOption,
                              sdgSelectedOption: allSelectedItems,
                              numberFilterSelectedOption:
                              numberFilterSelectedOption,
                              minValue: minValue,
                              maxValue: maxValue,
                              value: value)
                              .where((element) =>
                          element.sourceCategory == qualitativeDataSourceList[1])
                              .toList();

                          _issueOfTheMonthReligiousSpeechesData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthInterviewsData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthVisualAnthropologyData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthGISData = textAnalysisFilterFunction(
                              readEmergenceIssueDataJsonFileContent:
                              readEmergenceIssueDataJsonFileContent,
                              sourceFilterSelectedOption:
                              sourceFilterSelectedOption,
                              searchQuery: searchQuery,
                              sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                              languageSelectedOption: languageSelectedOption,
                              sdgSelectedOption: allSelectedItems,
                              numberFilterSelectedOption:
                              numberFilterSelectedOption,
                              minValue: minValue,
                              maxValue: maxValue,
                              value: value)
                              .where((element) =>
                          element.sourceCategory == qualitativeDataSourceList[5])
                              .toList();

                          _issueOfTheMonthForesightAndScenariosBuildingData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthPublicPerceptionSurveyData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthBehavioralDataData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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


                          _issueOfTheMonthSocialMediaData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthSongData = textAnalysisFilterFunction(
                              readEmergenceIssueDataJsonFileContent:
                              readEmergenceIssueDataJsonFileContent,
                              sourceFilterSelectedOption:
                              sourceFilterSelectedOption,
                              searchQuery: searchQuery,
                              sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                              languageSelectedOption: languageSelectedOption,
                              sdgSelectedOption: allSelectedItems,
                              numberFilterSelectedOption:
                              numberFilterSelectedOption,
                              minValue: minValue,
                              maxValue: maxValue,
                              value: value)
                              .where((element) =>
                          element.sourceCategory == qualitativeDataSourceList[1])
                              .toList();

                          _issueOfTheMonthReligiousSpeechesData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthInterviewsData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthVisualAnthropologyData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthGISData = textAnalysisFilterFunction(
                              readEmergenceIssueDataJsonFileContent:
                              readEmergenceIssueDataJsonFileContent,
                              sourceFilterSelectedOption:
                              sourceFilterSelectedOption,
                              searchQuery: searchQuery,
                              sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                              languageSelectedOption: languageSelectedOption,
                              sdgSelectedOption: allSelectedItems,
                              numberFilterSelectedOption:
                              numberFilterSelectedOption,
                              minValue: minValue,
                              maxValue: maxValue,
                              value: value)
                              .where((element) =>
                          element.sourceCategory == qualitativeDataSourceList[5])
                              .toList();

                          _issueOfTheMonthForesightAndScenariosBuildingData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthPublicPerceptionSurveyData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthBehavioralDataData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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

                          _issueOfTheMonthOpinionDynamicsAndSociophysicsData =
                              textAnalysisFilterFunction(
                                  readEmergenceIssueDataJsonFileContent:
                                  readEmergenceIssueDataJsonFileContent,
                                  sourceFilterSelectedOption:
                                  sourceFilterSelectedOption,
                                  searchQuery: searchQuery,
                                  sentimentAnalysisFilterSelectedOption: sentimentAnalysisFilterSelectedOption,
                                  languageSelectedOption: languageSelectedOption,
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
  //TODO: DELETE
  ///BUILD PAGES VARIABLES
  bool showLoadingIndicator = false;
  double pageCount = 0;

  buildDataContentPerSource(Size screenSize) {
    pageCount =
        (issueOfMonthFinalSearchDataList.length / _rowsPerPage).ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: pageCount,
                onPageNavigationStart: (pageIndex) {
                  setState(() {
                    showLoadingIndicator = true;
                  });
                },
                onPageNavigationEnd: (pageIndex) {
                  setState(() {
                    showLoadingIndicator = false;
                  });
                },
                delegate: CustomSliverChildBuilderDelegateForIssuesData(
                  indexBuilder,
                  issueOfMonthFinalSearchDataList,
                  screenSize,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }
  
  Widget loadListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (issueOfMonthFinalSearchDataList.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateForIssuesData(
              indexBuilder,
              issueOfMonthFinalSearchDataList,
              screenSize,
            ),
          ),
        );
      }

      if (showLoadingIndicator) {
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

  Widget indexBuilder(BuildContext context, int index) {
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
                            issueOfMonthFinalSearchDataList[index].source ==
                                    null
                                ? ""
                                : issueOfMonthFinalSearchDataList[index]
                                    .source!
                                    .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(issueOfMonthFinalSearchDataList[index]
                                      .source ==
                                  null
                              ? ""
                              : issueOfMonthFinalSearchDataList[index].source!),
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
                        issueOfMonthFinalSearchDataList[index].issueString ==
                                null
                            ? ""
                            : issueOfMonthFinalSearchDataList[index]
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
                        issueOfMonthFinalSearchDataList[index].repetition ==
                                null
                            ? ""
                            : '${issueOfMonthFinalSearchDataList[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        issueOfMonthFinalSearchDataList[index]
                                    .sentimentAnalysis ==
                                null
                            ? ""
                            : issueOfMonthFinalSearchDataList[index]
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
                      color: issueOfMonthFinalSearchDataList[index]
                                  .sentimentAnalysis ==
                              "Negative"
                          ? Colors.red
                          : issueOfMonthFinalSearchDataList[index]
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
          _issueOfTheMonthSocialMediaData,
        ),
        buildSongDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[1],
          _issueOfTheMonthSongData,
        ),
        buildReligiousSpeechesDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[2],
          _issueOfTheMonthReligiousSpeechesData,
        ),
        buildInterviewsDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[3],
          _issueOfTheMonthInterviewsData,
        ),
        buildVisualAnthropologyDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[4],
          _issueOfTheMonthVisualAnthropologyData,
        ),
        buildGISDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[5],
          _issueOfTheMonthGISData,
        ),
        buildForesightAndScenariosBuildingDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[6],
          _issueOfTheMonthForesightAndScenariosBuildingData,
        ),
        buildPublicPerceptionSurveyDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[7],
          _issueOfTheMonthPublicPerceptionSurveyData,
        ),
        buildBehavioralDataDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[8],
          _issueOfTheMonthBehavioralDataData,
        ),
        buildOpinionDynamicsAndSociophysicsDataContentWithHeading(
          screenSize,
          qualitativeDataSourceList[9],
          _issueOfTheMonthOpinionDynamicsAndSociophysicsData,
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

  buildSocialMediaDataContentWithHeading (Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_issueOfTheMonthSocialMediaData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _issueOfTheMonthSocialMediaData.isEmpty
                      ? Container()
                      : buildSocialMediaDataContent(
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

  buildSocialMediaDataContent(Size screenSize) {
    socialMediaPageCount =
        (_issueOfTheMonthSocialMediaData.length / _socialMediaRowsPerPage).ceilToDouble();

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
                // key: PageStorageKey(_issueOfTheMonthSocialMediaData),
                pageCount: socialMediaPageCount,
                availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _socialMediaRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },
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
                delegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthSocialMediaData(
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

      if (_issueOfTheMonthSocialMediaData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthSocialMediaData(
                indexSocialMediaBuilder
            ),
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
                            _paginatedIssueOfTheMonthSocialMediaData[index].source ==
                                null
                                ? ""
                                : _paginatedIssueOfTheMonthSocialMediaData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedIssueOfTheMonthSocialMediaData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedIssueOfTheMonthSocialMediaData[index].source!),
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
                        _paginatedIssueOfTheMonthSocialMediaData[index].issueString ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthSocialMediaData[index]
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
                        _paginatedIssueOfTheMonthSocialMediaData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedIssueOfTheMonthSocialMediaData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedIssueOfTheMonthSocialMediaData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthSocialMediaData[index]
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
                      color: _paginatedIssueOfTheMonthSocialMediaData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedIssueOfTheMonthSocialMediaData[index]
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

  buildSongDataContentWithHeading (Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_issueOfTheMonthSongData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _issueOfTheMonthSongData.isEmpty
                      ? Container()
                      : buildSongDataContent(
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

  buildSongDataContent(Size screenSize) {
    songPageCount =
        (_issueOfTheMonthSongData.length / _songRowsPerPage).ceilToDouble();

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
                availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _songRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },
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
                delegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthSongData(
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

      if (_issueOfTheMonthSongData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthSongData(
                indexSongBuilder
            ),
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
                            _paginatedIssueOfTheMonthSongData[index].source ==
                                null
                                ? ""
                                : _paginatedIssueOfTheMonthSongData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedIssueOfTheMonthSongData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedIssueOfTheMonthSongData[index].source!),
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
                        _paginatedIssueOfTheMonthSongData[index].issueString ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthSongData[index]
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
                        _paginatedIssueOfTheMonthSongData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedIssueOfTheMonthSongData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedIssueOfTheMonthSongData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthSongData[index]
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
                      color: _paginatedIssueOfTheMonthSongData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedIssueOfTheMonthSongData[index]
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

  buildReligiousSpeechesDataContentWithHeading (Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_issueOfTheMonthReligiousSpeechesData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _issueOfTheMonthReligiousSpeechesData.isEmpty
                      ? Container()
                      : buildReligiousSpeechesDataContent(
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

  buildReligiousSpeechesDataContent(Size screenSize) {
    religiousSpeechesPageCount =
        (_issueOfTheMonthReligiousSpeechesData.length / _religiousSpeechesRowsPerPage).ceilToDouble();

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

                availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _religiousSpeechesRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },
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
                delegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthReligiousSpeechesData(
                    indexReligiousSpeechesBuilder
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadReligiousSpeechesListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_issueOfTheMonthReligiousSpeechesData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthReligiousSpeechesData(
                indexReligiousSpeechesBuilder
            ),
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
                            _paginatedIssueOfTheMonthReligiousSpeechesData[index].source ==
                                null
                                ? ""
                                : _paginatedIssueOfTheMonthReligiousSpeechesData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedIssueOfTheMonthReligiousSpeechesData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedIssueOfTheMonthReligiousSpeechesData[index].source!),
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
                        _paginatedIssueOfTheMonthReligiousSpeechesData[index].issueString ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthReligiousSpeechesData[index]
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
                        _paginatedIssueOfTheMonthReligiousSpeechesData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedIssueOfTheMonthReligiousSpeechesData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedIssueOfTheMonthReligiousSpeechesData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthReligiousSpeechesData[index]
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
                      color: _paginatedIssueOfTheMonthReligiousSpeechesData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedIssueOfTheMonthReligiousSpeechesData[index]
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

  buildInterviewsDataContentWithHeading (Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_issueOfTheMonthInterviewsData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _issueOfTheMonthInterviewsData.isEmpty
                      ? Container()
                      : buildInterviewsDataContent(
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

  buildInterviewsDataContent(Size screenSize) {
    interviewsPageCount =
        (_issueOfTheMonthInterviewsData.length / _interviewsRowsPerPage).ceilToDouble();

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

                availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _interviewsRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },
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
                delegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthInterviewsData(
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

      if (_issueOfTheMonthInterviewsData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthInterviewsData(
                indexInterviewsBuilder
            ),
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
                            _paginatedIssueOfTheMonthInterviewsData[index].source ==
                                null
                                ? ""
                                : _paginatedIssueOfTheMonthInterviewsData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedIssueOfTheMonthInterviewsData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedIssueOfTheMonthInterviewsData[index].source!),
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
                        _paginatedIssueOfTheMonthInterviewsData[index].issueString ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthInterviewsData[index]
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
                        _paginatedIssueOfTheMonthInterviewsData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedIssueOfTheMonthInterviewsData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedIssueOfTheMonthInterviewsData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthInterviewsData[index]
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
                      color: _paginatedIssueOfTheMonthInterviewsData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedIssueOfTheMonthInterviewsData[index]
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

  buildVisualAnthropologyDataContentWithHeading (Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_issueOfTheMonthVisualAnthropologyData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _issueOfTheMonthVisualAnthropologyData.isEmpty
                      ? Container()
                      : buildVisualAnthropologyDataContent(
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

  buildVisualAnthropologyDataContent(Size screenSize) {
    visualAnthropologyPageCount =
        (_issueOfTheMonthVisualAnthropologyData.length / _visualAnthropologyRowsPerPage).ceilToDouble();

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

                availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _visualAnthropologyRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },
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
                delegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthVisualAnthropologyData(
                  indexVisualAnthropologyBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadVisualAnthropologyListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_issueOfTheMonthVisualAnthropologyData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthVisualAnthropologyData(
                indexVisualAnthropologyBuilder
            ),
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
                            _paginatedIssueOfTheMonthVisualAnthropologyData[index].source ==
                                null
                                ? ""
                                : _paginatedIssueOfTheMonthVisualAnthropologyData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedIssueOfTheMonthVisualAnthropologyData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedIssueOfTheMonthVisualAnthropologyData[index].source!),
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
                        _paginatedIssueOfTheMonthVisualAnthropologyData[index].issueString ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthVisualAnthropologyData[index]
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
                        _paginatedIssueOfTheMonthVisualAnthropologyData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedIssueOfTheMonthVisualAnthropologyData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedIssueOfTheMonthVisualAnthropologyData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthVisualAnthropologyData[index]
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
                      color: _paginatedIssueOfTheMonthVisualAnthropologyData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedIssueOfTheMonthVisualAnthropologyData[index]
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

  buildGISDataContentWithHeading (Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_issueOfTheMonthGISData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _issueOfTheMonthGISData.isEmpty
                      ? Container()
                      : buildGISDataContent(
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

  buildGISDataContent(Size screenSize) {
    gisPageCount =
        (_issueOfTheMonthGISData.length / _gisRowsPerPage).ceilToDouble();

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
                availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _gisRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },
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
                delegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthGISData(
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

      if (_issueOfTheMonthGISData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthGISData(
                indexGISBuilder
            ),
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
                            _paginatedIssueOfTheMonthGISData[index].source ==
                                null
                                ? ""
                                : _paginatedIssueOfTheMonthGISData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedIssueOfTheMonthGISData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedIssueOfTheMonthGISData[index].source!),
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
                        _paginatedIssueOfTheMonthGISData[index].issueString ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthGISData[index]
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
                        _paginatedIssueOfTheMonthGISData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedIssueOfTheMonthGISData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedIssueOfTheMonthGISData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthGISData[index]
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
                      color: _paginatedIssueOfTheMonthGISData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedIssueOfTheMonthGISData[index]
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

  buildForesightAndScenariosBuildingDataContentWithHeading (Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_issueOfTheMonthForesightAndScenariosBuildingData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _issueOfTheMonthForesightAndScenariosBuildingData.isEmpty
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
        (_issueOfTheMonthForesightAndScenariosBuildingData.length / _foresightAndScenariosBuildingRowsPerPage).ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadForesightAndScenariosBuildingListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: foresightAndScenariosBuildingPageCount,
                availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _foresightAndScenariosBuildingRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },
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
                delegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthForesightAndScenariosBuildingData(
                  indexForesightAndScenariosBuildingBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadForesightAndScenariosBuildingListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_issueOfTheMonthForesightAndScenariosBuildingData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthForesightAndScenariosBuildingData(
                indexForesightAndScenariosBuildingBuilder
            ),
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

  Widget indexForesightAndScenariosBuildingBuilder(BuildContext context, int index) {
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
                            _paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index].source ==
                                null
                                ? ""
                                : _paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index].source!),
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
                        _paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index].issueString ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index]
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
                        _paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index]
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
                      color: _paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedIssueOfTheMonthForesightAndScenariosBuildingData[index]
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

  buildPublicPerceptionSurveyDataContentWithHeading (Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_issueOfTheMonthPublicPerceptionSurveyData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _issueOfTheMonthPublicPerceptionSurveyData.isEmpty
                      ? Container()
                      : buildPublicPerceptionSurveyDataContent(
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

  buildPublicPerceptionSurveyDataContent(Size screenSize) {
    publicPerceptionSurveyPageCount =
        (_issueOfTheMonthPublicPerceptionSurveyData.length / _publicPerceptionSurveyRowsPerPage).ceilToDouble();

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
                availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _publicPerceptionSurveyRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },
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
                delegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthPublicPerceptionSurveyData(
                  indexPublicPerceptionSurveyBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadPublicPerceptionSurveyListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_issueOfTheMonthPublicPerceptionSurveyData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthPublicPerceptionSurveyData(
                indexPublicPerceptionSurveyBuilder
            ),
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
                            _paginatedIssueOfTheMonthPublicPerceptionSurveyData[index].source ==
                                null
                                ? ""
                                : _paginatedIssueOfTheMonthPublicPerceptionSurveyData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedIssueOfTheMonthPublicPerceptionSurveyData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedIssueOfTheMonthPublicPerceptionSurveyData[index].source!),
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
                        _paginatedIssueOfTheMonthPublicPerceptionSurveyData[index].issueString ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthPublicPerceptionSurveyData[index]
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
                        _paginatedIssueOfTheMonthPublicPerceptionSurveyData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedIssueOfTheMonthPublicPerceptionSurveyData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedIssueOfTheMonthPublicPerceptionSurveyData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthPublicPerceptionSurveyData[index]
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
                      color: _paginatedIssueOfTheMonthPublicPerceptionSurveyData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedIssueOfTheMonthPublicPerceptionSurveyData[index]
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

  buildBehavioralDataDataContentWithHeading (Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_issueOfTheMonthBehavioralDataData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _issueOfTheMonthBehavioralDataData.isEmpty
                      ? Container()
                      : buildBehavioralDataDataContent(
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

  buildBehavioralDataDataContent(Size screenSize) {
    behavioralDataPageCount =
        (_issueOfTheMonthBehavioralDataData.length / _behavioralDataRowsPerPage).ceilToDouble();

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
                availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _behavioralDataRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },
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
                delegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthBehavioralDataData(
                  indexBehavioralDataBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadBehavioralDataListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_issueOfTheMonthBehavioralDataData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthBehavioralDataData(
                indexBehavioralDataBuilder
            ),
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
                            _paginatedIssueOfTheMonthBehavioralDataData[index].source ==
                                null
                                ? ""
                                : _paginatedIssueOfTheMonthBehavioralDataData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedIssueOfTheMonthBehavioralDataData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedIssueOfTheMonthBehavioralDataData[index].source!),
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
                        _paginatedIssueOfTheMonthBehavioralDataData[index].issueString ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthBehavioralDataData[index]
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
                        _paginatedIssueOfTheMonthBehavioralDataData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedIssueOfTheMonthBehavioralDataData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedIssueOfTheMonthBehavioralDataData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthBehavioralDataData[index]
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
                      color: _paginatedIssueOfTheMonthBehavioralDataData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedIssueOfTheMonthBehavioralDataData[index]
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

  buildOpinionDynamicsAndSociophysicsDataContentWithHeading (Size screenSize, String selectedDataSourceCategory,
      List<IssueOfMonthDataModel> issueOfMonthData) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 0.0,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ExpansionTile(
          title: Text(
              "$selectedDataSourceCategory (${_issueOfTheMonthOpinionDynamicsAndSociophysicsData.length})"),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  buildSourcesDataContentHeader(screenSize),
                  const SizedBox(height: 10),
                  const Divider(),
                  _issueOfTheMonthOpinionDynamicsAndSociophysicsData.isEmpty
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
        (_issueOfTheMonthOpinionDynamicsAndSociophysicsData.length / _opinionDynamicsAndSociophysicsRowsPerPage).ceilToDouble();

    return SizedBox(
      height: screenSize.height * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadOpinionDynamicsAndSociophysicsListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(issueOfMonthFinalSearchDataList),
                pageCount: opinionDynamicsAndSociophysicsPageCount,
                availableRowsPerPage: const [10, 20, 30],
                onRowsPerPageChanged: (int? rowsPerPage) {
                  setState(() {
                    _opinionDynamicsAndSociophysicsRowsPerPage = rowsPerPage!;
                    // employeeDataSource.updateDataGriDataSource();
                  });
                },
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
                delegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthOpinionDynamicsAndSociophysicsData(
                  indexOpinionDynamicsAndSociophysicsBuilder,
                )..addListener(rebuildList),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget loadOpinionDynamicsAndSociophysicsListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_issueOfTheMonthOpinionDynamicsAndSociophysicsData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthOpinionDynamicsAndSociophysicsData(
                indexOpinionDynamicsAndSociophysicsBuilder
            ),
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

  Widget indexOpinionDynamicsAndSociophysicsBuilder(BuildContext context, int index) {
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
                            _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index].source ==
                                null
                                ? ""
                                : _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index].source!),
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
                        _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index].issueString ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index]
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
                        _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index]
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
                      color: _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData[index]
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

///------------------------------- COMPONENTS -------------------------------///

class IssueOfMonthModelChartData {
  IssueOfMonthModelChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}

class CommentChartDataModel {
  CommentChartDataModel(
    this.day,
    this.dataCount,
  );

  final String day;
  final double dataCount;
}

///------------------------------------------------- COMPONENTS -------------------------------------------------///

int _rowsPerPage = 10;

class CustomSliverChildBuilderDelegateForIssuesData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateForIssuesData(builder, this.finalSearchList, this.screenSize)
      : super(builder);

  final List<IssueOfMonthDataModel> finalSearchList;

  final Size screenSize;

  int rowsPerPage = 10;

  @override
  int get childCount => finalSearchList.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {

    int startRowIndex = newPageIndex * rowsPerPage;
    int endRowIndex = startRowIndex + rowsPerPage;

    if (endRowIndex > finalSearchList.length) {
      endRowIndex = finalSearchList.length ;
    }

    /// Get particular range from the sorted collection.
    if (startRowIndex < finalSearchList.length &&
        endRowIndex <= finalSearchList.length) {
       finalSearchList.getRange(startRowIndex, endRowIndex).toList();
    } else {
       finalSearchList;
    }
    // buildDataContentPerSource(screenSize);

    await Future.delayed(const Duration(milliseconds: 2000));
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(
      covariant CustomSliverChildBuilderDelegateForIssuesData oldDelegate) {
    return true;
  }
}


///------------------------------------------------------------------------------------ DETERMINE CONTENT FOR NEXT PAGE ------------------------------------------------------------------------------------///


///-------------------------------- Social Media --------------------------------///

List<IssueOfMonthDataModel> _paginatedIssueOfTheMonthSocialMediaData = [];
List<IssueOfMonthDataModel> _issueOfTheMonthSocialMediaData = [];

int _socialMediaRowsPerPage = 10;

class CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthSocialMediaData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthSocialMediaData(builder)
      : super(builder);

  @override
  int get childCount => _paginatedIssueOfTheMonthSocialMediaData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _socialMediaRowsPerPage;
    int endRowIndex = startRowIndex + _socialMediaRowsPerPage;

    if (endRowIndex > _issueOfTheMonthSocialMediaData.length) {
      endRowIndex = _issueOfTheMonthSocialMediaData.length ;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedIssueOfTheMonthSocialMediaData =
        _issueOfTheMonthSocialMediaData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthSocialMediaData oldDelegate) {
    return true;
  }
}


///-------------------------------- Song --------------------------------///

List<IssueOfMonthDataModel> _paginatedIssueOfTheMonthSongData = [];
List<IssueOfMonthDataModel> _issueOfTheMonthSongData = [];

int _songRowsPerPage = 10;

class CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthSongData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthSongData(builder)
      : super(builder);

  @override
  int get childCount => _paginatedIssueOfTheMonthSongData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _songRowsPerPage;
    int endRowIndex = startRowIndex + _songRowsPerPage;

    if (endRowIndex > _issueOfTheMonthSongData.length) {
      endRowIndex = _issueOfTheMonthSongData.length ;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedIssueOfTheMonthSongData = _issueOfTheMonthSongData
        .getRange(startRowIndex, endRowIndex)
        .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthSongData oldDelegate) {
    return true;
  }
}

///-------------------------------- Religious Speeches --------------------------------///

List<IssueOfMonthDataModel> _paginatedIssueOfTheMonthReligiousSpeechesData =
[];
List<IssueOfMonthDataModel> _issueOfTheMonthReligiousSpeechesData = [];

int _religiousSpeechesRowsPerPage = 10;

class CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthReligiousSpeechesData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthReligiousSpeechesData(
      builder)
      : super(builder);

  @override
  int get childCount => _paginatedIssueOfTheMonthReligiousSpeechesData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _religiousSpeechesRowsPerPage;
    int endRowIndex = startRowIndex + _religiousSpeechesRowsPerPage;

    if (endRowIndex > _issueOfTheMonthReligiousSpeechesData.length) {
      endRowIndex = _issueOfTheMonthReligiousSpeechesData.length ;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedIssueOfTheMonthReligiousSpeechesData =
        _issueOfTheMonthReligiousSpeechesData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthReligiousSpeechesData oldDelegate) {
    return true;
  }
}

///-------------------------------- Interviews --------------------------------///

List<IssueOfMonthDataModel> _paginatedIssueOfTheMonthInterviewsData = [];
List<IssueOfMonthDataModel> _issueOfTheMonthInterviewsData = [];

int _interviewsRowsPerPage = 10;

class CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthInterviewsData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthInterviewsData(builder)
      : super(builder);

  @override
  int get childCount => _paginatedIssueOfTheMonthInterviewsData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _interviewsRowsPerPage;
    int endRowIndex = startRowIndex + _interviewsRowsPerPage;

    if (endRowIndex > _issueOfTheMonthInterviewsData.length) {
      endRowIndex = _issueOfTheMonthInterviewsData.length ;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedIssueOfTheMonthInterviewsData =
        _issueOfTheMonthInterviewsData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthInterviewsData oldDelegate) {
    return true;
  }
}

///-------------------------------- Visual Anthropology --------------------------------///

List<IssueOfMonthDataModel>
_paginatedIssueOfTheMonthVisualAnthropologyData = [];
List<IssueOfMonthDataModel> _issueOfTheMonthVisualAnthropologyData = [];

int _visualAnthropologyRowsPerPage = 10;

class CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthVisualAnthropologyData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthVisualAnthropologyData(
      builder)
      : super(builder);

  @override
  int get childCount => _paginatedIssueOfTheMonthVisualAnthropologyData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _visualAnthropologyRowsPerPage;
    int endRowIndex = startRowIndex + _visualAnthropologyRowsPerPage;

    if (endRowIndex > _issueOfTheMonthVisualAnthropologyData.length) {
      endRowIndex = _issueOfTheMonthVisualAnthropologyData.length ;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedIssueOfTheMonthVisualAnthropologyData =
        _issueOfTheMonthVisualAnthropologyData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthVisualAnthropologyData oldDelegate) {
    return true;
  }
}

///-------------------------------- GIS --------------------------------///

List<IssueOfMonthDataModel> _paginatedIssueOfTheMonthGISData = [];
List<IssueOfMonthDataModel> _issueOfTheMonthGISData = [];

int _gisRowsPerPage = 10;

class CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthGISData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthGISData(builder)
      : super(builder);

  @override
  int get childCount => _paginatedIssueOfTheMonthGISData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _gisRowsPerPage;
    int endRowIndex = startRowIndex + _gisRowsPerPage;

    if (endRowIndex > _issueOfTheMonthGISData.length) {
      endRowIndex = _issueOfTheMonthGISData.length ;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedIssueOfTheMonthGISData = _issueOfTheMonthGISData
        .getRange(startRowIndex, endRowIndex)
        .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthGISData oldDelegate) {
    return true;
  }
}

///-------------------------------- Foresight And Scenarios Building --------------------------------///

List<IssueOfMonthDataModel>
_paginatedIssueOfTheMonthForesightAndScenariosBuildingData = [];
List<IssueOfMonthDataModel>
_issueOfTheMonthForesightAndScenariosBuildingData = [];

int _foresightAndScenariosBuildingRowsPerPage = 10;

class CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthForesightAndScenariosBuildingData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthForesightAndScenariosBuildingData(
      builder)
      : super(builder);

  @override
  int get childCount =>
      _paginatedIssueOfTheMonthForesightAndScenariosBuildingData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _foresightAndScenariosBuildingRowsPerPage;
    int endRowIndex = startRowIndex + _foresightAndScenariosBuildingRowsPerPage;

    if (endRowIndex >
        _issueOfTheMonthForesightAndScenariosBuildingData.length) {
      endRowIndex =
          _issueOfTheMonthForesightAndScenariosBuildingData.length ;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedIssueOfTheMonthForesightAndScenariosBuildingData =
        _issueOfTheMonthForesightAndScenariosBuildingData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthForesightAndScenariosBuildingData oldDelegate) {
    return true;
  }
}

///-------------------------------- Public Perception Survey --------------------------------///

List<IssueOfMonthDataModel>
_paginatedIssueOfTheMonthPublicPerceptionSurveyData = [];
List<IssueOfMonthDataModel> _issueOfTheMonthPublicPerceptionSurveyData = [];

int _publicPerceptionSurveyRowsPerPage = 10;

class CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthPublicPerceptionSurveyData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthPublicPerceptionSurveyData(
      builder)
      : super(builder);

  @override
  int get childCount => _paginatedIssueOfTheMonthPublicPerceptionSurveyData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _publicPerceptionSurveyRowsPerPage;
    int endRowIndex = startRowIndex + _publicPerceptionSurveyRowsPerPage;

    if (endRowIndex > _issueOfTheMonthPublicPerceptionSurveyData.length) {
      endRowIndex = _issueOfTheMonthPublicPerceptionSurveyData.length ;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedIssueOfTheMonthPublicPerceptionSurveyData =
        _issueOfTheMonthPublicPerceptionSurveyData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthPublicPerceptionSurveyData oldDelegate) {
    return true;
  }
}

///-------------------------------- Behavioural Data --------------------------------///

List<IssueOfMonthDataModel> _paginatedIssueOfTheMonthBehavioralDataData =
[];
List<IssueOfMonthDataModel> _issueOfTheMonthBehavioralDataData = [];

int _behavioralDataRowsPerPage = 10;

class CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthBehavioralDataData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthBehavioralDataData(builder)
      : super(builder);

  @override
  int get childCount => _paginatedIssueOfTheMonthBehavioralDataData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _behavioralDataRowsPerPage;
    int endRowIndex = startRowIndex + _behavioralDataRowsPerPage;

    if (endRowIndex > _issueOfTheMonthBehavioralDataData.length) {
      endRowIndex = _issueOfTheMonthBehavioralDataData.length ;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedIssueOfTheMonthBehavioralDataData =
        _issueOfTheMonthBehavioralDataData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthBehavioralDataData oldDelegate) {
    return true;
  }
}

///-------------------------------- Opinion dynamics and Sociophysics --------------------------------///

List<IssueOfMonthDataModel>
_paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData = [];
List<IssueOfMonthDataModel>
_issueOfTheMonthOpinionDynamicsAndSociophysicsData = [];

int _opinionDynamicsAndSociophysicsRowsPerPage = 10;

class CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthOpinionDynamicsAndSociophysicsData
    extends SliverChildBuilderDelegate with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthOpinionDynamicsAndSociophysicsData(
      builder)
      : super(builder);

  @override
  int get childCount =>
      _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _opinionDynamicsAndSociophysicsRowsPerPage;
    int endRowIndex = startRowIndex + _opinionDynamicsAndSociophysicsRowsPerPage;

    if (endRowIndex >
        _issueOfTheMonthOpinionDynamicsAndSociophysicsData.length) {
      endRowIndex =
          _issueOfTheMonthOpinionDynamicsAndSociophysicsData.length ;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedIssueOfTheMonthOpinionDynamicsAndSociophysicsData =
        _issueOfTheMonthOpinionDynamicsAndSociophysicsData
            .getRange(startRowIndex, endRowIndex)
            .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegateSelectedIssueOfTheMonthOpinionDynamicsAndSociophysicsData oldDelegate) {
    return true;
  }
}
