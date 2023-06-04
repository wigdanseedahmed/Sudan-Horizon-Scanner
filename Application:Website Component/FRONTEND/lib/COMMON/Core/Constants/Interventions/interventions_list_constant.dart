import 'package:sudan_horizon_scanner/imports.dart';

///USED FOR CAROSUEL IN AREA OF INTERVENTION SCREEN
List<String> typeOfIntervention = [
  'RULE OF LAW AND\nCONSTITUTIONAL BUILDING',
  'DEMOCRATIC TRANSITION\nAND ECONOMIC RECOVERY',
  'ENERGY AND ENVIRONMENT',
  'HEALTH AND DEVELOPMENT',
  'PEACE AND STABILIZATION',
  'INNOVATION AND\nDIGITIZATION',
];

List<String> interventionImage = [
  'assets/images/rule_of_law.jpg',
  'assets/images/democratic_transition_and_economic_recovery.jpg',
  'assets/images/energy_and_environment.jpg',
  'assets/images/health_and_development.jpg',
  'assets/images/peace_and_stabilization.jpg',
  'assets/images/innovation_and_digitization.jpg',
];

///USED FOR FILTERING THROUGH PROJECTS IN EACH TYPE OF INTERVENTION SCREEN
var typeOfInterventionList = [
  'All',
  "Rule of Law and Constitutional Building",
  "Democratic Transition and Economic Recovery",
  "Energy and Environment",
  "Health and Development",
  "Peace and Stabilization",
  "Innovation and Digitization",
];

var levelOfInterventionList = [
  "Most targeted intervention type",
  "Least targeted intervention type",
  "Intervention type not targeted",
];

List<Color> typeOfInterventionColour = [
  const Color(0xFF00689D),
  const Color(0xFFE5243B),
  const Color(0xFFFCC30B),
  const Color(0xFF4C9F38),
  const Color(0xFF00689D),
  const Color(0xFFFD6925),
];

List<MapColorMapper>? interventionsMapColourMapper = [
   MapColorMapper(
    value: "R_C",
    color:  typeOfInterventionColour[0],
    text: "Rule of Law and Constitutional Building",
  ),
   MapColorMapper(
    color:  typeOfInterventionColour[1],
    value: "D_E",
    text: "Democratic Transition and Economic Recovery",
  ),
  MapColorMapper(
    color: typeOfInterventionColour[2],
    value: "E_E",
    text: "Energy and Environment",
  ),
   MapColorMapper(
    color: typeOfInterventionColour[3],
    value: "H_D",
    text: "Health and Development",
  ),
   MapColorMapper(
    color: typeOfInterventionColour[4],
    value: "P_S",
    text: "Peace and Stabilization",
  ),
   MapColorMapper(
    color: typeOfInterventionColour[5],
    value: "I_D",
    text: "Innovation and Digitization",
  ),
  const MapColorMapper(
    color: Colors.grey,
    value: "",
    text: "No Projects",
  ),
];
