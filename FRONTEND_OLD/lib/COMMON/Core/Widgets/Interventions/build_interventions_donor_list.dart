import 'package:sudan_horizon_scanner/imports.dart';

class BuildInterventionsDonorList extends StatelessWidget {
  final InterventionsProjectModel selectedProject;
  final String selectedProjectName;
  final Size screenSize;
  final String interventionScreen;

  const BuildInterventionsDonorList({
    Key? key,
    required this.selectedProject,
    required this.selectedProjectName,
    required this.screenSize, required this.interventionScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return (selectedProject.isNull)
        ? const Text(
            "There are no current donors found!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          )
        : ResponsiveWidget.isSmallScreen(context)
            ? DonorListViewMA(selectedProject: selectedProject, screenSize: screenSize, interventionScreen: interventionScreen)
            : DonorListViewWS(selectedProject: selectedProject, screenSize: screenSize, interventionScreen: interventionScreen);
  }
}
