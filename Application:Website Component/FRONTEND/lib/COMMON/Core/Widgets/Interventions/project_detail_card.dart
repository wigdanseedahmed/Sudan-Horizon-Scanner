import 'package:sudan_horizon_scanner/imports.dart';

class ProjectDetailCardWS extends StatelessWidget {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  final List<InterventionsProjectModel> projectFilter;
  final String interventionScreen;
  final int index;

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  final Size screenSize;

  const ProjectDetailCardWS({
    Key? key,
    required this.projectFilter,
    required this.screenSize,
    required this.index,
    required this.interventionScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width,
            height: screenSize.height / 4.5,
            color: interventionScreen == "R_C"
                ? typeOfInterventionColour[0]
                : interventionScreen == "D_E"
                    ? typeOfInterventionColour[1]
                    : interventionScreen == "E_E"
                        ? typeOfInterventionColour[2]
                        : interventionScreen == "H_D"
                            ? typeOfInterventionColour[3]
                            : interventionScreen == "P_S"
                                ? typeOfInterventionColour[4]
                                : typeOfInterventionColour[5],
            child: projectFilter[index].photoUrl == null
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        projectFilter[index].projectName!,
                        textAlign: TextAlign.center,
                        style: TextStyle(

                          letterSpacing: 3,
                          fontFamily: 'Electrolize',
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.width * 0.02,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Hero(
                      tag: projectFilter[index].id!,
                      child: FadeInImage(
                        image: NetworkImage(projectFilter[index].photoUrl!),
                        fit: BoxFit.fill,
                        placeholder:
                            const AssetImage('assets/images/loading.gif'),
                      ),
                    ),
                  ),
          ),
          SizedBox(height: screenSize.height / 250),
          SizedBox(
            width: screenSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  projectFilter[index].projectName!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    //color: Theme.of(context).primaryColor,
                    fontSize: screenSize.width / 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListView.builder(
                    itemCount: projectFilter[index].executingAgency!.length,
                    padding: const EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    //physics: const ClampingScrollPhysics(),
                    //scrollDirection: Axis.horizontal,
                    itemBuilder:
                        (BuildContext context, int executingAgencyIndex) {
                      return Center(
                        child: RichText(
                          text: TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            //maxLines: 10,
                            style: TextStyle(
                              //color: Theme.of(context).primaryColor,
                              fontSize: screenSize.width / 85,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: projectFilter[index]
                                    .executingAgency![executingAgencyIndex]
                                    .executingAgencyName!,
                                style: TextStyle(
                                  fontSize: screenSize.width / 85,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  width: screenSize.width / 4,
                  child: Divider(
                    thickness: screenSize.height / 400,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 5,
                  height: screenSize.height / 20,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.grey,
                        size: screenSize.width / 85,
                      ),
                      SizedBox(width: screenSize.width / 250),
                      Text(
                        "${projectFilter[index].localityNameEn!}, ${projectFilter[index].stateNameEn!}, ${projectFilter[index].countryEn!}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          //letterSpacing: 8,
                          fontFamily: 'Electrolize',
                          fontSize: screenSize.width / 100,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 5,
                  height: screenSize.height / 30,
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: Colors.grey,
                        size: screenSize.width / 85,
                      ),
                      SizedBox(width: screenSize.width / 250),
                      Text(
                        "${DateFormat("EEE, MMM d, yyyy").format(projectFilter[index].startDate!)} - ${DateFormat("EEE, MMM d, yyyy").format(projectFilter[index].endDate!)}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          //letterSpacing: 8,
                          fontFamily: 'Electrolize',
                          fontSize: screenSize.width / 100,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
