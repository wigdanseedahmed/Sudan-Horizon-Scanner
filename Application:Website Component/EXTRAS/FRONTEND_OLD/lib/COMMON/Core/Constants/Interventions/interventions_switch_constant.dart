import 'package:sudan_horizon_scanner/imports.dart';

void switchTypeOfInterventionToAb(
    {required String initialTypeOfIntervention, String? selectedTypeOfIntervention}) {

  switch (initialTypeOfIntervention) {
    case "Rule of Law and Constitutional Building":
      {
        selectedTypeOfIntervention = "R_C";
      }
      break;
    case "Democratic Transition and Economic Recovery":
      {
        selectedTypeOfIntervention = "D_E";
      }
      break;
    case "Energy and Environment":
      {
        selectedTypeOfIntervention = "E_E";
      }
      break;
    case "Health and Development":
      {
        selectedTypeOfIntervention = "H_D";
      }
      break;
    case "Peace and Stabilization":
      {
        selectedTypeOfIntervention = "P_S";
      }
      break;
    case "Innovation and Digitization":
      {
        selectedTypeOfIntervention = "I_D";
      }
      break;

    default:
      {
        selectedTypeOfIntervention = null;
      }
      break;
  }

}

void switchTypeOfInterventionFromAb(
    {required String typeOfInterventionAbb, String? typeOfIntervention}) {

  switch (typeOfInterventionAbb) {
    case "R_C":
      {
        typeOfIntervention = "Rule of Law and Constitutional Building";
      }
      break;
    case "D_E":
      {
        typeOfIntervention = "Democratic Transition and Economic Recovery";
      }
      break;
    case "E_E":
      {
        typeOfIntervention = "Energy and Environment";
      }
      break;
    case "H_D":
      {
        typeOfIntervention = "Health and Development";
      }
      break;
    case "P_S":
      {
        typeOfIntervention = "Peace and Stabilization";
      }
      break;
    case "I_D":
      {
        typeOfIntervention = "Innovation and Digitization";
      }
      break;

    default:
      {
        typeOfIntervention = null;
      }
      break;
  }

}