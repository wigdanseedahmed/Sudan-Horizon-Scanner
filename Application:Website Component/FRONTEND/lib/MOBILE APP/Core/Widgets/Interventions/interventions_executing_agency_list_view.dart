import 'package:sudan_horizon_scanner/imports.dart';

class ExecutingAgencyListViewMA extends StatelessWidget {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  final InterventionsProjectModel selectedProject;
  final String interventionScreen;

  ///VARIABLES USED TO NAVIGATE TO DONOR SCREEN
  final Function()? onTap;

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  final Size screenSize;

  const ExecutingAgencyListViewMA({
    Key? key,
    required this.selectedProject,
    this.onTap,
    required this.screenSize,
    required this.interventionScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: selectedProject.executingAgency!.length,
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return ExecutingAgencyCard(
          screenSize: screenSize,
          selectedProject: selectedProject,
          index: index,
          interventionScreen: interventionScreen,
        );
      },
    );
  }
}
