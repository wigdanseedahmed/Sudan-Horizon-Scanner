import 'package:sudan_horizon_scanner/imports.dart';
/*

class InterventionsScreen extends StatefulWidget {
  const InterventionsScreen({Key? key}) : super(key: key);

  @override
  _InterventionsScreenState createState() => _InterventionsScreenState();
}

class _InterventionsScreenState extends State with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH PROJECT DATA FROM BACKEND
  late List<InterventionsProjectModel> readProjectDataJsonFileContent = <InterventionsProjectModel>[];

  Future<List<InterventionsProjectModel>> readProjectFromJsonFile() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('jsonDataFiles/interventions/project_data.json');
    //print(jsonString);

    setState(() {
      readProjectDataJsonFileContent = interventionsProjectModelFromJson(jsonString);
      // print("ALL  PROJECTS: $readJsonFileContent");
    });
    return readProjectDataJsonFileContent;
  }

  ///VARIABLES USED TO MAP TO BE DISPLAYED
  late String selectedItem = 'Locality';

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
    selectedItem = 'Locality';
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
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
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenSize.height / 10),
                TypeOfInterventionHeading(screenSize: screenSize),
                const InterventionCarousel(),
                SizedBox(height: screenSize.height / 10),
                InterventionsHeading(screenSize: screenSize),
                InterventionsFloatingQuickAccessBar(screenSize: screenSize),
                SizedBox(height: screenSize.height / 10),
                const BottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
