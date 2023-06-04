import 'package:sudan_horizon_scanner/imports.dart';

class PoliticalTimelineScreen extends StatefulWidget {
  static const String route = '/';

  const PoliticalTimelineScreen({Key? key}) : super(key: key);

  @override
  _PoliticalTimelineScreenState createState() => _PoliticalTimelineScreenState();
}

class _PoliticalTimelineScreenState extends State<PoliticalTimelineScreen> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
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
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.5,
                    width: screenSize.width,
                    child: Image.asset(
                      'assets/images/elections_cover.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  PoliticalMapFloatingQuickAccessBar(screenSize: screenSize),
                ],
              ),
              //DestinationHeading(screenSize: screenSize),
              //const DestinationCarousel(),
              SizedBox(height: screenSize.height / 10),
              const BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
