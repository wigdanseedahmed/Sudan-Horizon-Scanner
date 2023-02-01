import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class RulesOfLawAndConstitutionalBuildingScreen extends StatefulWidget {
  const RulesOfLawAndConstitutionalBuildingScreen({Key? key}) : super(key: key);

  @override
  _RulesOfLawAndConstitutionalBuildingScreenState createState() =>
      _RulesOfLawAndConstitutionalBuildingScreenState();
}

class _RulesOfLawAndConstitutionalBuildingScreenState
    extends State<RulesOfLawAndConstitutionalBuildingScreen>
    with TickerProviderStateMixin {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  late List<InterventionsProjectModel> readJsonFileContent =
      <InterventionsProjectModel>[];
  late List<InterventionsProjectModel> _allRCProjects =
      <InterventionsProjectModel>[];

  TextEditingController taskSearchBarTextEditingController =
      TextEditingController();

  late Future<List<InterventionsProjectModel>> futurePost;

  Future<List<InterventionsProjectModel>> readProjectFromJsonFile() async {
    /// Read Local Json File Directly
    /*String jsonString = await DefaultAssetBundle.of(context)
        .loadString('jsonDataFiles/interventions/project_data.json');*/
    //print(jsonString);

    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.projects);

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
            interventionsProjectModelFromJson(response.body); //(jsonString);
        //print("ALL  PROJECTS: $readJsonFileContent");

        _allRCProjects = readJsonFileContent
            .where((element) => element.theme!.contains("R_C"))
            .toList();
        //print("ALL RC PROJECTS: _allRCProjects");
        if (initialLocality == 'Locality' &&
            initialCity == 'City' &&
            initialState == 'State' &&
            initialRegion == 'Region' &&
            initialExecutingAgency == "Executing Agencies" &&
            initialStartDate == "Start year" &&
            initialEndDate == "End year" &&
            results.isEmpty) {
          searchData = _allRCProjects;
        } else {
          searchData = searchData;
        }
      });

      return searchData;
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

  ///VARIABLES USED FOR DROP DOWN MENU IN FILTER
  String initialLocality = 'Locality';
  String initialCity = 'City';
  String initialState = 'State';
  String initialProvince = 'Province';
  String initialRegion = 'Region';
  String initialExecutingAgency = "Executing Agencies";
  String initialStartDate = "Start year";
  String initialEndDate = "End year";

  ///VARIABLES USED FOR FILTER AND SEARCH BAR
  bool isSearchIconSelected = false;
  List<InterventionsProjectModel> searchData = <InterventionsProjectModel>[];
  List<InterventionsProjectModel> results = <InterventionsProjectModel>[];

  final TextEditingController searchBarController = TextEditingController();

  // This function is called whenever the text field changes
  void _runFilter({required String enteredKeyword}) {
    results.clear();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allRCProjects;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      _allRCProjects.forEach((data) {
        if (data.projectName
            .toString()
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase().toString())) {
          results.add(data);
          // If not empty then add search data into search data list
        }
      });
    }

    // Refresh the UI
    setState(() {
      searchData = results;
    });
  }

  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH MAP DATA FROM BACKEND
  late AnimationController _projectsLocationMapcontroller;
  late MapTileLayerController _projectsLocationMapTileLayerController;
  late Map<String, MapLatLng> _projectsLocationMapMarkers;

  //List _projectsLocationMapSelectedMarkerIndices = [];

  final int _projectsLocationMapSelectedMarkerIndex = -1;
  final int _projectsLocationMapPrevSelectedMarkerIndex = -1;

  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    isSearchIconSelected = false;

    /// USED FOR PROJECT LOCATION MAP
    _projectsLocationMapcontroller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 750),
        reverseDuration: const Duration(milliseconds: 750));
    _projectsLocationMapTileLayerController = MapTileLayerController();

    _projectsLocationMapcontroller.repeat(min: 0.1, max: 1.0, reverse: true);

    ///VARIABLES USED FORT MAP LOCATION
    _zoomPanBehavior = MapZoomPanBehavior(enablePanning: false, enablePinching: false,minZoomLevel: 5.0);
    super.initState();
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
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? PreferredSize(
              preferredSize: Size(screenSize.width, 50),
              child: SmallScreenAppBar(opacity: _opacity))
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContentsWS(_opacity),
            ),
      drawer: const SmallScreenMenuDrawer(),
      body: Container(
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF323232),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: screenSize.height * 0.65,
                child: Stack(
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.65,
                      width: screenSize.width,
                      child: Image.asset(
                        'assets/images/rule_of_law.jpg',
                        fit: BoxFit.cover,
                        //height: screenSize.height * 0.75,
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 18 / 8,
                      child: Center(
                        child: Text(
                          'RULE OF LAW AND\nCONSTITUTIONAL BUILDING',
                          style: TextStyle(
                            letterSpacing: 8,
                            fontFamily: 'Electrolize',
                            fontSize: screenSize.width / 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height / 25),
              Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width / 25, right: screenSize.width / 25),
                child: RichText(
                  text: const TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    //maxLines: 10,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      //fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "Regional organizations play an increasingly important role in strengthening and upholding the rule of law.",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              " Regional organizations are also increasingly seeking to strengthen constitutional governance in their member states by developing regulatory frameworks that reject and sanction unconstitutional transfers of power and attempts to remain in power unconstitutionally. This publication presents and discusses the initiatives and actions in the field of rule of law and constitution building by regional organizations. It also highlights their achievements, their limitations and the challenges they face, and puts forward policy recommendations for consideration."),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenSize.height / 50),
              FutureBuilder(
                future: readProjectFromJsonFile(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    return Column(
                      children: [
                        StatusProjectHeading(
                            text: "Project Locations", screenSize: screenSize),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: screenSize.height * 0.75,
                            width: screenSize.width * 0.75,
                            child: Center(
                              child: SfMaps(
                                layers: [
                                  MapTileLayer(
                                    urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    initialZoomLevel: 3,
                                    zoomPanBehavior: _zoomPanBehavior,
                                    initialFocalLatLng: const MapLatLng(15.508457, 32.522854),
                                    controller: _projectsLocationMapTileLayerController,
                                    initialMarkersCount:
                                    searchData.length,
                                    markerBuilder: (BuildContext context, int index) =>
                                        buildAllProjectsLocationMarkers(
                                          context: context,
                                          index: index,
                                          prevSelectedMarkerIndex:
                                          _projectsLocationMapPrevSelectedMarkerIndex,
                                          selectedMarkerIndex:
                                          _projectsLocationMapSelectedMarkerIndex,
                                          tileLayerController:
                                          _projectsLocationMapTileLayerController,
                                          latitude:
                                          searchData[index].longitude!,
                                          longitude:
                                          searchData[index].latitude!,

                                          selectedProject: searchData[index],
                                          interventionScreen: 'R_C',
                                        ),
                                    markerTooltipBuilder: (BuildContext context, int index) {
                                      return SizedBox(
                                        width: screenSize.width / 2.3,
                                        height: screenSize.height * 0.25,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: screenSize.width / 10,
                                              height: screenSize.height,
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.only(
                                                  bottomLeft: Radius.circular(4),
                                                  topLeft: Radius.circular(4),
                                                ),
                                                child: Image(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    searchData[index]
                                                        .photoUrl!,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: screenSize.width / 3,
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      searchData[index]
                                                          .projectName!,
                                                      style: TextStyle(
                                                          color: DynamicTheme.of(context)
                                                              ?.brightness ==
                                                              Brightness.light
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize:
                                                          screenSize.width / 75),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      searchData[index]
                                                          .executingAgency![0]
                                                          .executingAgencyName!,
                                                      style: TextStyle(
                                                          color: DynamicTheme.of(context)
                                                              ?.brightness ==
                                                              Brightness.light
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontSize:
                                                          screenSize.width / 85),
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: DynamicTheme.of(context)
                                                        ?.brightness ==
                                                        Brightness.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    height: 10,
                                                    thickness: 1.2,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .access_time_outlined,
                                                                    color: Colors.grey,
                                                                  ),
                                                                  SizedBox(
                                                                      width: screenSize
                                                                          .width /
                                                                          200),
                                                                  Text(
                                                                    "Started",
                                                                    textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                      //letterSpacing: 8,
                                                                      fontFamily:
                                                                      'Electrolize',
                                                                      fontSize: screenSize
                                                                          .width /
                                                                          100,
                                                                      color: Colors.grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .access_time_outlined,
                                                                    color: Colors.grey,
                                                                  ),
                                                                  SizedBox(
                                                                      width: screenSize
                                                                          .width /
                                                                          200),
                                                                  Text(
                                                                    "Ended",
                                                                    textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                      //letterSpacing: 8,
                                                                      fontFamily:
                                                                      'Electrolize',
                                                                      fontSize: screenSize
                                                                          .width /
                                                                          100,
                                                                      color: Colors.grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              child: Text(
                                                                DateFormat("EEE, MMM d, yyyy")
                                                                    .format(
                                                                    searchData[
                                                                    index]
                                                                        .startDate!),
                                                                //DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(widget.projectInformation.startDate)),
                                                                textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                  //letterSpacing: 8,
                                                                  fontFamily: 'Electrolize',
                                                                  color: DynamicTheme.of(
                                                                      context)
                                                                      ?.brightness ==
                                                                      Brightness.light
                                                                      ? Colors.black
                                                                      : Colors.white,
                                                                  fontSize: screenSize.width /
                                                                      100,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              child: Text(
                                                                DateFormat("EEE, MMM d, yyyy")
                                                                    .format(
                                                                    searchData[
                                                                    index]
                                                                        .endDate!),
                                                                textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                  //letterSpacing: 8,
                                                                  fontFamily: 'Electrolize',
                                                                  color: DynamicTheme.of(
                                                                      context)
                                                                      ?.brightness ==
                                                                      Brightness.light
                                                                      ? Colors.black
                                                                      : Colors.white,
                                                                  fontSize: screenSize.width /
                                                                      100,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    tooltipSettings: MapTooltipSettings(
                                      color: DynamicTheme.of(context)?.brightness ==
                                          Brightness.light
                                          ? Colors.white
                                          : const Color(0xFF323232),
                                      strokeWidth: 0.5,
                                      strokeColor: DynamicTheme.of(context)?.brightness ==
                                          Brightness.light
                                          ? const Color(0xFF323232)
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height / 10),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.25,
                                child: isSearchIconSelected == true
                                    ? Container(
                                        width: screenSize.width * 0.25,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: TextField(
                                            controller: searchBarController,
                                            onChanged: (value) => _runFilter(
                                                enteredKeyword: value),
                                            decoration: InputDecoration(
                                              prefixIcon: const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: Icon(
                                                  Icons.search,
                                                  //color: primaryColour,
                                                ),
                                              ),
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                  Icons.clear,
                                                  //color: primaryColour,
                                                ),
                                                onPressed: () {
                                                  /* Clear the search field */
                                                  searchBarController.clear();
                                                  results.clear();
                                                  isSearchIconSelected = false;
                                                },
                                              ),
                                              hintText:
                                                  'Search Project Name...',
                                              //hintStyle: TextStyle(color: primaryColour),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      )
                                    : IconButton(
                                        alignment: Alignment.centerLeft,
                                        icon: const Icon(
                                          Icons.search_rounded,
                                          //color: primaryColour,
                                          size: 40,
                                        ),
                                        onPressed: () {
                                          isSearchIconSelected = true;
                                        },
                                      ),
                              ),
                              SizedBox(width: screenSize.width / 7),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: StatusProjectHeading(
                                    text: "Current Project",
                                    screenSize: screenSize),
                              ),
                              SizedBox(width: screenSize.width / 3.25),
                              IconButton(
                                icon: const Icon(
                                  Icons.filter_alt,
                                  //color: primaryColour,
                                  size: 40,
                                ),
                                onPressed: () {
                                  _asyncFilterDialog(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        BuildInterventionsProjectList(
                          allProjects: searchData,
                          theme: "R_C",
                          status: "current",
                          screenSize: screenSize,
                        ),
                        SizedBox(height: screenSize.height / 10),
                        StatusProjectHeading(
                            text: "Past Project", screenSize: screenSize),
                        BuildInterventionsProjectList(
                          allProjects: searchData,
                          theme: "R_C",
                          status: "past",
                          screenSize: screenSize,
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              SizedBox(height: screenSize.height / 10),
              const BottomBar(),
            ],
          ),
        ),
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

  Future _asyncFilterDialog(BuildContext context) async {
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
              const Text('Filter'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Localities",
                      style: TextStyle(
                        fontSize: screenSize.width / 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter dropDownState) {
                              return DropdownSearch<String>(
                                //mode of dropdown
                                mode: Mode.MENU,
                                //to show search box
                                showSearchBox: true,
                                //list of dropdown items
                                items: localitiesList,
                                onChanged: (String? newValue) {
                                  dropDownState(() {
                                    initialLocality = newValue!;
                                    if (initialLocality == "Locality") {
                                      setState(() {
                                        // no search field input, display all items
                                        searchData = _allRCProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allRCProjects
                                            .where((InterventionsProjectModel
                                                    project) =>
                                                project.localityNameEn
                                                    .toString()
                                                    .toLowerCase() ==
                                                newValue
                                                    .toString()
                                                    .toLowerCase())
                                            .toList();
                                      });
                                    }
                                  });
                                },
                                //show selected item
                                selectedItem: initialLocality,
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cities",
                      style: TextStyle(
                        fontSize: screenSize.width / 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter dropDownState) {
                              return DropdownSearch<String>(
                                //mode of dropdown
                                mode: Mode.MENU,
                                //to show search box
                                showSearchBox: true,
                                //list of dropdown items
                                items: cityList,
                                onChanged: (String? newValue) {
                                  dropDownState(() {
                                    initialCity = newValue!;

                                    if (initialCity == "City") {
                                      setState(() {
                                        // no search field input, display all items
                                        searchData = _allRCProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allRCProjects
                                            .where((InterventionsProjectModel
                                                    project) =>
                                                project.cityNameEn
                                                    .toString()
                                                    .toLowerCase() ==
                                                newValue
                                                    .toString()
                                                    .toLowerCase())
                                            .toList();
                                      });
                                    }
                                  });
                                },
                                //show selected item
                                selectedItem: initialCity,
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "States",
                      style: TextStyle(
                        fontSize: screenSize.width / 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter dropDownState) {
                              return DropdownSearch<String>(
                                //mode of dropdown
                                mode: Mode.MENU,
                                //to show search box
                                showSearchBox: true,
                                //list of dropdown items
                                items: stateList,
                                onChanged: (String? newValue) {
                                  dropDownState(() {
                                    initialState = newValue!;
                                    if (initialState == "State") {
                                      setState(() {
                                        // no search field input, display all items
                                        searchData = _allRCProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allRCProjects
                                            .where((InterventionsProjectModel
                                                    project) =>
                                                project.stateNameEn
                                                    .toString()
                                                    .toLowerCase() ==
                                                newValue
                                                    .toString()
                                                    .toLowerCase())
                                            .toList();
                                      });
                                    }
                                  });
                                },
                                //show selected item
                                selectedItem: initialState,
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Provinces",
                      style: TextStyle(
                        fontSize: screenSize.width / 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter dropDownState) {
                              return DropdownSearch<String>(
                                //mode of dropdown
                                mode: Mode.MENU,
                                //to show search box
                                showSearchBox: true,
                                //list of dropdown items
                                items: provincesList,
                                onChanged: (String? newValue) {
                                  dropDownState(() {
                                    initialProvince = newValue!;
                                    if (initialProvince == "Province") {
                                      setState(() {
                                        // no search field input, display all items
                                        searchData = _allRCProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allRCProjects
                                            .where((InterventionsProjectModel
                                                    project) =>
                                                project.provinceNameEn
                                                    .toString()
                                                    .toLowerCase() ==
                                                newValue
                                                    .toString()
                                                    .toLowerCase())
                                            .toList();
                                      });
                                    }
                                  });
                                },
                                //show selected item
                                selectedItem: initialProvince,
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Regions",
                      style: TextStyle(
                        fontSize: screenSize.width / 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter dropDownState) {
                              return DropdownSearch<String>(
                                //mode of dropdown
                                mode: Mode.MENU,
                                //to show search box
                                showSearchBox: true,
                                //list of dropdown items
                                items: regionsList,
                                onChanged: (String? newValue) {
                                  dropDownState(() {
                                    initialRegion = newValue!;
                                    if (initialRegion == "Region") {
                                      setState(() {
                                        // no search field input, display all items
                                        searchData = _allRCProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allRCProjects
                                            .where((InterventionsProjectModel
                                                    project) =>
                                                project.regionNameEn
                                                    .toString()
                                                    .toLowerCase() ==
                                                newValue
                                                    .toString()
                                                    .toLowerCase())
                                            .toList();
                                      });
                                    }
                                  });
                                },
                                //show selected item
                                selectedItem: initialRegion,
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Executing Agencies",
                      style: TextStyle(
                        fontSize: screenSize.width / 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter dropDownState) {
                              return DropdownSearch<String>(
                                //mode of dropdown
                                mode: Mode.MENU,
                                //to show search box
                                showSearchBox: true,
                                //list of dropdown items
                                items: executingAgencyList,
                                onChanged: (String? newValue) {
                                  dropDownState(() {
                                    initialExecutingAgency = newValue!;
                                    if (initialExecutingAgency ==
                                        "Executing Agencies") {
                                      setState(() {
                                        // no search field input, display all items
                                        searchData = _allRCProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allRCProjects
                                            .where((InterventionsProjectModel
                                                    project) =>
                                                project.executingAgency!.any(
                                                    (InterventionsExecutingAgencyModel
                                                            executingAgency) =>
                                                        executingAgency
                                                            .executingAgencyName
                                                            .toString()
                                                            .toLowerCase() ==
                                                        newValue
                                                            .toString()
                                                            .toLowerCase()))
                                            .toList();
                                      });
                                    }
                                  });
                                },
                                //show selected item
                                selectedItem: initialExecutingAgency,
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Start year",
                      style: TextStyle(
                        fontSize: screenSize.width / 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenSize.width / 8),
                    Text(
                      "End year",
                      style: TextStyle(
                        fontSize: screenSize.width / 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.1,
                      alignment: Alignment.centerLeft,
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter dropDownState) {
                        return DropdownSearch<String>(
                          //mode of dropdown
                          mode: Mode.MENU,
                          //to show search box
                          showSearchBox: true,
                          //list of dropdown items
                          items: startDateYearList,
                          onChanged: (String? newValue) {
                            dropDownState(() {
                              initialStartDate = newValue!;
                              if (initialStartDate == "Start year") {
                                setState(() {
                                  // no search field input, display all items
                                  searchData = _allRCProjects;
                                });
                              } else {
                                setState(() {
                                  searchData = _allRCProjects
                                      .where(
                                          (InterventionsProjectModel project) =>
                                              project.startDate!.year
                                                  .toString()
                                                  .toLowerCase() ==
                                              newValue.toString().toLowerCase())
                                      .toList();
                                });
                              }
                            });
                          },
                          //show selected item
                          selectedItem: initialStartDate,
                        );
                      }),
                    ),
                    SizedBox(width: screenSize.width / 12),
                    Container(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.1,
                      alignment: Alignment.centerLeft,
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter dropDownState) {
                        return DropdownSearch<String>(
                          //mode of dropdown
                          mode: Mode.MENU,
                          //to show search box
                          showSearchBox: true,
                          //list of dropdown items
                          items: endDateYearList,
                          onChanged: (String? newValue) {
                            dropDownState(() {
                              initialEndDate = newValue!;
                              if (initialEndDate == "End year") {
                                setState(() {
                                  // no search field input, display all items
                                  searchData = _allRCProjects;
                                });
                              } else {
                                setState(() {
                                  searchData = _allRCProjects
                                      .where(
                                          (InterventionsProjectModel project) =>
                                              project.endDate!.year
                                                  .toString()
                                                  .toLowerCase() ==
                                              newValue.toString().toLowerCase())
                                      .toList();
                                });
                              }
                            });
                          },
                          //show selected item
                          selectedItem: initialEndDate,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                initialLocality = 'Locality';
                initialCity = 'City';
                initialState = 'State';
                initialProvince = 'Province';
                initialRegion = 'Region';
                initialExecutingAgency = "Executing Agencies";
                initialStartDate = "Start year";
                initialEndDate = "End year";
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
