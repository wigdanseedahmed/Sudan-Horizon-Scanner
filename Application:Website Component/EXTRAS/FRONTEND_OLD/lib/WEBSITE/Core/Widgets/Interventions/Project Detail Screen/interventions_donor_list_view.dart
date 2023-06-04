import 'package:sudan_horizon_scanner/imports.dart';

class DonorListViewWS extends StatelessWidget {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  final InterventionsProjectModel selectedProject;

  ///VARIABLES USED TO NAVIGATE TO DONOR SCREEN
  final Function()? onTap;

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  final Size screenSize;

  final String interventionScreen;

  const DonorListViewWS({
    Key? key,
    required this.selectedProject,
    this.onTap,
    required this.screenSize, required this.interventionScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: selectedProject.donor!.length,
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height * 0.75),
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LargeScreenInterventionsDonorDetailScreen(
                  selectedDonor: selectedProject.donor![index],
                  interventionScreen: interventionScreen,
                ),
              ),
            );
          },
          child: DonorCard(
            screenSize: screenSize,
            selectedProject: selectedProject,
            index: index,
              interventionScreen: interventionScreen,
          ),
        );
      },
    );
  }
}
