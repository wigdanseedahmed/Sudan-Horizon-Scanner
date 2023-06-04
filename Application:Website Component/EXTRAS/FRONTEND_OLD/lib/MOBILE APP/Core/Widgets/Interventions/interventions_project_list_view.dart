import 'package:sudan_horizon_scanner/imports.dart';

class ProjectListViewMA extends StatelessWidget {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  final List<InterventionsProjectModel> projectFilter;
  final String interventionScreen;

  ///VARIABLES USED TO NAVIGATE TO DONOR SCREEN
  final Function()? onTap;

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  final Size screenSize;

  const ProjectListViewMA({Key? key, required this.projectFilter, this.onTap, required this.screenSize, required this.interventionScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projectFilter.length,
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              print( projectFilter[index].projectName);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InterventionsProjectDetailScreenWS(
                    projectInformation: projectFilter[index],
                    interventionScreen: interventionScreen,
                  ),
                ),
              );
            },
            child: ProjectDetailCardWS(
              screenSize: screenSize,
              index: index,
              projectFilter: projectFilter, interventionScreen: interventionScreen,
            ),
          ),
        );
      },
    );
  }
}