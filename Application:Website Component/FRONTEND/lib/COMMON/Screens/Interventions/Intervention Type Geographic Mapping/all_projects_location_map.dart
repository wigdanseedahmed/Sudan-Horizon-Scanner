import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class AllProjectsLocationMap extends StatefulWidget {
  const AllProjectsLocationMap({Key? key, required this.screenSize, required this.interventionScreen})
      : super(key: key);

  final Size screenSize;
  final String interventionScreen;

  @override
  _AllProjectsLocationMapState createState() => _AllProjectsLocationMapState();
}

class _AllProjectsLocationMapState extends State<AllProjectsLocationMap>
    with TickerProviderStateMixin {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH MAP DATA FROM BACKEND
  late AnimationController _projectsLocationMapcontroller;
  late MapTileLayerController _projectsLocationMapTileLayerController;
  late Map<String, MapLatLng> _projectsLocationMapMarkers;

  //List _projectsLocationMapSelectedMarkerIndices = [];

  final int _projectsLocationMapSelectedMarkerIndex = -1;
  final int _projectsLocationMapPrevSelectedMarkerIndex = -1;

  late MapZoomPanBehavior _zoomPanBehavior;

  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH MAP DATA FROM BACKEND
  List<InterventionsProjectModel> allProjectsLocationsPropertyList =
      <InterventionsProjectModel>[];

  Future<List<InterventionsProjectModel>>
      readProjectLocationMapDataFromJsonFile() async {
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
        allProjectsLocationsPropertyList =
            interventionsProjectModelFromJson(response.body);
        //print("ALL  Localities: $allProjectsLocationsPropertyList");
      });
      return allProjectsLocationsPropertyList;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }



  @override
  void initState() {
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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readProjectLocationMapDataFromJsonFile(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          return Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: widget.screenSize.height * 0.75,
              width: widget.screenSize.width * 0.75,
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
                          allProjectsLocationsPropertyList.length,
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
                            allProjectsLocationsPropertyList[index].longitude!,
                        longitude:
                            allProjectsLocationsPropertyList[index].latitude!,
                            selectedProject: allProjectsLocationsPropertyList[index],
                            interventionScreen: widget.interventionScreen,
                      ),
                      markerTooltipBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => InterventionsProjectDetailScreenWS(
                                  projectInformation: allProjectsLocationsPropertyList[index],
                                  interventionScreen: widget.interventionScreen,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: widget.screenSize.width / 2.3,
                            height: widget.screenSize.height * 0.25,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: widget.screenSize.width / 10,
                                  height: widget.screenSize.height,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(4),
                                      topLeft: Radius.circular(4),
                                    ),
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        allProjectsLocationsPropertyList[index]
                                            .photoUrl!,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: widget.screenSize.width / 3,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Text(
                                          allProjectsLocationsPropertyList[index]
                                              .projectName!,
                                          style: TextStyle(
                                              color: DynamicTheme.of(context)
                                                          ?.brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  widget.screenSize.width / 75),
                                        ),
                                      ),
                                      Center(
                                        child: ListView.builder(
                                            itemCount: allProjectsLocationsPropertyList[index].executingAgency!.length,
                                            padding: const EdgeInsets.all(0.0),
                                            shrinkWrap: true,
                                            //physics: const ClampingScrollPhysics(),
                                            //scrollDirection: Axis.horizontal,
                                            itemBuilder:
                                                (BuildContext context, int executingAgencyIndex) {
                                              return Center(
                                                child: RichText(
                                                  text: TextSpan(
                                                    // Note: Styles for TextSpans must be explicitly defined.
                                                    // Child text spans will inherit styles from parent
                                                    //maxLines: 10,
                                                    style: TextStyle(
                                                      //color: Theme.of(context).primaryColor,
                                                      fontSize: widget.screenSize.width / 95,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: allProjectsLocationsPropertyList[index]
                                                            .executingAgency![executingAgencyIndex]
                                                            .executingAgencyName!,
                                                        style: TextStyle(
                                                          fontSize: widget.screenSize.width / 95,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
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
                                                          width: widget.screenSize
                                                                  .width /
                                                              200),
                                                      Text(
                                                        "Started",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          //letterSpacing: 8,
                                                          fontFamily:
                                                              'Electrolize',
                                                          fontSize: widget
                                                                  .screenSize
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
                                                          width: widget.screenSize
                                                                  .width /
                                                              200),
                                                      Text(
                                                        "Ended",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          //letterSpacing: 8,
                                                          fontFamily:
                                                              'Electrolize',
                                                          fontSize: widget
                                                                  .screenSize
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
                                                            allProjectsLocationsPropertyList[
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
                                                      fontSize: widget
                                                              .screenSize.width /
                                                          100,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    DateFormat("EEE, MMM d, yyyy")
                                                        .format(
                                                            allProjectsLocationsPropertyList[
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
                                                      fontSize: widget
                                                              .screenSize.width /
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
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
