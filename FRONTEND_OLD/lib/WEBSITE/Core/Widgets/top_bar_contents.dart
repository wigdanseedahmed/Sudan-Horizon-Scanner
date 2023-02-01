import 'package:sudan_horizon_scanner/imports.dart';


class TopBarContentsWS extends StatefulWidget {
  final double opacity;

  const TopBarContentsWS(this.opacity, {Key? key}) : super(key: key);

  @override
  _TopBarContentsWSState createState() =>
      _TopBarContentsWSState();
}

class _TopBarContentsWSState extends State<TopBarContentsWS> {
  void changeBrightness() {
    DynamicTheme.of(context)!.setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  //bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color:
            Theme.of(context).bottomAppBarColor, //.withOpacity(widget.opacity),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                'Sudan Horizon Scanner',
                style: TextStyle(
                  fontSize: screenSize.width / 75,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: screenSize.width / 30),
                      /*InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[0] = true
                                : _isHovering[0] = false;
                          });
                        },
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => const DigitalAvatarScreen(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          Text(
                          'Digital Avatar',
                          style: TextStyle(
                            fontSize: screenSize.width / 100,
                          ),
                        ),
                            const SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[0],
                              child: Container(
                                height: 2,
                                width: screenSize.width / 15,
                                color: primaryColour,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width / 75),*/
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[1] = true
                                : _isHovering[1] = false;
                          });
                        },
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => const InterventionsScreenWS(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Interventions',
                                  style: TextStyle(
                                    fontSize: screenSize.width / 100,
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
                                      PopupMenuItem(
                                        child: Text(
                                          'Rules of Law and Constitutional Building',
                                          style: TextStyle(
                                              fontSize: screenSize.width / 125),
                                        ),
                                        value:
                                            'Rules of Law and Constitutional Building',
                                      ),
                                    );
                                    list.add(
                                      PopupMenuItem(
                                        child: Text(
                                          'Democratic Transition and Economic Recovery',
                                          style: TextStyle(
                                              fontSize: screenSize.width / 125),
                                        ),
                                        value:
                                            'Democratic Transition and Economic Recovery',
                                      ),
                                    );
                                    list.add(
                                      PopupMenuItem(
                                        child: Text(
                                          'Energy and Environment',
                                          style: TextStyle(
                                              fontSize: screenSize.width / 125),
                                        ),
                                        value: 'Energy and Environment',
                                      ),
                                    );
                                    list.add(
                                      PopupMenuItem(
                                        child: Text(
                                          'Health and Development',
                                          style: TextStyle(
                                              fontSize: screenSize.width / 125),
                                        ),
                                        value: 'Health and Development',
                                      ),
                                    );
                                    list.add(
                                      PopupMenuItem(
                                        child: Text(
                                          'Peace and Stabilization',
                                          style: TextStyle(
                                              fontSize: screenSize.width / 125),
                                        ),
                                        value: 'Peace and Stabilization',
                                      ),
                                    );
                                    list.add(
                                      PopupMenuItem(
                                        child: Text(
                                          'Innovation and Digitization',
                                          style: TextStyle(
                                              fontSize: screenSize.width / 125),
                                        ),
                                        value: 'Innovation and Digitization',
                                      ),
                                    );
                                    return list;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[1],
                              child: Container(
                                height: 2,
                                width: screenSize.width / 11,
                                color: primaryColour,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width / 75),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[2] = true
                                : _isHovering[2] = false;
                          });
                        },
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => const ProgrammaticSimulationHomeScreenWS(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Programmatic Simulation',
                              style: TextStyle(
                                fontSize: screenSize.width / 100,
                                /*color: _isHovering[4]
                                    ? primaryColour
                                    : DynamicTheme
                                    .of(context)
                                    ?.brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,*/
                              ),
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[2],
                              child: Container(
                                height: 2,
                                width: screenSize.width / 8,
                                color: primaryColour,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width / 75),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[3] = true
                                : _isHovering[3] = false;
                          });
                        },
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => const EmergenceIssueOfTheMonthScreenWS(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Emergence Issue of the Month',
                              style: TextStyle(
                                fontSize: screenSize.width / 100,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[3],
                              child: Container(
                                height: 2,
                                width: screenSize.width / 7,
                                color: primaryColour,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width / 75),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[4] = true
                                : _isHovering[4] = false;
                          });
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PoliticalTimelineScreen(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Political Mapping',
                                  style: TextStyle(
                                    fontSize: screenSize.width / 100,
                                  ),
                                ),
                                PopupMenuButton(
                                  offset: const Offset(0, 35),
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
                                    }else if (result ==
                                        'Political Dynamic Map') {
                                      toast('Coming Soon');
                                    }else if (result ==
                                        'Prediction Scenarios') {
                                      toast('Coming Soon');
                                    }
                                  },
                                  itemBuilder: (context) {
                                    List<PopupMenuEntry<Object>> list = [];
                                    list.add(
                                      PopupMenuItem(
                                        child: Text(
                                          'Political Mapping',
                                          style: TextStyle(
                                              fontSize: screenSize.width / 125),
                                        ),
                                        value: 'Political Mapping',
                                      ),
                                    );
                                    list.add(
                                      PopupMenuItem(
                                        child: Text(
                                          'Political Dynamic Map',
                                          style: TextStyle(
                                              fontSize: screenSize.width / 125),
                                        ),
                                        value: 'Political Dynamic Map',
                                      ),
                                    );
                                    list.add(
                                      PopupMenuItem(
                                        child: Text(
                                          'Prediction Scenarios',
                                          style: TextStyle(
                                              fontSize: screenSize.width / 125),
                                        ),
                                        value: 'Prediction Scenarios',
                                      ),
                                    );
                                    return list;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[4],
                              child: Container(
                                height: 2,
                                width: screenSize.width / 10,
                                color: primaryColour,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //TODO: delete
              IconButton(
                icon: const Icon(Icons.brightness_6),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: primaryColour,
                onPressed: changeBrightness,
              ),
              SizedBox(
                width: screenSize.width / 200,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 5.0),
                child: InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[6] = true : _isHovering[6] = false;
                    });
                  },
                  onTap: () {},
                  /*userEmail == null
                      ? () {
                          showDialog(
                            context: context,
                            builder: (context) => AuthDialog(),
                          );
                        }
                      : null,*/
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Sign in', /*
                        style: TextStyle(
                          color: _isHovering[5] ? Colors.white : Colors.white70,
                        ),*/
                      ),
                      const SizedBox(height: 5),
                      Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        maintainSize: true,
                        visible: _isHovering[6],
                        child: Container(
                          height: 2,
                          width: 43,
                          color: primaryColour,
                        ),
                      ),
                    ],
                  ) /*userEmail == null
                      ? Text(
                          'Sign in',
                          style: TextStyle(
                            color: _isHovering[3] ? Colors.white : Colors.white70,
                          ),
                        )
                      : Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: imageUrl != null
                                  ? NetworkImage(imageUrl!)
                                  : null,
                              child: imageUrl == null
                                  ? const Icon(
                                      Icons.account_circle,
                                      size: 30,
                                    )
                                  : Container(),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              name ?? userEmail!,
                              style: TextStyle(
                                color: _isHovering[3]
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.blueGrey,
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
                                      await signOut().then((result) {
                                        print(result);
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            fullscreenDialog: true,
                                            builder: (context) => HomePage(),
                                          ),
                                        );
                                      }).catchError((error) {
                                        print('Sign Out Error: $error');
                                      });
                                      setState(() {
                                        _isProcessing = false;
                                      });
                                    },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: _isProcessing
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Sign out',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            )
                          ],
                        )*/
                  ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
