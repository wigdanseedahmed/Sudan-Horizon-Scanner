import 'package:sudan_horizon_scanner/imports.dart';

class InterventionsMapWidget extends StatelessWidget {
  const InterventionsMapWidget({
    Key? key,
    required this.readMapDataFromJsonFile,
    required this.shapeDataField,
  }) : super(key: key);

  final Future<Uint8List> readMapDataFromJsonFile;
  final String shapeDataField;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readMapDataFromJsonFile,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Uint8List bytesData = snapshot.data as Uint8List;
          return SizedBox(
            height: 600,
            child: Center(
              child: SfMaps(
                layers: [
                  MapShapeLayer(
                    showDataLabels: true,
                    dataLabelSettings: MapDataLabelSettings(
                      textStyle: TextStyle(
                        color: DynamicTheme.of(context)?.brightness ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                    /*strokeColor: Colors.white30,
                    legend: const MapLegend.bar(
                    MapElement.shape,
                    position: MapLegendPosition.bottom,
                    segmentSize: Size(55.0, 9.0),),*/
                    source: MapShapeSource.memory(
                      bytesData,
                      shapeDataField: shapeDataField,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
    /*SizedBox(
      height: 600,
      child: Center(
        child: SfMaps(
          layers: [
            MapShapeLayer(
              source: mapShapeSource,
              showDataLabels: true,
              */ /*
              strokeColor: Colors.white30,
              legend: const MapLegend.bar(
                MapElement.shape,
                position: MapLegendPosition.bottom,
                segmentSize: Size(55.0, 9.0),
              ),*/ /*
              dataLabelSettings: MapDataLabelSettings(
                textStyle: TextStyle(
                  color: DynamicTheme.of(context)?.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
