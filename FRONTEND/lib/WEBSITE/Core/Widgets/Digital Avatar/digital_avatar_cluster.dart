import 'package:sudan_horizon_scanner/imports.dart';

class DigitalAvatarCluster extends StatelessWidget {
  const DigitalAvatarCluster({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.54,
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
                'Cluster',
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
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Population',
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
                      'Economic',
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
          SizedBox(height: screenSize.height / 63),
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
                      'Poverty',
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
                      'Environment',
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
          SizedBox(height: screenSize.height / 63),
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
                      'Gender',
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
                      'Agriculture',
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
          SizedBox(height: screenSize.height / 63),
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
                      'Food Security\nand Nutrition',
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
                      'Infrastructure',
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
