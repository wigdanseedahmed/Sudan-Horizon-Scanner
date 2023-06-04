import 'package:sudan_horizon_scanner/imports.dart';

class ProjectLocationMap extends StatelessWidget {
  const ProjectLocationMap({
    Key? key,
    required this.context,
    required this.latitude,
    required this.longitude,
    required this.animation,
    required this.zoomPanBehavior,
    required this.screenSize,
  }) : super(key: key);

  final BuildContext context;
  final double latitude;
  final double longitude;
  final CurvedAnimation animation;
  final MapZoomPanBehavior zoomPanBehavior;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSize.height * 0.3,
      width: screenSize.width * 0.2,
      child: Center(
        child: SfMaps(
          layers: [
            MapTileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              initialZoomLevel: 5,
            zoomPanBehavior: zoomPanBehavior,
              initialFocalLatLng: MapLatLng(latitude, longitude),
              initialMarkersCount: 1,
              markerBuilder: (BuildContext context, int index) {
                const Icon current = Icon(Icons.location_pin, size: 40.0);
                return MapMarker(
                  latitude: latitude, //markerData.latitude,
                  longitude: longitude,//markerData.longitude,
                  child: Transform.translate(
                    offset: const Offset(0.0, -40 / 2),
                    child: ScaleTransition(
                      alignment: Alignment.bottomCenter,
                      scale: animation,
                      child: current,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
