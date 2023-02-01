import 'package:sudan_horizon_scanner/imports.dart';

class TypeOfInterventionHeading extends StatelessWidget {
  const TypeOfInterventionHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Container(
            padding: EdgeInsets.only(
              top: screenSize.height / 20,
              bottom: screenSize.height / 20,
            ),
            width: screenSize.width,
            // color: Colors.black,
            child: const Text(
              'Types of Intervention',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.only(
              top: screenSize.height / 10,
              bottom: screenSize.height / 15,
            ),
            width: screenSize.width,
            // color: Colors.black,
            child: const Text(
              'Types of Intervention',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}

class InterventionsHeading extends StatelessWidget {
  const InterventionsHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Container(
            padding: EdgeInsets.only(
              top: screenSize.height / 20,
              bottom: screenSize.height / 20,
            ),
            width: screenSize.width,
            // color: Colors.black,
            child: const Text(
              'Interventions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.only(
              top: screenSize.height / 10,
              bottom: screenSize.height / 15,
            ),
            width: screenSize.width,
            // color: Colors.black,
            child: const Text(
              'Interventions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}

class StatusProjectHeading extends StatelessWidget {
  const StatusProjectHeading({
    Key? key,
    required this.screenSize,
    required this.text,
  }) : super(key: key);

  final Size screenSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Container(
          padding: EdgeInsets.only(
            top: screenSize.height / 20,
            bottom: screenSize.height / 20,
          ),
          //width: screenSize.width,
          // color: Colors.black,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontSize: screenSize.width / 50,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        )
        : Container(
          padding: EdgeInsets.only(
            top: screenSize.height / 15,
            bottom: screenSize.height / 15,
          ),
          //width: screenSize.width,
          // color: Colors.black,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize:
              screenSize.width * 0.02,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
        );
  }
}
