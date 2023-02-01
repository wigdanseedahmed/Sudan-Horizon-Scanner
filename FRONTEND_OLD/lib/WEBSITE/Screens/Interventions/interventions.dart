import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class InterventionsScreenWS extends StatefulWidget {
  const InterventionsScreenWS({Key? key}) : super(key: key);

  @override
  _InterventionsScreenWSState createState() => _InterventionsScreenWSState();
}

class _InterventionsScreenWSState extends State with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH MAP DATA FROM BACKEND
  late List<LocalityModel> readJsonFileContent = <LocalityModel>[];
  List<LocalityModel> searchData = <LocalityModel>[];

  Future<List<LocalityModel>> readLocalityMapDataFromJsonFile() async {

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

      });
      // print(searchData.length);

      return readJsonFileContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
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

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(screenSize),
        body: buildBody(context, screenSize),
      ),
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
    );
  }
}
