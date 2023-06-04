import 'package:sudan_horizon_scanner/imports.dart';

class InterventionsMapLocationModel {
  InterventionsMapLocationModel({
    this.lat,
    this.lng,
    this.bearing,
    this.tilt,
    this.zoom,
    this.area,
  });

  double? lat;
  double? lng;
  double? shape;
  double? area;
  double? bearing;
  double? tilt;
  double? zoom;

  factory InterventionsMapLocationModel.fromJson(Map<String, dynamic> json) => InterventionsMapLocationModel(
    lat: json["Lat"].toDouble(),
    lng: json["Lng"].toDouble(),
    bearing: json["bearing"].toDouble(),
    tilt: json["tilt"].toDouble(),
    zoom: json["zoom"].toDouble(),
    area: json["area"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Lat": lat,
    "Lng": lng,
    "bearing": bearing,
    "tilt": tilt,
    "zoom": zoom,
    "area": area,
  };

  factory InterventionsMapLocationModel.fromMap(Map<String, dynamic> json) => InterventionsMapLocationModel(
    lat: json["Lat"].toDouble(),
    lng: json["Lng"].toDouble(),
    bearing: json["bearing"].toDouble(),
    tilt: json["tilt"].toDouble(),
    zoom: json["zoom"].toDouble(),
    area: json["area"],
  );

  Map<String, dynamic> toMap() => {
    "Lat": lat,
    "Lng": lng,
    "bearing": bearing,
    "tilt": tilt,
    "zoom": zoom,
    "area": area,
  };
}

class RegionMapModel {
  /// Initialize the instance of the [RegionMapModel] class.
  const RegionMapModel(this.region, this.color, this.regionCode,);

  /// Represents the Project region name.
  final String region;

  /// Represents the Project region color.
  final Color color;

  /// Represents the Project region code.
  final String regionCode;
}

class StateMapModel {
  /// Initialize the instance of the [StateMapModel] class.
  const StateMapModel(this.state, this.color, this.stateCode,);

  /// Represents the Project state name.
  final String state;

  /// Represents the Project state color.
  final Color color;

  /// Represents the Project state code.
  final String stateCode;
}

class CityMapModel {
  /// Initialize the instance of the [CityMapModel] class.
  const CityMapModel(this.city, this.color, this.cityCode,);

  /// Represents the Project city name.
  final String city;

  /// Represents the Project city color.
  final Color color;

  /// Represents the Project city code.
  final String cityCode;
}

class LocalityMapModel {
  /// Initialize the instance of the [LocalityMapModel] class.
  const LocalityMapModel(this.locality, this.color, this.localityCode,);

  /// Represents the Project locality name.
  final String locality;

  /// Represents the Project locality color.
  final Color color;

  /// Represents the Project locality code.
  final String localityCode;
}