import 'package:sudan_horizon_scanner/imports.dart';

MapMarker buildAllProjectsLocationMarkers({
  required BuildContext context,
  required int index,
  required int prevSelectedMarkerIndex,
  required int selectedMarkerIndex,
  required double latitude,
  required double longitude,
  required MapTileLayerController tileLayerController,
  required InterventionsProjectModel selectedProject,
  required String interventionScreen,
}) {
  final double size = selectedMarkerIndex == index ? 40 : 25;
  const Icon current = Icon(Icons.location_pin);
  return MapMarker(
    latitude: latitude,
    longitude: longitude,
    child: GestureDetector(
      onTap: () {
        prevSelectedMarkerIndex = selectedMarkerIndex;
        selectedMarkerIndex = index;
        tileLayerController.updateMarkers([
          if (prevSelectedMarkerIndex != -1) prevSelectedMarkerIndex,
          selectedMarkerIndex
        ]);
      },
      onDoubleTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => InterventionsProjectDetailScreenWS(
              projectInformation: selectedProject,
interventionScreen: interventionScreen,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        transform: Matrix4.identity()..translate(0.0, -size / 2),
        duration: const Duration(milliseconds: 250),
        height: size,
        width: size,
        child: const FittedBox(child: current),
      ),
    ),
  );
}
