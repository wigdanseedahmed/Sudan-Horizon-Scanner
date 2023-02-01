import 'package:sudan_horizon_scanner/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  late List<AustraliaCountryDensityModel> _worldPopulationDensityDetails;
  late MapShapeSource _mapShapeSource;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _worldPopulationDensityDetails = <AustraliaCountryDensityModel>[
      AustraliaCountryDensityModel('Monaco', 26337),
      AustraliaCountryDensityModel('Macao', 21717),
      AustraliaCountryDensityModel('Singapore', 8358),
      AustraliaCountryDensityModel('Hong kong', 7140),
      AustraliaCountryDensityModel('Gibraltar', 3369),
      AustraliaCountryDensityModel('Bahrain', 2239),
      AustraliaCountryDensityModel('Holy See', 1820),
      AustraliaCountryDensityModel('Maldives', 1802),
      AustraliaCountryDensityModel('Malta', 1380),
      AustraliaCountryDensityModel('Bangladesh', 1265),
      AustraliaCountryDensityModel('Sint Maarten', 1261),
      AustraliaCountryDensityModel('Bermuda', 1246),
      AustraliaCountryDensityModel('Channel Islands', 915),
      AustraliaCountryDensityModel('State of Palestine', 847),
      AustraliaCountryDensityModel('Saint-Martin', 729),
      AustraliaCountryDensityModel('Mayotte', 727),
      AustraliaCountryDensityModel('Taiwan', 672),
      AustraliaCountryDensityModel('Barbados', 668),
      AustraliaCountryDensityModel('Lebanon', 667),
      AustraliaCountryDensityModel('Mauritius', 626),
      AustraliaCountryDensityModel('Aruba', 593),
      AustraliaCountryDensityModel('San Marino', 565),
      AustraliaCountryDensityModel('Nauru', 541),
      AustraliaCountryDensityModel('Korea', 527),
      AustraliaCountryDensityModel('Rwanda', 525),
      AustraliaCountryDensityModel('Netherlands', 508),
      AustraliaCountryDensityModel('Comoros', 467),
      AustraliaCountryDensityModel('India', 464),
      AustraliaCountryDensityModel('Burundi', 463),
      AustraliaCountryDensityModel('Saint-Barthélemy', 449),
      AustraliaCountryDensityModel('Haiti', 413),
      AustraliaCountryDensityModel('Israel', 400),
      AustraliaCountryDensityModel('Tuvalu', 393),
      AustraliaCountryDensityModel('Belgium', 382),
      AustraliaCountryDensityModel('Curacao', 369),
      AustraliaCountryDensityModel('Philippines', 367),
      AustraliaCountryDensityModel('Reunion', 358),
      AustraliaCountryDensityModel('Martinique', 354),
      AustraliaCountryDensityModel('Japan', 346),
      AustraliaCountryDensityModel('Sri Lanka', 341),
      AustraliaCountryDensityModel('Grenada', 331),
      AustraliaCountryDensityModel('Marshall Islands', 328),
      AustraliaCountryDensityModel('Puerto Rico', 322),
      AustraliaCountryDensityModel('Vietnam', 313),
      AustraliaCountryDensityModel('El Salvador', 313),
      AustraliaCountryDensityModel('Guam', 312),
      AustraliaCountryDensityModel('Saint Lucia', 301),
      AustraliaCountryDensityModel('United States Virgin Islands', 298),
      AustraliaCountryDensityModel('Pakistan', 286),
      AustraliaCountryDensityModel('Saint Vincent and the Grenadines', 284),
      AustraliaCountryDensityModel('United Kingdom', 280),
      AustraliaCountryDensityModel('American Samoa', 276),
      AustraliaCountryDensityModel('Cayman Islands', 273),
      AustraliaCountryDensityModel('Jamaica', 273),
      AustraliaCountryDensityModel('Trinidad and Tobago', 272),
      AustraliaCountryDensityModel('Qatar', 248),
      AustraliaCountryDensityModel('Guadeloupe', 245),
      AustraliaCountryDensityModel('Luxembourg', 241),
      AustraliaCountryDensityModel('Germany', 240),
      AustraliaCountryDensityModel('Kuwait', 239),
      AustraliaCountryDensityModel('Gambia', 238),
      AustraliaCountryDensityModel('Liechtenstein', 238),
      AustraliaCountryDensityModel('Uganda', 228),
      AustraliaCountryDensityModel('Sao Tome and Principe', 228),
      AustraliaCountryDensityModel('Nigeria', 226),
      AustraliaCountryDensityModel('Dominican Rep.', 224),
      AustraliaCountryDensityModel('Antigua and Barbuda', 222),
      AustraliaCountryDensityModel('Switzerland', 219),
      AustraliaCountryDensityModel('Dem. Rep. Korea', 214),
      AustraliaCountryDensityModel('Seychelles', 213),
      AustraliaCountryDensityModel('Italy', 205),
      AustraliaCountryDensityModel('Saint Kitts and Nevis', 204),
      AustraliaCountryDensityModel('Nepal', 203),
      AustraliaCountryDensityModel('Malawi', 202),
      AustraliaCountryDensityModel('British Virgin Islands', 201),
      AustraliaCountryDensityModel('Guatemala', 167),
      AustraliaCountryDensityModel('Anguilla', 166),
      AustraliaCountryDensityModel('Andorra', 164),
      AustraliaCountryDensityModel('Micronesia', 164),
      AustraliaCountryDensityModel('China', 153),
      AustraliaCountryDensityModel('Togo', 152),
      AustraliaCountryDensityModel('Indonesia', 151),
      AustraliaCountryDensityModel('Isle of Man', 149),
      AustraliaCountryDensityModel('Kiribati', 147),
      AustraliaCountryDensityModel('Tonga', 146),
      AustraliaCountryDensityModel('Czech Rep.', 138),
      AustraliaCountryDensityModel('Cabo Verde', 138),
      AustraliaCountryDensityModel('Thailand', 136),
      AustraliaCountryDensityModel('Ghana', 136),
      AustraliaCountryDensityModel('Denmark', 136),
      AustraliaCountryDensityModel('Tokelau', 135),
      AustraliaCountryDensityModel('Cyprus', 130),
      AustraliaCountryDensityModel('Northern Mariana Islands', 125),
      AustraliaCountryDensityModel('Poland', 123),
      AustraliaCountryDensityModel('Moldova', 122),
      AustraliaCountryDensityModel('Azerbaijan', 122),
      AustraliaCountryDensityModel('France', 119),
      AustraliaCountryDensityModel('United Arab Emirates', 118),
      AustraliaCountryDensityModel('Ethiopia', 115),
      AustraliaCountryDensityModel('Jordan', 114),
      AustraliaCountryDensityModel('Slovakia', 113),
      AustraliaCountryDensityModel('Portugal', 111),
      AustraliaCountryDensityModel('Sierra Leone', 110),
      AustraliaCountryDensityModel('Turkey', 109),
      AustraliaCountryDensityModel('Austria', 109),
      AustraliaCountryDensityModel('Benin', 107),
      AustraliaCountryDensityModel('Hungary', 106),
      AustraliaCountryDensityModel('Cuba', 106),
      AustraliaCountryDensityModel('Albania', 105),
      AustraliaCountryDensityModel('Armenia', 104),
      AustraliaCountryDensityModel('Slovenia', 103),
      AustraliaCountryDensityModel('Egypt', 102),
      AustraliaCountryDensityModel('Serbia', 99),
      AustraliaCountryDensityModel('Costa Rica', 99),
      AustraliaCountryDensityModel('Malaysia', 98),
      AustraliaCountryDensityModel('Dominica', 95),
      AustraliaCountryDensityModel('Syria', 95),
      AustraliaCountryDensityModel('Cambodia', 94),
      AustraliaCountryDensityModel('Kenya', 94),
      AustraliaCountryDensityModel('Spain', 93),
      AustraliaCountryDensityModel('Iraq', 92),
      AustraliaCountryDensityModel('Timor-Leste', 88),
      AustraliaCountryDensityModel('Honduras', 88),
      AustraliaCountryDensityModel('Senegal', 86),
      AustraliaCountryDensityModel('Romania', 83),
      AustraliaCountryDensityModel('Myanmar', 83),
      AustraliaCountryDensityModel('Brunei Darussalam', 83),
      AustraliaCountryDensityModel("Côte d'Ivoire", 82),
      AustraliaCountryDensityModel('Morocco', 82),
      AustraliaCountryDensityModel('Macedonia', 82),
      AustraliaCountryDensityModel('Greece', 80),
      AustraliaCountryDensityModel('Wallis and Futuna Islands', 80),
      AustraliaCountryDensityModel('Bonaire, Sint Eustatius and Saba', 79),
      AustraliaCountryDensityModel('Uzbekistan', 78),
      AustraliaCountryDensityModel('French Polynesia', 76),
      AustraliaCountryDensityModel('Burkina Faso', 76),
      AustraliaCountryDensityModel('Tunisia', 76),
      AustraliaCountryDensityModel('Ukraine', 75),
      AustraliaCountryDensityModel('Croatia', 73),
      AustraliaCountryDensityModel('Cook Islands', 73),
      AustraliaCountryDensityModel('Ireland', 71),
      AustraliaCountryDensityModel('Ecuador', 71),
      AustraliaCountryDensityModel('Lesotho', 70),
      AustraliaCountryDensityModel('Samoa', 70),
      AustraliaCountryDensityModel('Guinea-Bissau', 69),
      AustraliaCountryDensityModel('Tajikistan', 68),
      AustraliaCountryDensityModel('Eswatini', 67),
      AustraliaCountryDensityModel('Tanzania', 67),
      AustraliaCountryDensityModel('Mexico', 66),
      AustraliaCountryDensityModel('Bosnia and Herz.', 64),
      AustraliaCountryDensityModel('Bulgaria', 64),
      AustraliaCountryDensityModel('Afghanistan', 59),
      AustraliaCountryDensityModel('Panama', 58),
      AustraliaCountryDensityModel('Georgia', 57),
      AustraliaCountryDensityModel('Yemen', 56),
      AustraliaCountryDensityModel('Cameroon', 56),
      AustraliaCountryDensityModel('Nicaragua', 55),
      AustraliaCountryDensityModel('Guinea', 53),
      AustraliaCountryDensityModel('Liberia', 52),
      AustraliaCountryDensityModel('Iran', 51),
      AustraliaCountryDensityModel('Eq. Guinea', 50),
      AustraliaCountryDensityModel('Montserrat', 49),
      AustraliaCountryDensityModel('Fiji', 49),
      AustraliaCountryDensityModel('South Africa', 48),
      AustraliaCountryDensityModel('Madagascar', 47),
      AustraliaCountryDensityModel('Montenegro', 46),
      AustraliaCountryDensityModel('Belarus', 46),
      AustraliaCountryDensityModel('Colombia', 45),
      AustraliaCountryDensityModel('Lithuania', 43),
      AustraliaCountryDensityModel('Djibouti', 42),
      AustraliaCountryDensityModel('Turks and Caicos Islands', 40),
      AustraliaCountryDensityModel('Mozambique', 39),
      AustraliaCountryDensityModel('Dem. Rep. Congo', 39),
      AustraliaCountryDensityModel('Palau', 39),
      AustraliaCountryDensityModel('Bahamas', 39),
      AustraliaCountryDensityModel('Zimbabwe', 38),
      AustraliaCountryDensityModel('United States of America', 36),
      AustraliaCountryDensityModel('Eritrea', 35),
      AustraliaCountryDensityModel('Faroe Islands', 35),
      AustraliaCountryDensityModel('Kyrgyzstan', 34),
      AustraliaCountryDensityModel('Venezuela', 32),
      AustraliaCountryDensityModel('Lao PDR', 31),
      AustraliaCountryDensityModel('Estonia', 31),
      AustraliaCountryDensityModel('Latvia', 30),
      AustraliaCountryDensityModel('Angola', 26),
      AustraliaCountryDensityModel('Peru', 25),
      AustraliaCountryDensityModel('Chile', 25),
      AustraliaCountryDensityModel('Brazil', 25),
      AustraliaCountryDensityModel('Somalia', 25),
      AustraliaCountryDensityModel('Vanuatu', 25),
      AustraliaCountryDensityModel('Saint Pierre and Miquelon', 25),
      AustraliaCountryDensityModel('Sudan', 24),
      AustraliaCountryDensityModel('Zambia', 24),
      AustraliaCountryDensityModel('Sweden', 24),
      AustraliaCountryDensityModel('Solomon Islands', 24),
      AustraliaCountryDensityModel('Bhutan', 20),
      AustraliaCountryDensityModel('Uruguay', 19),
      AustraliaCountryDensityModel('Papua New Guinea', 19),
      AustraliaCountryDensityModel('Niger', 19),
      AustraliaCountryDensityModel('Algeria', 18),
      AustraliaCountryDensityModel('S. Sudan', 18),
      AustraliaCountryDensityModel('New Zealand', 18),
      AustraliaCountryDensityModel('Finland', 18),
      AustraliaCountryDensityModel('Paraguay', 17),
      AustraliaCountryDensityModel('Belize', 17),
      AustraliaCountryDensityModel('Mali', 16),
      AustraliaCountryDensityModel('Argentina', 16),
      AustraliaCountryDensityModel('Oman', 16),
      AustraliaCountryDensityModel('Saudi Arabia', 16),
      AustraliaCountryDensityModel('Congo', 16),
      AustraliaCountryDensityModel('New Caledonia', 15),
      AustraliaCountryDensityModel('Saint Helena', 15),
      AustraliaCountryDensityModel('Norway', 14),
      AustraliaCountryDensityModel('Chad', 13),
      AustraliaCountryDensityModel('Turkmenistan', 12),
      AustraliaCountryDensityModel('Bolivia', 10),
      AustraliaCountryDensityModel('Russia', 8),
      AustraliaCountryDensityModel('Gabon', 8),
      AustraliaCountryDensityModel('Central African Rep.', 7),
      AustraliaCountryDensityModel('Kazakhstan', 6),
      AustraliaCountryDensityModel('Niue', 6),
      AustraliaCountryDensityModel('Mauritania', 4),
      AustraliaCountryDensityModel('Canada', 4),
      AustraliaCountryDensityModel('Botswana', 4),
      AustraliaCountryDensityModel('Guyana', 3),
      AustraliaCountryDensityModel('Libya', 3),
      AustraliaCountryDensityModel('Suriname', 3),
      AustraliaCountryDensityModel('French Guiana', 3),
      AustraliaCountryDensityModel('Iceland', 3),
      AustraliaCountryDensityModel('Australia', 3),
      AustraliaCountryDensityModel('Namibia', 3),
      AustraliaCountryDensityModel('W. Sahara', 2),
      AustraliaCountryDensityModel('Mongolia', 2),
      AustraliaCountryDensityModel('Falkland Is.', 0.2),
      AustraliaCountryDensityModel('Greenland', 0.1),
    ];

    _mapShapeSource = MapShapeSource.asset(
      'jsonDataFiles/interventions/world_map.json',
      shapeDataField: 'name',
      dataCount: _worldPopulationDensityDetails.length,
      primaryValueMapper: (int index) =>
          _worldPopulationDensityDetails[index].countryName,
      shapeColorValueMapper: (int index) =>
          _worldPopulationDensityDetails[index].density,
      shapeColorMappers: const [
        MapColorMapper(
            from: 0,
            to: 25,
            color: Color.fromRGBO(223, 169, 254, 1),
            text: '{0},{25}'),
        MapColorMapper(
            from: 25,
            to: 75,
            color: Color.fromRGBO(190, 78, 253, 1),
            text: '75'),
        MapColorMapper(
            from: 75,
            to: 150,
            color: Color.fromRGBO(167, 17, 252, 1),
            text: '150'),
        MapColorMapper(
            from: 150,
            to: 400,
            color: Color.fromRGBO(152, 3, 236, 1),
            text: '400'),
        MapColorMapper(
            from: 400,
            to: 50000,
            color: Color.fromRGBO(113, 2, 176, 1),
            text: '>500'),
      ],
    );

    super.initState();
  }

  @override
  void dispose() {
    _worldPopulationDensityDetails.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor:
                  Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.brightness_6),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                  },
                ),
              ],
              title: Text(
                'Sudan Horizon Scanner',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContentsWS(_opacity),
            ),
      drawer: const SmallScreenMenuDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 600,
                  child: Center(
                    child: SfMaps(
                      layers: [
                        MapShapeLayer(
                          source: _mapShapeSource,
                          strokeColor: Colors.white30,
                          legend: const MapLegend.bar(
                            MapElement.shape,
                            position: MapLegendPosition.bottom,
                            segmentSize: Size(55.0, 9.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /*Column(
                  children: [
                    FloatingQuickAccessBar(screenSize: screenSize),
                    Column(
                      children: [
                        FeaturedHeading(
                          screenSize: screenSize,
                        ),
                        FeaturedTiles(screenSize: screenSize)
                      ],
                    ),
                  ],
                )*/
              ],
            ),
            //DestinationHeading(screenSize: screenSize),
            //const DestinationCarousel(),
            SizedBox(height: screenSize.height / 10),
            const BottomBar(),
          ],
        ),
      ),
    );
  }
}

/*{
  final TrackingScrollController _trackingScrollController =
  TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
          HomeScreenSmallScreen(scrollController: _trackingScrollController),
          web:
          HomeScreenBigScreen(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}*/


