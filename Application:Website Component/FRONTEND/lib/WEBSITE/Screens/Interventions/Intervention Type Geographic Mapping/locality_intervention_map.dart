import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class LocalityInterventionMap extends StatefulWidget {
  const LocalityInterventionMap({Key? key}) : super(key: key);

  @override
  _LocalityInterventionMapState createState() =>
      _LocalityInterventionMapState();
}

class _LocalityInterventionMapState extends State<LocalityInterventionMap> {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH MAP DATA FROM BACKEND
  late List<LocalityModel> readJsonFileContent = <LocalityModel>[];
  List<LocalityModel> searchData = <LocalityModel>[];

  Future<List<LocalityModel>> readMapDataFromJsonFile() async {

    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.localities);

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
        readJsonFileContent = localityModelFromJson(response.body);

        if (initialTypeOfIntervention == 'All' &&
            initialLevelOfIntervention == 'Most targeted intervention type')
        //&& initialCity == 'City' &&
        // initialState == 'State' &&
        // initialRegion == 'Region' &&
        //results.isEmpty)
        {
          searchData = readJsonFileContent;
        } else {
          searchData = searchData;
        }
      });
      // print(searchData.length);

      return searchData;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  late MapZoomPanBehavior _zoomPanBehavior;
  MapShapeLayerController mapShapeLayerController = MapShapeLayerController();

  @override
  void initState() {

    initialTypeOfIntervention = 'All';
     initialLevelOfIntervention = 'Most targeted intervention type';

    ///VARIABLES USED FORT MAP LOCATION
    _zoomPanBehavior =
        MapZoomPanBehavior(enablePanning: false, enablePinching: false);

    super.initState();
    readMapDataFromJsonFile();
  }

  @override
  void dispose(){
    mapShapeLayerController.dispose();

    super.dispose();
  }

  ///VARIABLES USED FOR DROP DOWN MENU IN FILTER
  String initialTypeOfIntervention = 'All';
  String initialLevelOfIntervention = 'Most targeted intervention type';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: searchData.isEmpty? const CircularProgressIndicator() : buildMap(context, screenSize),
    );
  }

  buildMap(BuildContext context, Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.75,
      child: Center(
        child: SfMaps(
          layers: <MapShapeLayer>[
            MapShapeLayer(
               controller: mapShapeLayerController,
              source: MapShapeSource.asset(
                'jsonDataFiles/sudan_locality_2021.json',
                shapeDataField: 'ADM2_EN',
                dataCount:  searchData.length,
                primaryValueMapper: (int index) => searchData[index].localityNameEn!,
                shapeColorValueMapper: (int index) => initialLevelOfIntervention ==
                    "Most targeted intervention type"
                    ? searchData[index].mostInterventionType!
                    : initialLevelOfIntervention == "Least targeted intervention type"
                    ? searchData[index].leastInterventionType!
                    : searchData[index].noInterventionType!,
                shapeColorMappers: interventionsMapColourMapper,
              ),
              zoomPanBehavior: _zoomPanBehavior,
              legend: MapLegend(
                MapElement.shape,
                position: MapLegendPosition.left,
                title: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.filter_alt,
                        //color: primaryColour,
                        size: 30,
                      ),
                      onPressed: () {
                        _asyncFilterDialog(context);
                      },
                    ),
                    Text(
                      'Interventions',
                      style: TextStyle(
                        fontSize: screenSize.width / 50,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textStyle: TextStyle(
                  fontSize: screenSize.width / 80,
                  fontFamily: 'Montserrat',
                ),
              ),
              showDataLabels: true,
              shapeTooltipBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: screenSize.width / 2.3,
                  height: screenSize.height * 0.25,
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenSize.width / 10,
                        height: screenSize.height,
                        child: const ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            topLeft: Radius.circular(4),
                          ),
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "data:image/jpeg;base64,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"),
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
                                searchData[index].localityNameEn!,
                                style: TextStyle(
                                    color:
                                        DynamicTheme.of(context)?.brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                    fontSize: screenSize.width / 75),
                              ),
                            ),
                            Divider(
                              color: DynamicTheme.of(context)?.brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                              height: 10,
                              thickness: 1.2,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: DynamicTheme.of(context)
                                                    ?.brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        size: screenSize.width / 120,
                                      ),
                                      SizedBox(width: screenSize.width / 100),
                                      RichText(
                                        text: TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          //maxLines: 10,
                                          style: TextStyle(
                                            fontSize: screenSize.width / 100,
                                            fontFamily: 'Montserrat',
                                            //fontWeight: FontWeight.bold,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "Area: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize:
                                                    screenSize.width / 120,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "${searchData[index].shapeArea!}",
                                              style: TextStyle(
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize:
                                                    screenSize.width / 120,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: DynamicTheme.of(context)
                                                    ?.brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        size: screenSize.width / 120,
                                      ),
                                      SizedBox(width: screenSize.width / 100),
                                      RichText(
                                        text: TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          //maxLines: 10,
                                          style: TextStyle(
                                            fontSize: screenSize.width / 100,
                                            fontFamily: 'Montserrat',
                                            //fontWeight: FontWeight.bold,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "Population: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize:
                                                    screenSize.width / 120,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "${searchData[index].population!}",
                                              style: TextStyle(
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize:
                                                    screenSize.width / 120,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: DynamicTheme.of(context)
                                                    ?.brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        size: screenSize.width / 120,
                                      ),
                                      SizedBox(width: screenSize.width / 100),
                                      RichText(
                                        text: TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          //maxLines: 10,
                                          style: TextStyle(
                                            fontSize: screenSize.width / 100,
                                            fontFamily: 'Montserrat',
                                            //fontWeight: FontWeight.bold,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "Most targeted intervention type based on number of projects:\n",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize:
                                                    screenSize.width / 120,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            TextSpan(
                                              text: searchData[index]
                                                          .mostInterventionType! ==
                                                      "R_C"
                                                  ? "Rules of Law and Constitutional Building"
                                                  : searchData[index]
                                                              .mostInterventionType! ==
                                                          "D_E"
                                                      ? "Democratic Transition and Economic Recovery"
                                                      : searchData[
                                                                      index]
                                                                  .mostInterventionType! ==
                                                              "H_D"
                                                          ? "Health and Development"
                                                          : searchData[
                                                                          index]
                                                                      .mostInterventionType! ==
                                                                  "I_D"
                                                              ? "Innovation and Digitization"
                                                              : searchData[
                                                                              index]
                                                                          .mostInterventionType! ==
                                                                      "E_E"
                                                                  ? "Energy and Environment"
                                                                  : "Peace and Stabilization",
                                              style: TextStyle(
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize:
                                                    screenSize.width / 120,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: DynamicTheme.of(context)
                                                    ?.brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        size: screenSize.width / 120,
                                      ),
                                      SizedBox(width: screenSize.width / 100),
                                      RichText(
                                        text: TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          //maxLines: 10,
                                          style: TextStyle(
                                            fontSize: screenSize.width / 100,
                                            fontFamily: 'Montserrat',
                                            //fontWeight: FontWeight.bold,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "Least targeted intervention type based on number of projects:\n",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize:
                                                    screenSize.width / 120,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            TextSpan(
                                              text: searchData[index]
                                                          .leastInterventionType! ==
                                                      "R_C"
                                                  ? "Rules of Law and Constitutional Building"
                                                  : searchData[index]
                                                              .leastInterventionType! ==
                                                          "D_E"
                                                      ? "Democratic Transition and Economic Recovery"
                                                      : searchData[
                                                                      index]
                                                                  .leastInterventionType! ==
                                                              "H_D"
                                                          ? "Health and Development"
                                                          : searchData[
                                                                          index]
                                                                      .leastInterventionType! ==
                                                                  "I_D"
                                                              ? "Innovation and Digitization"
                                                              : searchData[
                                                                              index]
                                                                          .leastInterventionType! ==
                                                                      "E_E"
                                                                  ? "Energy and Environment"
                                                                  : "Peace and Stabilization",
                                              style: TextStyle(
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize:
                                                    screenSize.width / 120,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: DynamicTheme.of(context)
                                                    ?.brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        size: screenSize.width / 120,
                                      ),
                                      SizedBox(width: screenSize.width / 100),
                                      RichText(
                                        text: TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          //maxLines: 10,
                                          style: TextStyle(
                                            fontSize: screenSize.width / 100,
                                            fontFamily: 'Montserrat',
                                            //fontWeight: FontWeight.bold,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "No projects were made targeting this intervention type:\n",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize:
                                                    screenSize.width / 120,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            TextSpan(
                                              text: searchData[index]
                                                          .noInterventionType! ==
                                                      "R_C"
                                                  ? "Rules of Law and Constitutional Building"
                                                  : searchData[index]
                                                              .noInterventionType! ==
                                                          "D_E"
                                                      ? "Democratic Transition and Economic Recovery"
                                                      : searchData[
                                                                      index]
                                                                  .noInterventionType! ==
                                                              "H_D"
                                                          ? "Health and Development"
                                                          : searchData[
                                                                          index]
                                                                      .noInterventionType! ==
                                                                  "I_D"
                                                              ? "Innovation and Digitization"
                                                              : searchData[
                                                                              index]
                                                                          .noInterventionType! ==
                                                                      "E_E"
                                                                  ? "Energy and Environment"
                                                                  : "Peace and Stabilization",
                                              style: TextStyle(
                                                color: DynamicTheme.of(context)
                                                            ?.brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize:
                                                    screenSize.width / 120,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
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
                color: DynamicTheme.of(context)?.brightness == Brightness.light
                    ? Colors.white
                    : const Color(0xFF323232),
                strokeWidth: 0.5,
                strokeColor:
                    DynamicTheme.of(context)?.brightness == Brightness.light
                        ? const Color(0xFF323232)
                        : Colors.white,
              ),
              strokeColor:
                  DynamicTheme.of(context)?.brightness == Brightness.light
                      ? Colors.white
                      : const Color(0xFF323232),
              strokeWidth: 1,
              dataLabelSettings: MapDataLabelSettings(
                textStyle: TextStyle(
                  color:
                      DynamicTheme.of(context)?.brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width / 250,
                ),
              ),
            ),
          ],
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
                      "Types of Interventions",
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
                                    initialTypeOfIntervention = newValue!;
                                    if (initialTypeOfIntervention == "All") {
                                      setState(() {
                                        // no search field input, display all items
                                        searchData = readJsonFileContent;
                                      });
                                    } else {
                                      setState(() {
                                        if ("Rule of Law and Constitutional Building" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'R_C')
                                              .toList();
                                        } else if ("Democratic Transition and Economic Recovery" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'D_E')
                                              .toList();
                                        } else if ("Energy and Environment" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'E_E')
                                              .toList();
                                        } else if ("Health and Development" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'H_D')
                                              .toList();
                                        } else if ("Peace and Stabilization" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'P_S')
                                              .toList();
                                        } else if ("Innovation and Digitization" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'I_D')
                                              .toList();
                                        } else if ("Rule of Law and Constitutional Building" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'R_C')
                                              .toList();
                                        } else if ("Democratic Transition and Economic Recovery" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'D_E')
                                              .toList();
                                        } else if ("Energy and Environment" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'E_E')
                                              .toList();
                                        } else if ("Health and Development" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'H_D')
                                              .toList();
                                        } else if ("Peace and Stabilization" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'P_S')
                                              .toList();
                                        } else if ("Innovation and Digitization" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'I_D')
                                              .toList();
                                        } else if ("Rule of Law and Constitutional Building" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'R_C')
                                              .toList();
                                        } else if ("Democratic Transition and Economic Recovery" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'D_E')
                                              .toList();
                                        } else if ("Energy and Environment" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'E_E')
                                              .toList();
                                        } else if ("Health and Development" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'H_D')
                                              .toList();
                                        } else if ("Peace and Stabilization" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'P_S')
                                              .toList();
                                        } else if ("Innovation and Digitization" ==
                                                newValue.toString() &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'I_D')
                                              .toList();
                                        }
                                      });
                                    }
                                  });
                                },
                                //show selected item
                                selectedItem: initialTypeOfIntervention,
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
                      "Level of Interventions\nBased on Numbers of Projects",
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
                                items: levelOfInterventionList,
                                onChanged: (String? newValue) {
                                  dropDownState(() {
                                    initialLevelOfIntervention = newValue!;
                                    if (initialTypeOfIntervention == "All") {
                                      setState(() {
// no search field input, display all items
                                        searchData = readJsonFileContent;
                                      });
                                    } else {
                                      setState(() {
                                        if ("Rule of Law and Constitutional Building" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'R_C')
                                              .toList();
                                        } else if ("Democratic Transition and Economic Recovery" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'D_E')
                                              .toList();
                                        } else if ("Energy and Environment" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'E_E')
                                              .toList();
                                        } else if ("Health and Development" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'H_D')
                                              .toList();
                                        } else if ("Peace and Stabilization" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'P_S')
                                              .toList();
                                        } else if ("Innovation and Digitization" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Most targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.mostInterventionType
                                                      .toString() ==
                                                  'I_D')
                                              .toList();
                                        } else if ("Rule of Law and Constitutional Building" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'R_C')
                                              .toList();
                                        } else if ("Democratic Transition and Economic Recovery" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'D_E')
                                              .toList();
                                        } else if ("Energy and Environment" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'E_E')
                                              .toList();
                                        } else if ("Health and Development" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'H_D')
                                              .toList();
                                        } else if ("Peace and Stabilization" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'P_S')
                                              .toList();
                                        } else if ("Innovation and Digitization" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Least targeted intervention type') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.leastInterventionType
                                                      .toString() ==
                                                  'I_D')
                                              .toList();
                                        } else if ("Rule of Law and Constitutional Building" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'R_C')
                                              .toList();
                                        } else if ("Democratic Transition and Economic Recovery" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'D_E')
                                              .toList();
                                        } else if ("Energy and Environment" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'E_E')
                                              .toList();
                                        } else if ("Health and Development" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'H_D')
                                              .toList();
                                        } else if ("Peace and Stabilization" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'P_S')
                                              .toList();
                                        } else if ("Innovation and Digitization" ==
                                                initialTypeOfIntervention &&
                                            initialLevelOfIntervention ==
                                                'Intervention type not targeted') {
                                          searchData = readJsonFileContent
                                              .where((LocalityModel locality) =>
                                                  locality.noInterventionType
                                                      .toString() ==
                                                  'I_D')
                                              .toList();
                                        }
                                      });
                                    }
                                  });
                                },
                                //show selected item
                                selectedItem: initialLevelOfIntervention,
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height / 50),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                searchData = readJsonFileContent;
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                initialTypeOfIntervention = 'All';
                initialLevelOfIntervention = 'Most targeted intervention type';
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
