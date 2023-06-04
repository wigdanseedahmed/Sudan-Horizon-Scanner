import 'package:sudan_horizon_scanner/imports.dart';

class DonorCard extends StatelessWidget {
  const DonorCard({Key? key, required this.selectedProject, required this.index, required this.screenSize, required this.interventionScreen,}) : super(key: key);

  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  final InterventionsProjectModel selectedProject;
  final String interventionScreen;
  final int index;

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width / 5,
      height: 40,
      child: Card(
        semanticContainer: true,
        //color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: screenSize.height / 300,
            right: screenSize.width / 300,
            bottom: screenSize.height / 300,
            left: screenSize.width / 300,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: screenSize.width / 10,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: selectedProject
                      .donor![index]
                      .donorPhotoUrl == null ?
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(8.0)),
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
                    ),
                  )
                      : ClipRRect(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8.0)),
                    child: Hero(
                      tag: selectedProject.id!,
                      child: FadeInImage(
                        image: NetworkImage(selectedProject
                            .donor![index]
                            .donorPhotoUrl!),
                        fit: BoxFit.cover,
                        placeholder:
                        const AssetImage('assets/images/loading.gif'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenSize.width / 50),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height / 40),
                child: SizedBox(
                  width: screenSize.width / 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        selectedProject.donor![index].donorName!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          //color: Theme.of(context).primaryColor,
                          fontSize: screenSize.width / 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        thickness: screenSize.height / 400,
                        color: Colors.grey,
                      ),
                      SizedBox(height: screenSize.height / 90),
                      SizedBox(
                        height: screenSize.height / 30,
                        child: Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                              size: screenSize.width / 75,
                            ),
                            SizedBox(width: screenSize.width / 250),
                            Text(
                              selectedProject
                                  .donor![index]
                                  .donorEmail!,
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
                        height: screenSize.height / 30,
                        child: Row(
                          children: [
                            Icon(
                              Icons.web_outlined,
                              color: Colors.grey,
                              size: screenSize.width / 75,
                            ),
                            SizedBox(width: screenSize.width / 250),
                            Text(
                              selectedProject
                                  .donor![index]
                                  .donorWebsite!,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
