import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class NationalCoverageMap extends StatefulWidget {
  const NationalCoverageMap({Key? key, required this.screenSize, this.colour})
      : super(key: key);

  final Size screenSize;
  final Color? colour;

  @override
  _NationalCoverageMapState createState() => _NationalCoverageMapState();
}

class _NationalCoverageMapState extends State<NationalCoverageMap> {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH MAP DATA FROM BACKEND

  late MapZoomPanBehavior _zoomPanBehavior;

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
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


    ///VARIABLES USED FORT MAP LOCATION
    _zoomPanBehavior = MapZoomPanBehavior(enablePanning: false, enablePinching: false);

    super.initState();
  }

  //TODO: https://stackoverflow.com/questions/70805382/shape-sublayer-on-zoom-syncfusion-map-flutter
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenSize.height * 0.94,
      width: widget.screenSize.width * 0.7,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.grey.shade50
            : Colors.white10,
      ),
      child: Center(
        child: SfMaps(
          layers: <MapShapeLayer>[
            MapShapeLayer(
              source: const MapShapeSource.asset(
                'jsonDataFiles/sudan_2021.json',
                shapeDataField: 'name',

              ),
              color: widget.colour,
              zoomPanBehavior: _zoomPanBehavior,

              showDataLabels: true,

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
                  fontSize: widget.screenSize.width / 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
