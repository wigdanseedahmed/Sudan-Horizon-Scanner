import 'package:sudan_horizon_scanner/imports.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:http/http.dart' as http;

class nInterventionsProjectDetailScreenWS extends StatefulWidget {
  const nInterventionsProjectDetailScreenWS(
      {Key? key, required this.projectInformation, required this.interventionScreen})
      : super(key: key);

  final InterventionsProjectModel projectInformation;
  final String interventionScreen;

  @override
  _nInterventionsProjectDetailScreenWSState createState() =>
      _nInterventionsProjectDetailScreenWSState();
}

class _nInterventionsProjectDetailScreenWSState
    extends State<nInterventionsProjectDetailScreenWS>
    with TickerProviderStateMixin {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND

  late String? typeOfIntervention = "";

  TextEditingController taskSearchBarTextEditingController =
      TextEditingController();

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

  late TooltipBehavior _tooltip;

  @override
  void initState() {
    ///VARIABLES USED TO SCROLL THROUGH SCREEN
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    ///VARIABLES USED FORT MAP LOCATION
    _zoomPanBehavior = MapZoomPanBehavior(
        enablePanning: false,
        enablePinching: false,
        enableDoubleTapZooming: false,
        minZoomLevel: 5.0);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.repeat(min: 0.15, max: 1.0, reverse: true);

    _tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');

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
                  SizedBox(
                    width: screenSize.width,
                    child: Text(
                      widget.projectInformation.projectName!,
                      style: TextStyle(
                        fontSize: screenSize.width / 60,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height / 100),
                  SizedBox(
                    width: screenSize.width,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.grey,
                          size: screenSize.width / 85,
                        ),
                        SizedBox(width: screenSize.width / 250),
                        Text(
                          "${widget.projectInformation.localityNameEn!}, ${widget.projectInformation.cityNameEn!}, ${widget.projectInformation.stateNameEn!}, ${widget.projectInformation.provinceNameEn!}, ${widget.projectInformation.regionNameEn!}",
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
                  Container(
                    height: screenSize.height * 0.45,
                    width: screenSize.width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image:
                            NetworkImage(widget.projectInformation.photoUrl!),
                        fit: BoxFit.cover,
                      ),
                      /*Image.asset(
                        'assets/images/rule_of_law.jpg',
                        fit: BoxFit.fitWidth,
                      ),*/
                      //NetworkImage(widget.projectInformation.photoURL!),
                    ),
                  ),
                  SizedBox(height: screenSize.height / 25),
                  Row(
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.6,
                        child: Column(
                          children: [
                            InterventionsProjectDetailHeader(
                                screenSize: screenSize,
                                headerTitle: 'Description'),
                            SizedBox(
                              width: screenSize.width,
                              child: Text(
                                widget.projectInformation.projectDetail!,
                                style: TextStyle(
                                  fontSize: screenSize.width / 90,
                                  fontFamily: 'Montserrat',
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: screenSize.height / 25),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenSize.width * 0.01),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: screenSize.height / 25,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time_outlined,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                                width: screenSize.width / 200),
                                            Text(
                                              "Started",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                //letterSpacing: 8,
                                                fontFamily: 'Electrolize',
                                                fontSize: screenSize.width / 60,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenSize.height / 25,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time_outlined,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                                width: screenSize.width / 200),
                                            Text(
                                              "Ended",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                //letterSpacing: 8,
                                                fontFamily: 'Electrolize',
                                                fontSize: screenSize.width / 60,
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
                                        height: screenSize.height / 25,
                                        child: Text(
                                          DateFormat("EEE, MMM d, yyyy").format(
                                              widget.projectInformation
                                                  .startDate!),
                                          //DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(widget.projectInformation.startDate)),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            //letterSpacing: 8,
                                            fontFamily: 'Electrolize',
                                            fontSize: screenSize.width / 90,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenSize.height / 25,
                                        child: Text(
                                          DateFormat("EEE, MMM d, yyyy").format(
                                              widget
                                                  .projectInformation.endDate!),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            //letterSpacing: 8,
                                            fontFamily: 'Electrolize',
                                            fontSize: screenSize.width / 90,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenSize.height / 25),
                            InterventionsProjectDetailHeader(
                                screenSize: screenSize,
                                headerTitle: 'Types of Intervention'),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                width: screenSize.width * 0.55,
                                child: Tags(
                                  spacing: 16,
                                  alignment: WrapAlignment.center,
                                  itemCount:
                                      widget.projectInformation.theme!.length,
                                  itemBuilder: (int index) {
                                    return Tooltip(
                                      message: widget.projectInformation
                                                  .theme![index] ==
                                              "R_C"
                                          ? "Rule of Law and\nConstitutional Building"
                                          : widget.projectInformation
                                                      .theme![index] ==
                                                  "D_E"
                                              ? "Democratic Transition\nand Economic Recovery"
                                              : widget.projectInformation
                                                          .theme![index] ==
                                                      "E_E"
                                                  ? "Energy\nand Environment"
                                                  : widget.projectInformation
                                                              .theme![index] ==
                                                          "H_D"
                                                      ? "Health\nand Development"
                                                      : widget.projectInformation
                                                                      .theme![
                                                                  index] ==
                                                              "P_S"
                                                          ? "Peace\nand Stabilization"
                                                          : "Innovation\nand Digitization",
                                      child: ItemTags(
                                        active: false,
                                        title: widget.projectInformation
                                                    .theme![index] ==
                                                "R_C"
                                            ? "Rule of Law and\nConstitutional Building"
                                            : widget.projectInformation
                                                        .theme![index] ==
                                                    "D_E"
                                                ? "Democratic Transition\nand Economic Recovery"
                                                : widget.projectInformation
                                                            .theme![index] ==
                                                        "E_E"
                                                    ? "Energy\nand Environment"
                                                    : widget.projectInformation
                                                                    .theme![
                                                                index] ==
                                                            "H_D"
                                                        ? "Health\nand Development"
                                                        : widget.projectInformation
                                                                        .theme![
                                                                    index] ==
                                                                "P_S"
                                                            ? "Peace\nand Stabilization"
                                                            : "Innovation\nand Digitization",
                                        index: index,
                                        textStyle: TextStyle(
                                          color: DynamicTheme.of(context)
                                                      ?.brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: screenSize.width / 110,
                                          fontFamily: 'Montserrat',
                                          //fontWeight: FontWeight.bold,
                                        ),
                                        color: widget.projectInformation.theme![index] ==
                                                "R_C"
                                            ? const Color.fromRGBO(
                                                255, 215, 0, 1.0)
                                            : widget.projectInformation.theme![index] ==
                                                    "D_E"
                                                ? const Color.fromRGBO(
                                                    72, 209, 204, 1.0)
                                                : widget.projectInformation
                                                            .theme![index] ==
                                                        "E_E"
                                                    ? const Color.fromRGBO(
                                                        171, 56, 224, 0.75)
                                                    : widget.projectInformation.theme![index] ==
                                                            "H_D"
                                                        ? const Color.fromRGBO(
                                                            126, 247, 74, 0.75)
                                                        : widget.projectInformation.theme![index] ==
                                                                "P_S"
                                                            ? const Color.fromRGBO(
                                                                99, 164, 230, 1)
                                                            : const Color.fromRGBO(
                                                                79, 60, 201, 0.7),
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: screenSize.height / 25),
                            InterventionsProjectDetailHeader(
                                screenSize: screenSize, headerTitle: 'Donor'),
                            BuildInterventionsDonorList(
                              screenSize: screenSize,
                              selectedProject: widget.projectInformation,
                              selectedProjectName:
                                  widget.projectInformation.projectName!,
                              interventionScreen: widget.interventionScreen,
                            ),
                            SizedBox(height: screenSize.height / 25),
                            InterventionsProjectDetailHeader(
                                screenSize: screenSize,
                                headerTitle: 'Executing Agency'),
                            BuildInterventionsExecutingAgencyList(
                              screenSize: screenSize,
                              selectedProject: widget.projectInformation,
                              selectedProjectName:
                                  widget.projectInformation.projectName!,
                                interventionScreen: widget.interventionScreen,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.02),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenSize.height * 0.03),
                          Text(
                            "Project Address",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              //letterSpacing: 8,
                              fontFamily: 'Electrolize',
                              fontSize: screenSize.width / 60,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: screenSize.height / 55),
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: screenSize.width * 0.2,
                              child: ProjectLocationMap(
                                context: context,
                                latitude: widget.projectInformation.latitude!,
                                longitude: widget.projectInformation.longitude!,
                                animation: _animation,
                                zoomPanBehavior: _zoomPanBehavior,
                                screenSize: screenSize,
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height / 25),
                          Text(
                            "Donated Amount vs\nProject Budget",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              //letterSpacing: 8,
                              fontFamily: 'Electrolize',
                              fontSize: screenSize.width / 60,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: screenSize.height / 55),
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: screenSize.width * 0.2,
                              child: SfCircularChart(
                                legend: Legend(
                                  isVisible: true,
                                  overflowMode: LegendItemOverflowMode.wrap,
                                  position: LegendPosition.bottom,
                                  alignment: ChartAlignment.near,
                                  textStyle: TextStyle(
                                    fontSize: screenSize.width / 150,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                series: <
                                    DoughnutSeries<InterventionsDonorModel,
                                        String>>[
                                  DoughnutSeries<InterventionsDonorModel,
                                      String>(
                                    radius: '50%',
                                    explode: true,
                                    explodeOffset: '50%',
                                    dataSource: widget.projectInformation.donor,
                                    startAngle: 360,
                                    // Starting angle of doughnut
                                    endAngle: 360 - int.parse((widget
                                                .projectInformation
                                                .totalDonatedAmount! /
                                            widget.projectInformation.budget!)
                                        .toStringAsFixed(0) * 360),
                                    // Ending angle of doughnut
                                    xValueMapper:
                                        (InterventionsDonorModel data, _) =>
                                            data.donorName as String,
                                    yValueMapper:
                                        (InterventionsDonorModel data, _) =>
                                            (data.donationAmount! /
                                            widget.projectInformation.budget!) * 100,
                                    dataLabelMapper:
                                        (InterventionsDonorModel data, _) =>
                                            data.donorName,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(
                                        fontSize: screenSize.width / 200,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      labelIntersectAction: LabelIntersectAction.shift,
                                      labelAlignment: ChartDataLabelAlignment.top,
                                      connectorLineSettings: const ConnectorLineSettings(
                                        length: '10',
                                        type: ConnectorType.curve,
                                        width: 2,
                                      ),
                                      labelPosition:
                                          ChartDataLabelPosition.outside,
                                    ),
                                  )
                                ],
                                tooltipBehavior: _tooltip,
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height / 3),
                        ],
                      ),
                    ],
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
}
