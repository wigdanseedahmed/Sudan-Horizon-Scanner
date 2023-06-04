import 'package:sudan_horizon_scanner/imports.dart';

class BuildInterventionsExecutingAgencyList extends StatelessWidget {
  final InterventionsProjectModel selectedProject;
  final String selectedProjectName;
  final Size screenSize;
  final String interventionScreen;

  const BuildInterventionsExecutingAgencyList({
    Key? key,
    required this.selectedProject,
    required this.selectedProjectName,
    required this.screenSize,
    required this.interventionScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return (selectedProject.isNull)
        ? const Text(
            "There are no current executing agencies found!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          )
        : ResponsiveWidget.isSmallScreen(context)
            ? ExecutingAgencyListViewMA(selectedProject: selectedProject, screenSize: screenSize, interventionScreen: interventionScreen)
            : ExecutingAgencyListViewWS(selectedProject: selectedProject, screenSize: screenSize, interventionScreen: interventionScreen);
  }
}
