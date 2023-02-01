import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class DigitalAvatarScreen extends StatefulWidget {
  const DigitalAvatarScreen({Key? key}) : super(key: key);

  @override
  State<DigitalAvatarScreen> createState() => _DigitalAvatarScreenState();
}

class _DigitalAvatarScreenState extends State<DigitalAvatarScreen>
    with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  late List<ClusterModel> readJsonFileContent = <ClusterModel>[];
  late List<ClusterModel> cluster = <ClusterModel>[];
  late List<ClusterModel> searchClustersData = <ClusterModel>[];
  late List<ClusterModel> searchClusterWithAllIndicatorsData = <ClusterModel>[];
  late ClusterModel searchClusterWithSingleIndicatorsData = ClusterModel();

  TextEditingController taskSearchBarTextEditingController =
      TextEditingController();

  Future<List<ClusterModel>> readClustersFromJsonFile() async {
    /// Read Local Json File Directly
    /*String jsonString = await DefaultAssetBundle.of(context)
        .loadString('jsonDataFiles/interventions/project_data.json');*/
    //print(jsonString);

    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.cluster);

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

    if (response.statusCode == 200) {
      setState(() {
        readJsonFileContent = digitalAvatarListClusterModelFromJson(
            response.body); //(jsonString);
        //print("ALL CLUSTERS: $readJsonFileContent");

        if (selectedAgricultureIndicator == "" &&
            selectedConflictIndicator == "" &&
            selectedEconomicIndicator == "" &&
            selectedEducationIndicator == "" &&
            selectedEnvironmentIndicator == "" &&
            selectedFoodSecurityAndNutritionIndicator == "" &&
            selectedGenderIndicator == "" &&
            selectedHealthIndicator == "" &&
            selectedInfrastructureIndicator == "" &&
            selectedPopulationIndicator == "" &&
            selectedPovertyIndicator == "") {
          searchClusterWithAllIndicatorsData = readJsonFileContent;
        } else {
          searchClusterWithAllIndicatorsData =
              searchClusterWithAllIndicatorsData;
        }
      });

      return searchClusterWithAllIndicatorsData;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  ///VARIABLES USED TO MAP TO BE DISPLAYED
  late String selectedGeographicCoverage;

  ///VARIABLES USED FOR CLUSTER
  late String selectedCluster;

  ///VARIABLES USED FOR INDICATORS
  late String selectedAgricultureIndicator = "";
  late List<bool> isSelectedAgricultureIndicator;
  late String selectedConflictIndicator = "";
  late List<bool> isSelectedConflictIndicator;
  late String selectedEconomicIndicator = "";
  late List<bool> isSelectedEconomicIndicator;
  late String selectedEducationIndicator = "";
  late List<bool> isSelectedEducationIndicator;
  late String selectedEnvironmentIndicator = "";
  late List<bool> isSelectedEnvironmentIndicator;
  late String selectedFoodSecurityAndNutritionIndicator = "";
  late List<bool> isSelectedFoodSecurityAndNutritionIndicator;
  late String selectedGenderIndicator = "";
  late List<bool> isSelectedGenderIndicator;
  late String selectedHealthIndicator = "";
  late List<bool> isSelectedHealthIndicator;
  late String selectedInfrastructureIndicator = "";
  late List<bool> isSelectedInfrastructureIndicator;
  late String selectedPopulationIndicator = "";
  late List<bool> isSelectedPopulationIndicator;
  late String selectedPovertyIndicator = "";
  late List<bool> isSelectedPovertyIndicator;

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  // late List<MapModel> _data;

  @override
  void initState() {
    isSelectedAgricultureIndicator =
        List<bool>.filled(agricultureIndicators.length, false);
    isSelectedConflictIndicator =
        List<bool>.filled(conflictIndicators.length, false);
    isSelectedEconomicIndicator =
        List<bool>.filled(economicIndicators.length, false);
    isSelectedEducationIndicator =
        List<bool>.filled(educationIndicators.length, false);
    isSelectedEnvironmentIndicator =
        List<bool>.filled(environmentIndicators.length, false);
    isSelectedFoodSecurityAndNutritionIndicator =
        List<bool>.filled(foodSecurityAndNutritionIndicators.length, false);
    isSelectedGenderIndicator =
        List<bool>.filled(genderIndicators.length, false);
    isSelectedHealthIndicator =
        List<bool>.filled(healthIndicators.length, false);
    isSelectedInfrastructureIndicator =
        List<bool>.filled(infrastructureIndicators.length, false);
    isSelectedPopulationIndicator =
        List<bool>.filled(populationIndicators.length, false);
    isSelectedPovertyIndicator =
        List<bool>.filled(povertyIndicators.length, false);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    selectedGeographicCoverage = 'National';

    readClustersFromJsonFile();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContentsWS(_opacity),
      ),
      body: Container(
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF323232),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 32.0, right: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenSize.height / 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: screenSize.width * 0.65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          searchClusterWithSingleIndicatorsData
                                      .geographicalCoverage ==
                                  'National'
                              ? NationalCoverageMap(
                                  screenSize: screenSize,
                                  colour: selectedCluster == "Agriculture"
                                      ? agricultureColour
                                      : selectedCluster == "Conflict"
                                          ? conflictColour
                                          : selectedCluster == "Economic"
                                              ? economicColour
                                              : selectedCluster == "Education"
                                                  ? educationColour
                                                  : selectedCluster ==
                                                          "Environment"
                                                      ? environmentColour
                                                      : selectedCluster ==
                                                              "Food Security and Nutrition"
                                                          ? foodSecurityAndNutritionColour
                                                          : selectedCluster ==
                                                                  "Gender"
                                                              ? genderColour
                                                              : selectedCluster ==
                                                                      "Health"
                                                                  ? healthColour
                                                                  : selectedCluster ==
                                                                          "Infrastructure"
                                                                      ? infrastructureColour
                                                                      : selectedCluster ==
                                                                              "Population"
                                                                          ? populationColour
                                                                          : selectedCluster == "Poverty"
                                                                              ? povertyColour
                                                                              : DynamicTheme.of(context)?.brightness == Brightness.light
                                                                                  ? const Color(0xFFDFDFDF)
                                                                                  : const Color(0xFF323232),
                                )
                              : searchClusterWithSingleIndicatorsData
                                          .geographicalCoverage ==
                                      'Locality'
                                  ? LocalityCoverageMap(
                                      screenSize: screenSize,
                                      colour: selectedCluster == "Agriculture"
                                          ? agricultureColour
                                          : selectedCluster == "Conflict"
                                              ? conflictColour
                                              : selectedCluster == "Economic"
                                                  ? economicColour
                                                  : selectedCluster ==
                                                          "Education"
                                                      ? educationColour
                                                      : selectedCluster ==
                                                              "Environment"
                                                          ? environmentColour
                                                          : selectedCluster ==
                                                                  "Food Security and Nutrition"
                                                              ? foodSecurityAndNutritionColour
                                                              : selectedCluster ==
                                                                      "Gender"
                                                                  ? genderColour
                                                                  : selectedCluster ==
                                                                          "Health"
                                                                      ? healthColour
                                                                      : selectedCluster ==
                                                                              "Infrastructure"
                                                                          ? infrastructureColour
                                                                          : selectedCluster == "Population"
                                                                              ? populationColour
                                                                              : selectedCluster == "Poverty"
                                                                                  ? povertyColour
                                                                                  : DynamicTheme.of(context)?.brightness == Brightness.light
                                                                                      ? const Color(0xFFDFDFDF)
                                                                                      : const Color(0xFF323232),
                                    )
                                  : searchClusterWithSingleIndicatorsData
                                              .geographicalCoverage ==
                                          'State'
                                      ? StateCoverageMap(
                                          screenSize: screenSize,
                                          colour: selectedCluster ==
                                                  "Agriculture"
                                              ? agricultureColour
                                              : selectedCluster == "Conflict"
                                                  ? conflictColour
                                                  : selectedCluster ==
                                                          "Economic"
                                                      ? economicColour
                                                      : selectedCluster ==
                                                              "Education"
                                                          ? educationColour
                                                          : selectedCluster ==
                                                                  "Environment"
                                                              ? environmentColour
                                                              : selectedCluster ==
                                                                      "Food Security and Nutrition"
                                                                  ? foodSecurityAndNutritionColour
                                                                  : selectedCluster ==
                                                                          "Gender"
                                                                      ? genderColour
                                                                      : selectedCluster ==
                                                                              "Health"
                                                                          ? healthColour
                                                                          : selectedCluster == "Infrastructure"
                                                                              ? infrastructureColour
                                                                              : selectedCluster == "Population"
                                                                                  ? populationColour
                                                                                  : selectedCluster == "Poverty"
                                                                                      ? povertyColour
                                                                                      : DynamicTheme.of(context)?.brightness == Brightness.light
                                                                                          ? const Color(0xFFDFDFDF)
                                                                                          : const Color(0xFF323232),
                                        )
                                      : searchClusterWithSingleIndicatorsData
                                                  .geographicalCoverage ==
                                              'Sub national (hotspot map)'
                                          ? NationalCoverageMap(
                                              screenSize: screenSize)
                                          : Container(
                                              height: screenSize.height * 0.94,
                                              width: screenSize.width * 0.7,
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.grey.shade50
                                                    : Colors.white10,
                                              ),
                                            ),
                          SizedBox(height: screenSize.height / 40),
                          LineChart(screenSize: screenSize),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        buildGeographicalCoverageMenu(screenSize),
                        SizedBox(height: screenSize.height / 45),
                        buildClusterMenu(screenSize),
                        SizedBox(height: screenSize.height / 45),
                        DonutChart(screenSize: screenSize),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height / 20),
                const BottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

   buildGeographicalCoverageMenu(Size screenSize) {
    return Container(
      height: screenSize.height * 0.32,
      width: screenSize.width * 0.295,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.grey.shade50
            : Colors.white10,
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(
                top: screenSize.height / 75,
                bottom: screenSize.height / 75,
              ),
              //width: screenSize.width,
              // color: Colors.black,
              child: Text(
                'Geographical Coverage',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenSize.width / 55,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedGeographicCoverage = 'National';
                    });
                  },
                  child: Container(
                    height: screenSize.height / 10,
                    width: screenSize.width / 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: searchClusterWithSingleIndicatorsData
                                  .geographicalCoverage ==
                              'National'
                          ? DynamicTheme.of(context)?.brightness ==
                                  Brightness.light
                              ? const Color(0xFFDFDFDF)
                              : Colors.white10
                          : searchClusterWithSingleIndicatorsData
                                      .geographicalCoverage ==
                                  'Locality'
                              ? DynamicTheme.of(context)?.brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : const Color(0xFF323232)
                              : searchClusterWithSingleIndicatorsData
                                          .geographicalCoverage ==
                                      'State'
                                  ? DynamicTheme.of(context)?.brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : const Color(0xFF323232)
                                  : searchClusterWithSingleIndicatorsData
                                              .geographicalCoverage ==
                                          'Sub national (hotspot map)'
                                      ? DynamicTheme.of(context)?.brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : const Color(0xFF323232)
                                      : DynamicTheme.of(context)?.brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : const Color(0xFF323232),
                    ),
                    child: Center(
                      child: Text(
                        'National',
                        style: TextStyle(
                          fontSize: screenSize.width / 100,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width / 50),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedGeographicCoverage = 'State';
                    });
                  },
                  child: Container(
                    height: screenSize.height / 10,
                    width: screenSize.width / 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: searchClusterWithSingleIndicatorsData
                                  .geographicalCoverage ==
                              'National'
                          ? DynamicTheme.of(context)?.brightness ==
                                  Brightness.light
                              ? Colors.white
                              : const Color(0xFF323232)
                          : searchClusterWithSingleIndicatorsData
                                      .geographicalCoverage ==
                                  'Locality'
                              ? DynamicTheme.of(context)?.brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : const Color(0xFF323232)
                              : searchClusterWithSingleIndicatorsData
                                          .geographicalCoverage ==
                                      'State'
                                  ? DynamicTheme.of(context)?.brightness ==
                                          Brightness.light
                                      ? const Color(0xFFDFDFDF)
                                      : Colors.white10
                                  : searchClusterWithSingleIndicatorsData
                                              .geographicalCoverage ==
                                          'Sub national (hotspot map)'
                                      ? DynamicTheme.of(context)?.brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : const Color(0xFF323232)
                                      : DynamicTheme.of(context)?.brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : const Color(0xFF323232),
                    ),
                    child: Center(
                      child: Text(
                        'State',
                        style: TextStyle(
                          fontSize: screenSize.width / 100,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenSize.height / 60),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedGeographicCoverage = 'Locality';
                    });
                  },
                  child: Container(
                    height: screenSize.height / 10,
                    width: screenSize.width / 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: searchClusterWithSingleIndicatorsData
                                  .geographicalCoverage ==
                              'National'
                          ? DynamicTheme.of(context)?.brightness ==
                                  Brightness.light
                              ? Colors.white
                              : const Color(0xFF323232)
                          : searchClusterWithSingleIndicatorsData
                                      .geographicalCoverage ==
                                  'Locality'
                              ? DynamicTheme.of(context)?.brightness ==
                                      Brightness.light
                                  ? const Color(0xFFDFDFDF)
                                  : Colors.white10
                              : searchClusterWithSingleIndicatorsData
                                          .geographicalCoverage ==
                                      'State'
                                  ? DynamicTheme.of(context)?.brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : const Color(0xFF323232)
                                  : searchClusterWithSingleIndicatorsData
                                              .geographicalCoverage ==
                                          'Sub national (hotspot map)'
                                      ? DynamicTheme.of(context)?.brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : const Color(0xFF323232)
                                      : DynamicTheme.of(context)?.brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : const Color(0xFF323232),
                    ),
                    child: Center(
                      child: Text(
                        'Locality',
                        style: TextStyle(
                          fontSize: screenSize.width / 100,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width / 50),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedGeographicCoverage = 'Undefined';
                    });
                  },
                  child: Container(
                    height: screenSize.height / 10,
                    width: screenSize.width / 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: searchClusterWithSingleIndicatorsData
                                  .geographicalCoverage ==
                              'National'
                          ? DynamicTheme.of(context)?.brightness ==
                                  Brightness.light
                              ? Colors.white
                              : const Color(0xFF323232)
                          : searchClusterWithSingleIndicatorsData
                                      .geographicalCoverage ==
                                  'Locality'
                              ? DynamicTheme.of(context)?.brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : const Color(0xFF323232)
                              : searchClusterWithSingleIndicatorsData
                                          .geographicalCoverage ==
                                      'State'
                                  ? DynamicTheme.of(context)?.brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : const Color(0xFF323232)
                                  : searchClusterWithSingleIndicatorsData
                                              .geographicalCoverage ==
                                          'Sub national (hotspot map)'
                                      ? DynamicTheme.of(context)?.brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : const Color(0xFF323232)
                                      : DynamicTheme.of(context)?.brightness ==
                                              Brightness.light
                                          ? const Color(0xFFDFDFDF)
                                          : Colors.white10,
                    ),
                    child: Center(
                      child: Text(
                        'Undefined',
                        style: TextStyle(
                          fontSize: screenSize.width / 100,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   buildClusterMenu(Size screenSize) {
    return Container(
      height: screenSize.height * 0.8,
      width: screenSize.width * 0.295,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.grey.shade50
            : Colors.white10,
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(
                top: screenSize.height / 75,
                bottom: screenSize.height / 75,
              ),
              //width: screenSize.width,
              // color: Colors.black,
              child: Text(
                'Cluster',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenSize.width / 55,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Agriculture',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            //color: primaryColour,
                            size: 25,
                          ),
                          onPressed: () {
                            _asyncAgricultureIndicatorsDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width / 50),
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Conflict',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            //color: primaryColour,
                            size: 25,
                          ),
                          onPressed: () {
                            _asyncConflictIndicatorsDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize.height / 63),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Economic',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            //color: primaryColour,
                            size: 25,
                          ),
                          onPressed: () {
                            _asyncEconomicIndicatorsDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width / 50),
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Education',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            //color: primaryColour,
                            size: 25,
                          ),
                          onPressed: () {
                            _asyncEducationIndicatorsDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize.height / 63),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Environment',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            //color: primaryColour,
                            size: 25,
                          ),
                          onPressed: () {
                            _asyncEnvironmentIndicatorsDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width / 50),
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Food Security\nand Nutrition',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            //color: primaryColour,
                            size: 25,
                          ),
                          onPressed: () {
                            _asyncFoodSecurityAndNutritionIndicatorsDialog(
                                context);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize.height / 63),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            //color: primaryColour,
                            size: 25,
                          ),
                          onPressed: () {
                            _asyncGenderIndicatorsDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width / 50),
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Health',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            //color: primaryColour,
                            size: 25,
                          ),
                          onPressed: () {
                            _asyncHealthIndicatorsDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize.height / 63),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Infrastructure',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            //color: primaryColour,
                            size: 25,
                          ),
                          onPressed: () {
                            _asyncInfrastructureIndicatorsDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width / 50),
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Population',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              //color: primaryColour,
                              size: 25,
                            ),
                            onPressed: () {
                              _asyncPopulationIndicatorsDialog(context);
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize.height / 63),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Poverty',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            //color: primaryColour,
                            size: 25,
                          ),
                          onPressed: () {
                            _asyncPovertyIndicatorsDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width / 50),
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DynamicTheme.of(context)?.brightness ==
                        Brightness.light
                        ? Colors.white
                        : const Color(0xFF323232),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.025),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            'Undefined',
                            style: TextStyle(
                              fontSize: screenSize.width / 100,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getCloseButton(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: FractionalOffset.topRight,
          child: GestureDetector(
            child: Icon(Icons.clear, color: primaryColour),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  Future _asyncAgricultureIndicatorsDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Agriculture Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: agricultureIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedAgricultureIndicator[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Agriculture";
                                selectedAgricultureIndicator =
                                    agricultureIndicators[index];
                                //print(selectedIndicator);

                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);
                                isSelectedAgricultureIndicator[index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster ==
                                                "Agriculture" &&
                                            clusterInfo.indicators ==
                                                selectedAgricultureIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(agricultureIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedAgricultureIndicator = "";
                isSelectedAgricultureIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  Future _asyncConflictIndicatorsDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Conflict Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: conflictIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedConflictIndicator[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Conflict";
                                selectedConflictIndicator =
                                    conflictIndicators[index];
                                //print(selectedIndicator);
                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);

                                isSelectedConflictIndicator[index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster == "Conflict" &&
                                            clusterInfo.indicators ==
                                                selectedConflictIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(conflictIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedConflictIndicator = "";
                isSelectedConflictIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  Future _asyncEconomicIndicatorsDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Economic Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: economicIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedEconomicIndicator[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Economic";
                                selectedEconomicIndicator =
                                    economicIndicators[index];
                                //print(selectedIndicator);
                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);
                                isSelectedEconomicIndicator[index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster == "Economic" &&
                                            clusterInfo.indicators ==
                                                selectedEconomicIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(economicIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedEconomicIndicator = "";
                isSelectedEconomicIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  Future _asyncEducationIndicatorsDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Education Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: educationIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedEducationIndicator[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Education";
                                selectedEducationIndicator =
                                    educationIndicators[index];
                                //print(selectedIndicator);
                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);
                                isSelectedEducationIndicator[index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster ==
                                                "Education" &&
                                            clusterInfo.indicators ==
                                                selectedEducationIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(educationIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedEducationIndicator = "";
                isSelectedEducationIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  Future _asyncEnvironmentIndicatorsDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Environment Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: environmentIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedEnvironmentIndicator[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Environment";
                                selectedEnvironmentIndicator =
                                    environmentIndicators[index];
                                //print(selectedIndicator);
                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);
                                isSelectedEnvironmentIndicator[index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster ==
                                                "Environment" &&
                                            clusterInfo.indicators ==
                                                selectedEnvironmentIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(environmentIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedEnvironmentIndicator = "";
                isSelectedEnvironmentIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  Future _asyncFoodSecurityAndNutritionIndicatorsDialog(
      BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Food Security And Nutrition Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: foodSecurityAndNutritionIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedFoodSecurityAndNutritionIndicator[
                                  index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Food Security and Nutrition";
                                selectedFoodSecurityAndNutritionIndicator =
                                    foodSecurityAndNutritionIndicators[index];
                                //print(selectedIndicator);
                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator[
                                    index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster ==
                                                "Food Security and Nutrition" &&
                                            clusterInfo.indicators ==
                                                selectedFoodSecurityAndNutritionIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(foodSecurityAndNutritionIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedFoodSecurityAndNutritionIndicator = "";
                isSelectedFoodSecurityAndNutritionIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  Future _asyncGenderIndicatorsDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Gender Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: genderIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedGenderIndicator[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Gender";
                                selectedGenderIndicator =
                                    genderIndicators[index];
                                //print(selectedIndicator);
                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);
                                isSelectedGenderIndicator[index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster == "Gender" &&
                                            clusterInfo.indicators ==
                                                selectedGenderIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(genderIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedGenderIndicator = "";
                isSelectedGenderIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  Future _asyncHealthIndicatorsDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Health Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: healthIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedHealthIndicator[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Health";
                                selectedHealthIndicator =
                                    healthIndicators[index];
                                //print(selectedIndicator);
                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);
                                isSelectedHealthIndicator[index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster == "Health" &&
                                            clusterInfo.indicators ==
                                                selectedHealthIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(healthIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedHealthIndicator = "";
                isSelectedHealthIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  Future _asyncInfrastructureIndicatorsDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Infrastructure Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: infrastructureIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedInfrastructureIndicator[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Infrastructure";
                                selectedInfrastructureIndicator =
                                    infrastructureIndicators[index];
                                //print(selectedIndicator);
                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);
                                isSelectedInfrastructureIndicator[index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster ==
                                                "Infrastructure" &&
                                            clusterInfo.indicators ==
                                                selectedInfrastructureIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(infrastructureIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedInfrastructureIndicator = "";
                isSelectedInfrastructureIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  Future _asyncPopulationIndicatorsDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Population Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: populationIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedPopulationIndicator[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Population";
                                selectedPopulationIndicator =
                                    populationIndicators[index];
                                //print(selectedIndicator);
                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);
                                isSelectedPopulationIndicator[index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster ==
                                                "Population" &&
                                            clusterInfo.indicators ==
                                                selectedPopulationIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(populationIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedPopulationIndicator = "";
                isSelectedPopulationIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  Future _asyncPovertyIndicatorsDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Poverty Indicators'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: povertyIndicators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !isSelectedPovertyIndicator[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                selectedCluster = "Poverty";
                                selectedPovertyIndicator =
                                    povertyIndicators[index];
                                //print(selectedIndicator);
                                isSelectedAgricultureIndicator =
                                    List<bool>.filled(
                                        agricultureIndicators.length, false);
                                isSelectedConflictIndicator = List<bool>.filled(
                                    conflictIndicators.length, false);
                                isSelectedEconomicIndicator = List<bool>.filled(
                                    economicIndicators.length, false);
                                isSelectedEducationIndicator =
                                    List<bool>.filled(
                                        educationIndicators.length, false);
                                isSelectedEnvironmentIndicator =
                                    List<bool>.filled(
                                        environmentIndicators.length, false);
                                isSelectedFoodSecurityAndNutritionIndicator =
                                    List<bool>.filled(
                                        foodSecurityAndNutritionIndicators
                                            .length,
                                        false);
                                isSelectedGenderIndicator = List<bool>.filled(
                                    genderIndicators.length, false);
                                isSelectedHealthIndicator = List<bool>.filled(
                                    healthIndicators.length, false);
                                isSelectedInfrastructureIndicator =
                                    List<bool>.filled(
                                        infrastructureIndicators.length, false);
                                isSelectedPopulationIndicator =
                                    List<bool>.filled(
                                        populationIndicators.length, false);
                                isSelectedPovertyIndicator = List<bool>.filled(
                                    povertyIndicators.length, false);
                                isSelectedPovertyIndicator[index] = true;

                                /// FILTER THROUGH CLUSTER AND INDICATOR

                                // print("searchClusterData: ${searchClusterData}");
                                searchClusterWithAllIndicatorsData =
                                    readJsonFileContent
                                        .where((ClusterModel clusterInfo) =>
                                            clusterInfo.cluster == "Poverty" &&
                                            clusterInfo.indicators ==
                                                selectedPovertyIndicator)
                                        .toList();
                                // print("Population search result: ${searchClusterWithAllIndicatorsData}");
                                // print("geographicalCoverage: ${searchClusterWithAllIndicatorsData[1].geographicalCoverage}");

                                searchClusterWithSingleIndicatorsData =
                                    searchClusterWithAllIndicatorsData[0];
                              });
                            });
                          },
                        ),
                        title: Text(povertyIndicators[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                selectedPovertyIndicator = "";
                isSelectedPovertyIndicator =
                    List<bool>.filled(economicIndicators.length, false);
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }
}
