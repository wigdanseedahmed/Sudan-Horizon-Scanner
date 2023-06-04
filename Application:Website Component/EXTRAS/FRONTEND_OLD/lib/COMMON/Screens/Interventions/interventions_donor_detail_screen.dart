import 'package:sudan_horizon_scanner/imports.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:http/http.dart' as http;

class LargeScreenInterventionsDonorDetailScreen extends StatefulWidget {
  const LargeScreenInterventionsDonorDetailScreen(
      {Key? key, required this.selectedDonor, required this.interventionScreen})
      : super(key: key);

  final InterventionsDonorModel selectedDonor;
  final String interventionScreen;

  @override
  _LargeScreenInterventionsDonorDetailScreenState createState() =>
      _LargeScreenInterventionsDonorDetailScreenState();
}

class _LargeScreenInterventionsDonorDetailScreenState
    extends State<LargeScreenInterventionsDonorDetailScreen>
    with TickerProviderStateMixin {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND

  late String? typeOfIntervention = "";

  late List<InterventionsProjectModel> readJsonFileContent =
      <InterventionsProjectModel>[];
  late List<InterventionsProjectModel> _allDonorInvolvedProjects =
      <InterventionsProjectModel>[];

  TextEditingController taskSearchBarTextEditingController =
      TextEditingController();

  Future<List<InterventionsProjectModel>>
      readDonorInvolvedProjectsFromJsonFile() async {
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

        for (var i = 0; i < readJsonFileContent.length; i++) {
          _allDonorInvolvedProjects = readJsonFileContent
              .where((element) => element.donor!.any((element) =>
                  element.donorName! == widget.selectedDonor.donorName))
              .toList();
        }
        //print("ALL PROJECTS THAT THE DONOR IS INVOLVED IN: $_allDonorInvolvedProjects");

        if (initialLocality == 'Locality' &&
            initialCity == 'City' &&
            initialState == 'State' &&
            initialRegion == 'Region' &&
            initialExecutingAgency == "Executing Agencies" &&
            initialStartDate == "Start year" &&
            initialEndDate == "End year" &&
            results.isEmpty) {
          searchData = _allDonorInvolvedProjects;
        } else {
          searchData = searchData;
        }
      });

      return searchData;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  ///VARIABLES USED TO CREATE CHARTS FOR DONATION AMOUNT
  late TooltipBehavior _tooltip;

  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH PROJECT MAP LOCATION FROM BACKEND
  late AnimationController _controller;
  late CurvedAnimation _animation;
  late MapZoomPanBehavior _zoomPanBehavior;

  int _selectedMarkerIndex = 1;

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
  String initialInterventionType = "All";

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
      results = _allDonorInvolvedProjects;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      _allDonorInvolvedProjects.forEach((data) {
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

  @override
  void initState() {
    ///VARIABLES USED TO SCROLL THROUGH SCREEN
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    ///VARIABLES USED TO CREATE CHARTS FOR DONATION AMOUNT
    _tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');

    ///VARIABLES USED FORT MAP LOCATION
    _zoomPanBehavior = MapZoomPanBehavior(
        enablePanning: false, enablePinching: false, minZoomLevel: 6.0);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.repeat(min: 0.15, max: 1.0, reverse: true);

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
      body: SafeArea(
        child: Container(
          color: DynamicTheme.of(context)?.brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF323232),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.075,
                  right: screenSize.width * 0.075),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenSize.width * 0.075,
                        right: screenSize.width * 0.075),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.5,
                          child: Column(
                            children: [
                              SizedBox(
                                width: screenSize.width,
                                child: Text(
                                  widget.selectedDonor.donorName!,
                                  style: TextStyle(
                                    fontSize: screenSize.width / 60,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenSize.height / 100),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: screenSize.width * 0.1,
                                  child: Divider(
                                    thickness: screenSize.height / 400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.mail_outline_sharp,
                                      color: Colors.grey,
                                      size: screenSize.width / 85,
                                    ),
                                    SizedBox(width: screenSize.width / 250),
                                    Text(
                                      widget.selectedDonor.donorEmail!,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        //letterSpacing: 8,
                                        fontFamily: 'Electrolize',
                                        fontSize: screenSize.width / 100,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenSize.height / 100),
                              SizedBox(
                                width: screenSize.width,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.web_sharp,
                                      color: Colors.grey,
                                      size: screenSize.width / 85,
                                    ),
                                    SizedBox(width: screenSize.width / 250),
                                    Text(
                                      widget.selectedDonor.donorWebsite!,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        //letterSpacing: 8,
                                        fontFamily: 'Electrolize',
                                        fontSize: screenSize.width / 100,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenSize.height / 25),
                            ],
                          ),
                        ),
                        Container(
                          height: screenSize.height * 0.2,
                          width: screenSize.width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: NetworkImage(
                                  widget.selectedDonor.donorPhotoUrl!),
                              fit: BoxFit.fill,
                            ),
                            /*Image.asset(
                                  'assets/images/rule_of_law.jpg',
                                  fit: BoxFit.fitWidth,
                                ),*/
                            //NetworkImage(searchData[index].photoURL!),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenSize.width * 0.044),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          alignment: Alignment.centerRight,
                          icon: const Icon(
                            Icons.filter_alt,
                            //color: primaryColour,
                            size: 40,
                          ),
                          onPressed: () {
                            _asyncFilterDialog(context);
                          },
                        ),
                        SizedBox(
                          width: screenSize.width * 0.25,
                          child: isSearchIconSelected == true
                              ? Align(
                            alignment: Alignment.bottomRight,
                                child: Container(
                                    width: screenSize.width * 0.35,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: TextField(
                                        controller: searchBarController,
                                        onChanged: (value) =>
                                            _runFilter(enteredKeyword: value),
                                        decoration: InputDecoration(
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.only(top: 8.0),
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
                                          hintText: 'Search Project Name...',
                                          //hintStyle: TextStyle(color: primaryColour),
                                          border: InputBorder.none,
                                        ),
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
                      ],
                    ),
                  ),
                  SizedBox(height: screenSize.height / 25),
                  FutureBuilder(
                    future: readDonorInvolvedProjectsFromJsonFile(),
                    builder: (context, data) {
                      if (data.hasError) {
                        return Center(child: Text("${data.error}"));
                      } else if (!data.hasData) {
                        //data.connectionState == ConnectionState.waiting
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                            itemCount: searchData.length,
                            padding: const EdgeInsets.all(0.0),
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              int? donatedAmount;
                              for (var i = 0;
                                  i < searchData[index].donor!.length;
                                  i++) {
                                if (searchData[index].donor![i].donorName ==
                                    widget.selectedDonor.donorName) {
                                  donatedAmount = searchData[index]
                                      .donor![i]
                                      .donationAmount;
                                }
                              }
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InterventionsProjectDetailScreenWS(
                                            projectInformation:
                                                searchData[index],
                                                interventionScreen: widget.interventionScreen,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: screenSize.height * 0.7,
                                      width: screenSize.width * 0.75,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Colors.grey.shade50,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            searchData[index].projectName!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: screenSize.width / 60,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                              height: screenSize.height / 55),
                                          ListView.builder(
                                            itemCount: searchData[index]
                                                .executingAgency!
                                                .length,
                                            padding: const EdgeInsets.all(0.0),
                                            shrinkWrap: true,
                                            //physics: const ClampingScrollPhysics(),
                                            //scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context,
                                                int executingAgencyIndex) {
                                              return Center(
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      //color: Theme.of(context).primaryColor,
                                                      fontSize:
                                                          screenSize.width / 70,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: searchData[index]
                                                            .executingAgency![
                                                                executingAgencyIndex]
                                                            .executingAgencyName!,
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenSize.width /
                                                                  75,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            width: screenSize.width / 4,
                                            child: Divider(
                                              thickness:
                                                  screenSize.height / 400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 100.0, right: 100.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          screenSize.height /
                                                              25,
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
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              //letterSpacing: 8,
                                                              fontFamily:
                                                                  'Electrolize',
                                                              fontSize: screenSize
                                                                      .width /
                                                                  70,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          screenSize.height /
                                                              25,
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
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              //letterSpacing: 8,
                                                              fontFamily:
                                                                  'Electrolize',
                                                              fontSize: screenSize
                                                                      .width /
                                                                  70,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenSize.height / 75),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          screenSize.height /
                                                              25,
                                                      child: Text(
                                                        DateFormat(
                                                                "EEE, MMM d, yyyy")
                                                            .format(searchData[
                                                                    index]
                                                                .startDate!),
                                                        //DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(searchData[index].startDate)),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          //letterSpacing: 8,
                                                          fontFamily:
                                                              'Electrolize',
                                                          fontSize:
                                                              screenSize.width /
                                                                  90,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          screenSize.height /
                                                              25,
                                                      child: Text(
                                                        DateFormat(
                                                                "EEE, MMM d, yyyy")
                                                            .format(searchData[
                                                                    index]
                                                                .endDate!),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          //letterSpacing: 8,
                                                          fontFamily:
                                                              'Electrolize',
                                                          fontSize:
                                                              screenSize.width /
                                                                  90,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              height: screenSize.height / 55),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 100.0, right: 100.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Types of Interventions:",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  //letterSpacing: 8,
                                                  fontFamily: 'Electrolize',
                                                  fontSize:
                                                      screenSize.width / 70,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: screenSize.height / 75),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: SizedBox(
                                              width: screenSize.width,
                                              child: Tags(
                                                spacing: 16,
                                                alignment: WrapAlignment.center,
                                                itemCount: searchData[index]
                                                    .theme!
                                                    .length,
                                                itemBuilder: (int index) {
                                                  return Tooltip(
                                                    message: searchData[index]
                                                                    .theme![
                                                                index] ==
                                                            "R_C"
                                                        ? "Rule of Law and\nConstitutional Building"
                                                        : searchData[index]
                                                                        .theme![
                                                                    index] ==
                                                                "D_E"
                                                            ? "Democratic Transition\nand Economic Recovery"
                                                            : searchData[index]
                                                                            .theme![
                                                                        index] ==
                                                                    "E_E"
                                                                ? "Energy\nand Environment"
                                                                : searchData[index].theme![
                                                                            index] ==
                                                                        "H_D"
                                                                    ? "Health\nand Development"
                                                                    : searchData[index].theme![index] ==
                                                                            "P_S"
                                                                        ? "Peace\nand Stabilization"
                                                                        : "Innovation\nand Digitization",
                                                    child: ItemTags(
                                                      active: false,
                                                      title: searchData[index]
                                                                      .theme![
                                                                  index] ==
                                                              "R_C"
                                                          ? "Rule of Law and\nConstitutional Building"
                                                          : searchData[index]
                                                                          .theme![
                                                                      index] ==
                                                                  "D_E"
                                                              ? "Democratic Transition\nand Economic Recovery"
                                                              : searchData[index]
                                                                              .theme![
                                                                          index] ==
                                                                      "E_E"
                                                                  ? "Energy\nand Environment"
                                                                  : searchData[index].theme![
                                                                              index] ==
                                                                          "H_D"
                                                                      ? "Health\nand Development"
                                                                      : searchData[index].theme![index] ==
                                                                              "P_S"
                                                                          ? "Peace\nand Stabilization"
                                                                          : "Innovation\nand Digitization",
                                                      index: index,
                                                      textStyle: TextStyle(
                                                        color: DynamicTheme.of(
                                                                        context)
                                                                    ?.brightness ==
                                                                Brightness.light
                                                            ? Colors.black
                                                            : Colors.white,
                                                        fontSize:
                                                            screenSize.width /
                                                                110,
                                                        fontFamily:
                                                            'Montserrat',
                                                        //fontWeight: FontWeight.bold,
                                                      ),
                                                      color: searchData[index]
                                                                      .theme![
                                                                  index] ==
                                                              "R_C"
                                                          ? const Color.fromRGBO(
                                                              255, 215, 0, 1.0)
                                                          : searchData[index].theme![index] ==
                                                                  "D_E"
                                                              ? const Color.fromRGBO(
                                                                  72, 209, 204, 1.0)
                                                              : searchData[index].theme![index] ==
                                                                      "E_E"
                                                                  ? const Color.fromRGBO(
                                                                      171,
                                                                      56,
                                                                      224,
                                                                      0.75)
                                                                  : searchData[index].theme![index] ==
                                                                          "H_D"
                                                                      ? const Color.fromRGBO(
                                                                          126,
                                                                          247,
                                                                          74,
                                                                          0.75)
                                                                      : searchData[index].theme![index] == "P_S"
                                                                          ? const Color.fromRGBO(99, 164, 230, 1)
                                                                          : const Color.fromRGBO(79, 60, 201, 0.7),
                                                      border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: screenSize.height / 55),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 100.0, right: 100.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Donated Amount vs Project Budget",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  //letterSpacing: 8,
                                                  fontFamily: 'Electrolize',
                                                  fontSize:
                                                      screenSize.width / 70,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.3,
                                            child: CircularPercentIndicator(
                                              radius: 85.0,
                                              lineWidth: 25.0,
                                              animation: true,
                                              percent: double.parse(
                                                  (donatedAmount! /
                                                          searchData[index]
                                                              .budget!)
                                                      .toStringAsFixed(2)),
                                              center: Text(
                                                "${(double.parse((donatedAmount / searchData[index].budget!).toStringAsFixed(2)) * 100)}%",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              progressColor: Colors.purple,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height / 25),
                                ],
                              );
                            });
                      }
                    },
                  ),
                  SizedBox(height: screenSize.height / 10),
                  const BottomBar(),
                ],
              ),
            ),
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
                      "Type of Interventions",
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
                                items: typeOfInterventionList,
                                onChanged: (String? newValue) {
                                  dropDownState(() {
                                    initialInterventionType = newValue!;
                                    if (initialInterventionType == "All") {
                                      setState(() {
                                        // no search field input, display all items
                                        searchData = _allDonorInvolvedProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allDonorInvolvedProjects
                                            .where((element) => element.theme!
                                                .contains(
                                                    initialInterventionType))
                                            .toList();
                                      });
                                    }
                                  });
                                },
                                //show selected item
                                selectedItem: initialInterventionType,
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
                                        searchData = _allDonorInvolvedProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allDonorInvolvedProjects
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
                                        searchData = _allDonorInvolvedProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allDonorInvolvedProjects
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
                                        searchData = _allDonorInvolvedProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allDonorInvolvedProjects
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
                                        searchData = _allDonorInvolvedProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allDonorInvolvedProjects
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
                                        searchData = _allDonorInvolvedProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allDonorInvolvedProjects
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
                                        searchData = _allDonorInvolvedProjects;
                                      });
                                    } else {
                                      setState(() {
                                        searchData = _allDonorInvolvedProjects
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
                                  searchData = _allDonorInvolvedProjects;
                                });
                              } else {
                                setState(() {
                                  searchData = _allDonorInvolvedProjects
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
                                  searchData = _allDonorInvolvedProjects;
                                });
                              } else {
                                setState(() {
                                  searchData = _allDonorInvolvedProjects
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
                initialInterventionType = "All";
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
