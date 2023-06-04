import 'package:sudan_horizon_scanner/imports.dart';

class BuildInterventionsProjectList extends StatelessWidget {
  final List<InterventionsProjectModel> allProjects;
  final String theme;
  final String status;
  final Size screenSize;

  const BuildInterventionsProjectList({
    Key? key,
    required this.allProjects,
    required this.theme,
    required this.status,
    required this.screenSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _projectFilter = allProjects
        .where((element) => element.theme!.contains(theme) && element.status == status)
        .toList();
    // print("Theme: $theme");
    // print("Status: $status");
    // print("ALL  PROJECTS: $allProjects");
    // print("PROJECTS FILTER: $_projectFilter");
    return (_projectFilter.isEmpty)
        ? const Text(
            "There are no projects found!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          )
        : ResponsiveWidget.isSmallScreen(context)
            ? ProjectListViewMA(projectFilter: _projectFilter, screenSize: screenSize, interventionScreen: theme)
            : ProjectListViewWS(projectFilter: _projectFilter, screenSize: screenSize, interventionScreen: theme);
  }
}
