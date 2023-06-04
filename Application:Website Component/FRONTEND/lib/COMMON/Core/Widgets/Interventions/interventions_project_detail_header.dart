import 'package:sudan_horizon_scanner/imports.dart';

class InterventionsProjectDetailHeader extends StatelessWidget {
  const InterventionsProjectDetailHeader({
    Key? key,
    required this.screenSize, required this.headerTitle,
  }) : super(key: key);

  final Size screenSize;
  final String headerTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSize.height / 25,
      width: screenSize.width,
      child: Text(
        headerTitle,
        textAlign: TextAlign.left,
        style: TextStyle(
          //letterSpacing: 8,
          fontFamily: 'Electrolize',
          fontSize: screenSize.width / 60,
          color: Colors.grey,
        ),
      ),
    );
  }
}