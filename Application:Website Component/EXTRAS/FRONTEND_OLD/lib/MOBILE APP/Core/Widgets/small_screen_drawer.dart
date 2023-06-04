import 'package:sudan_horizon_scanner/imports.dart';

class SmallScreenMenuDrawer extends StatefulWidget {
  const SmallScreenMenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _SmallScreenMenuDrawerState createState() => _SmallScreenMenuDrawerState();
}

class _SmallScreenMenuDrawerState extends State<SmallScreenMenuDrawer> {
  //bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            SizedBox(
              width: double.maxFinite,
              child: TextButton(
                // color: Colors.black,
                // hoverColor: Colors.blueGrey[800],
                // highlightColor: Colors.blueGrey[700],
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(15),
                // ),
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 15.0,
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            /*userEmail == null
                ? SizedBox(
                    width: double.maxFinite,
                    child: TextButton(
                      // color: Colors.black,
                      // hoverColor: Colors.blueGrey[800],
                      // highlightColor: Colors.blueGrey[700],
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AuthDialog(),
                        );
                      },
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                          top: 15.0,
                          bottom: 15.0,
                        ),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            imageUrl != null ? NetworkImage(imageUrl!) : null,
                        child: imageUrl == null
                            ? const Icon(
                                Icons.account_circle,
                                size: 40,
                              )
                            : Container(),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        name ?? userEmail!,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      )
                    ],
                  ),
            const SizedBox(height: 20),
            userEmail != null
                ? SizedBox(
                    width: double.maxFinite,
                    child: TextButton(
                      // color: Colors.black,
                      // hoverColor: Colors.blueGrey[800],
                      // highlightColor: Colors.blueGrey[700],
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _isProcessing
                          ? null
                          : () async {
                              setState(() {
                                _isProcessing = true;
                              });
                              *//*await signOut().then((result) {
                                print(result);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              }).catchError((error) {
                                print('Sign Out Error: $error');
                              });*//*
                              setState(() {
                                _isProcessing = false;
                              });
                            },
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          bottom: 15.0,
                        ),
                        child: _isProcessing
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Sign out',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  )
                : Container(),
            userEmail != null ? const SizedBox(height: 20) : Container(),*/
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) =>
                    const InterventionsScreenWS(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Interventions',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  PopupMenuButton(
                    offset: const Offset(-190, 35),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    onSelected: (result) {
                      if (result ==
                          'Rules of Law and Constitutional Building') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const RulesOfLawAndConstitutionalBuildingScreen(),
                          ),
                        );
                      } else if (result ==
                          'Democratic Transition and Economic Recovery') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const DemocraticTransitionAndEconomicRecoveryScreen(),
                          ),
                        );
                      } else if (result ==
                          'Energy and Environment') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const EnergyAndEnvironmentScreen(),
                          ),
                        );
                      } else if (result ==
                          'Health and Development') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const HealthAndDevelopmentScreen(),
                          ),
                        );
                      } else if (result ==
                          'Peace and Stabilization') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const PeaceAndStabilizationScreen(),
                          ),
                        );
                      } else if (result ==
                          'Innovation and Digitization') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const InnovationAndDigitizationScreen(),
                          ),
                        );
                      }
                    },
                    itemBuilder: (context) {
                      List<PopupMenuEntry<Object>> list = [];
                      list.add(
                        const PopupMenuItem(
                          child: Text(
                            'Rules of Law and Constitutional Building',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value:
                          'Rules of Law and Constitutional Building',
                        ),
                      );
                      list.add(
                        const PopupMenuItem(
                          child: Text(
                            'Democratic Transition and Economic Recovery',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value:
                          'Democratic Transition and Economic Recovery',
                        ),
                      );
                      list.add(
                        const PopupMenuItem(
                          child: Text(
                            'Energy and Environment',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value: 'Energy and Environment',
                        ),
                      );
                      list.add(
                        const PopupMenuItem(
                          child: Text(
                            'Health and Development',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value: 'Health and Development',
                        ),
                      );
                      list.add(
                        const PopupMenuItem(
                          child: Text(
                            'Peace and Stabilization',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value: 'Peace and Stabilization',
                        ),
                      );
                      list.add(
                        const PopupMenuItem(
                          child: Text(
                            'Innovation and Digitization',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value: 'Innovation and Digitization',
                        ),
                      );
                      return list;
                    },
                  ),
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Divider(
                color: primaryColour,
                thickness: 2,
              ),
            ),
            InkWell(
              onTap: () {
                toast('Coming Soon');
              },
              child: const Text(
                'Programmatic Simulation',
                style: TextStyle(fontSize: 18),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Divider(
                color: primaryColour,
                thickness: 2,
              ),
            ),
            InkWell(
              onTap: () {
                toast('Coming Soon');
              },
              child: const Text(
                'Emergence Issue of The Month',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Divider(
                color: primaryColour,
                thickness: 2,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const PoliticalTimelineScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Political Mapping',
                    style: TextStyle(fontSize: 18),
                  ),
                  PopupMenuButton(
                    offset: const Offset(-190, 35),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    onSelected: (result) {
                      if (result == 'Political Mapping') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const PoliticalTimelineScreen(),
                          ),
                        );
                      } else if (result ==
                          'Prediction Scenarios') {
                        toast('Coming Soon');
                      }
                    },
                    itemBuilder: (context) {
                      List<PopupMenuEntry<Object>> list = [];
                      list.add(
                        const PopupMenuItem(
                          child: Text(
                            'Political Mapping',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value:
                          'Political Mapping',
                        ),
                      );
                      list.add(
                        const PopupMenuItem(
                          child: Text(
                            'Prediction Scenarios',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value:
                          'Prediction Scenarios',
                        ),
                      );
                      return list;
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Copyright © 2022 | UNDP Accelerator Lab',
                  style: TextStyle(
                    color: Colors.blueGrey[300],
                    fontSize: 14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
