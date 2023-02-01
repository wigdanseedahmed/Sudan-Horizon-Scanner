import 'package:sudan_horizon_scanner/imports.dart';

class ProfileAvatarGeographicalCoverage extends StatelessWidget {
  const ProfileAvatarGeographicalCoverage({
    Key? key,
    required this.screenSize, required this.selectedGeographicCoverage,
  }) : super(key: key);

  final Size screenSize;
  final String selectedGeographicCoverage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.32,
      width: screenSize.width * 0.23,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey.shade50,
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(
                top: screenSize.height / 75,
                bottom: screenSize.height / 75,
              ),
              //width: screenSize.width,
              // color: Colors.black,
              child: Text(
                'Geographical Coverage',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenSize.width / 55,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    //TODO: selectedGeographicCoverage = 'National';
                  },
                  child: Container(
                    height: screenSize.height / 10,
                    width: screenSize.width / 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'National',
                        style: TextStyle(
                          fontSize: screenSize.width / 100,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width / 30),
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Sub National',
                      style: TextStyle(
                        fontSize: screenSize.width / 100,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize.height / 60),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'State',
                      style: TextStyle(
                        fontSize: screenSize.width / 100,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width / 30),
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Locality',
                      style: TextStyle(
                        fontSize: screenSize.width / 100,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
