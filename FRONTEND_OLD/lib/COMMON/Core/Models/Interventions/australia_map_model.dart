import 'package:sudan_horizon_scanner/imports.dart';

/// Collection of Australia state code data.
class AustraliaMapModel {
  /// Initialize the instance of the [AustraliaMapModel] class.
  const AustraliaMapModel(this.state, this.color, this.stateCode);

  /// Represents the Australia state name.
  final String state;

  /// Represents the Australia state color.
  final Color color;

  /// Represents the Australia state code.
  final String stateCode;
}

class AustraliaCountryDensityModel {
  AustraliaCountryDensityModel(this.countryName, this.density);

  final String countryName;
  final double density;
}