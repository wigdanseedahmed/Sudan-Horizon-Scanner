import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class HealthAndDevelopmentScreen extends StatefulWidget {
  const HealthAndDevelopmentScreen({Key? key}) : super(key: key);

  @override
  _HealthAndDevelopmentScreenState createState() =>
      _HealthAndDevelopmentScreenState();
}

class _HealthAndDevelopmentScreenState extends State<HealthAndDevelopmentScreen>
    with TickerProviderStateMixin {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  late List<InterventionsProjectModel> readJsonFileContent =
      <InterventionsProjectModel>[];
  late List<InterventionsProjectModel> _allHDProjects =
      <InterventionsProjectModel>[];

  TextEditingController taskSearchBarTextEditingController =
      TextEditingController();

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

        _allHDProjects = readJsonFileContent
            .where((element) => element.theme!.contains("D_E"))
            .toList();
        //print("ALL DE PROJECTS: $_allDEProjects");
        if (initialLocality == 'Locality' &&
            initialCity == 'City' &&
            initialState == 'State' &&
            initialRegion == 'Region' &&
            initialExecutingAgency == "Executing Agencies" &&
            initialStartDate == "Start year" &&
            initialEndDate == "End year" &&
            results.isEmpty) {
          searchData = _allHDProjects;
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
      results = _allHDProjects;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      _allHDProjects.forEach((data) {
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
    _zoomPanBehavior = MapZoomPanBehavior(
        enablePanning: false, enablePinching: false, minZoomLevel: 5.0);
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


    return FutureBuilder(
      future: readProjectFromJsonFile(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: buildAppBar(screenSize),
            body: buildBody(context, screenSize),
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

  buildBody(BuildContext context, Size screenSize) {
    return Container(
      color: DynamicTheme.of(context)?.brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF323232),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            buildTopScreen(screenSize),
            SizedBox(height: screenSize.height * 0.01),
            buildOverview(screenSize),
            SizedBox(height: screenSize.height / 10),
            buildApproach(screenSize),
            SizedBox(height: screenSize.height / 10),
            buildProjectLocation(screenSize),
            SizedBox(height: screenSize.height / 10),
            buildCurrentAndPastProjects(screenSize),
            SizedBox(height: screenSize.height / 10),
            const BottomBar(),
          ],
        ),
      ),
    );
  }

  buildTopScreen(Size screenSize) {
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height * 0.98,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: screenSize.width * 0.5,
            child: Container(
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.98,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/health_and_development.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.451,
            left: screenSize.width * 0.44,
            child: RotatedBox(
              quarterTurns: 2,
              child: CustomPaint(
                size: const Size(160, 160),
                painter: DrawHDWhiteTriangle(),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.98,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(247, 247, 247, 1),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.1,
            left: screenSize.width * 0.1,
            child: Container(
              width: screenSize.width * 0.075,
              height: screenSize.height * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/UNDP_logo.png'),
                    fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.15,
            left: screenSize.width * 0.24,
            child: Container(
              width: screenSize.width * 0.18,
              height: screenSize.height * 0.15,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/portfolio_logo.png'),
                    fit: BoxFit.fitWidth),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.5,
            left: screenSize.width * 0.1,
            child: Text(
              'HEALTH AND\nDEVELOPMENT',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: const Color(0xFF4C9F38),
                fontFamily: 'Arial Rounded MT Bold',
                fontSize: screenSize.width * 0.04,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.81,
            left: 0,
            child: RotatedBox(
              quarterTurns: 1,
              child: CustomPaint(
                size: const Size(120, 120),
                painter: DrawHDColouredTriangle(),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.86,
            left: screenSize.width * 0.001,
            child: Container(
              width: screenSize.width * 0.046,
              height: screenSize.height * 0.06,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/health_and_development_logo.png',
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildOverview(Size screenSize) {
    return Column(
      children: [
        SizedBox(height: screenSize.height * 0.05),
        Container(
          height: screenSize.height * 0.08,
          width: screenSize.width * 0.98,
          color: const Color(0xFF4C9F38),
          padding: EdgeInsets.only(
            top: screenSize.height * 0.005,
            bottom: screenSize.height * 0.005,
          ),
          //width: screenSize.width,
          // color: Colors.black,
          child: Center(
            child: Text(
              "THE CONTEXT",
              style: TextStyle(
                  fontSize:
                  screenSize.width * 0.02,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Colors.white
              ),
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.03),
        Padding(
          padding: EdgeInsets.only(
              left: screenSize.width / 25, right: screenSize.width / 25),
          child: const Text(
            healthAndDevelopmentTheContext,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  buildApproach(Size screenSize) {
    return Column(
      children: [
        SizedBox(height: screenSize.height * 0.05),
        Container(
          height: screenSize.height * 0.08,
          width: screenSize.width * 0.98,
          color: const Color(0xFF4C9F38),
          padding: EdgeInsets.only(
            top: screenSize.height * 0.005,
            bottom: screenSize.height * 0.005,
          ),
          //width: screenSize.width,
          // color: Colors.black,
          child: Center(
            child: Text(
              "OUR APPROACH",
              style: TextStyle(
                  fontSize:
                  screenSize.width * 0.02,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Colors.white
              ),
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.03),
        Padding(
          padding: EdgeInsets.only(
              left: screenSize.width / 25, right: screenSize.width / 25),
          child: const Text(
            healthAndDevelopmentOurApproach,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  buildProjectLocation(Size screenSize) {
    return Column(
      children: [
        Container(
          height: screenSize.height * 0.08,
          width: screenSize.width * 0.98,
          color: const Color(0xFF4C9F38),
          padding: EdgeInsets.only(
            top: screenSize.height * 0.005,
            bottom: screenSize.height * 0.005,
          ),
          //width: screenSize.width,
          // color: Colors.black,
          child: Center(
            child: Text(
              "PROJECT LOCATIONS",
              style: TextStyle(
                  fontSize:
                  screenSize.width * 0.02,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Colors.white
              ),
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.03),
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
                    initialMarkersCount: searchData.length,
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
                          latitude: searchData[index].longitude!,
                          longitude: searchData[index].latitude!,
                          selectedProject: searchData[index],
                          interventionScreen: 'H_D',
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
                                    searchData[index].photoUrl!,
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
                                      searchData[index].projectName!,
                                      style: TextStyle(
                                          color: DynamicTheme.of(context)
                                              ?.brightness ==
                                              Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width / 75),
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
                                          fontSize: screenSize.width / 85),
                                    ),
                                  ),
                                  Divider(
                                    color:
                                    DynamicTheme.of(context)?.brightness ==
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
                                                    Icons.access_time_outlined,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                      width: screenSize.width /
                                                          200),
                                                  Text(
                                                    "Started",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      //letterSpacing: 8,
                                                      fontFamily: 'Electrolize',
                                                      fontSize:
                                                      screenSize.width /
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
                                                    Icons.access_time_outlined,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                      width: screenSize.width /
                                                          200),
                                                  Text(
                                                    "Ended",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      //letterSpacing: 8,
                                                      fontFamily: 'Electrolize',
                                                      fontSize:
                                                      screenSize.width /
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
                                                    .format(searchData[index]
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
                                                  fontSize:
                                                  screenSize.width / 100,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                DateFormat("EEE, MMM d, yyyy")
                                                    .format(searchData[index]
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
                                                  fontSize:
                                                  screenSize.width / 100,
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
      ],
    );
  }

  buildCurrentAndPastProjects(Size screenSize) {
    return Column(
      children: [
        Container(
          height: screenSize.height * 0.08,
          width: screenSize.width * 0.98,
          color: const Color(0xFF4C9F38),
          padding: EdgeInsets.only(
              top: screenSize.height * 0.005,
              bottom: screenSize.height * 0.005,
              left: 16.0,
              right: 8.0
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: screenSize.width * 0.2,
                child: isSearchIconSelected == true
                    ? Container(
                  width: screenSize.width * 0.25,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: searchBarController,
                      onChanged: (value) =>
                          _runFilter(enteredKeyword: value),
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
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
                        hintText: 'Search Project Name...',
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
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    isSearchIconSelected = true;
                  },
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.64,
                child: Center(
                  child: Text(
                    "CURRENT PROJECTS",
                    style: TextStyle(
                        fontSize:
                        screenSize.width * 0.02,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.filter_alt,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        _asyncFilterDialog(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenSize.height * 0.03),
        BuildInterventionsProjectList(
          allProjects: searchData,
          theme: "H_D",
          status: "current",
          screenSize: screenSize,
        ),
        SizedBox(height: screenSize.height / 10),

        Container(
          height: screenSize.height * 0.08,
          width: screenSize.width * 0.98,
          color: const Color(0xFF4C9F38),
          padding: EdgeInsets.only(
            top: screenSize.height * 0.005,
            bottom: screenSize.height * 0.005,
          ),
          //width: screenSize.width,
          // color: Colors.black,
          child: Center(
            child: Text(
              "PAST PROJECTS",
              style: TextStyle(
                  fontSize:
                  screenSize.width * 0.02,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Colors.white
              ),
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.03),
        BuildInterventionsProjectList(
          allProjects: searchData,
          theme: "H_D",
          status: "past",
          screenSize: screenSize,
        ),
      ],
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
                                        searchData = _allHDProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allHDProjects
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
                                        searchData = _allHDProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allHDProjects
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
                                        searchData = _allHDProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allHDProjects
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
                                        searchData = _allHDProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allHDProjects
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
                                        searchData = _allHDProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allHDProjects
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
                                        searchData = _allHDProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allHDProjects
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
                                  searchData = _allHDProjects;
                                });
                              } else {
                                setState(() {
                                  searchData = _allHDProjects
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
                                  searchData = _allHDProjects;
                                });
                              } else {
                                setState(() {
                                  searchData = _allHDProjects
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

class DrawHDColouredTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF4C9F38));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawHDWhiteTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height /2);
    path.lineTo(size.height / 2, size.width);
    path.close();
    canvas.drawPath(path, Paint()..color = const Color.fromRGBO(247, 247, 247, 1));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
