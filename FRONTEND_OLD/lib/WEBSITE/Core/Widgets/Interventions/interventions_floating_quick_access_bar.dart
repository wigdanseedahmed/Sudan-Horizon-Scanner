import 'package:sudan_horizon_scanner/imports.dart';

class InterventionsFloatingQuickAccessBar extends StatefulWidget {
  const InterventionsFloatingQuickAccessBar({
    Key? key,
    required this.screenSize,
    this.onTap,
  }) : super(key: key);

  final Size screenSize;
  final Function()? onTap;

  @override
  _InterventionsFloatingQuickAccessBarState createState() =>
      _InterventionsFloatingQuickAccessBarState();
}

class _InterventionsFloatingQuickAccessBarState
    extends State<InterventionsFloatingQuickAccessBar> {
  final List _isHovering = [false, false, false];
  List<Widget> rowElements = [];

  List<String> items = ['Locality', 'State'];
  List<IconData> icons = [
    Icons.location_on,
    Icons.location_on,
    Icons.location_on,
    Icons.location_on,
    Icons.developer_board
  ];

  List<Widget> generateRowElements() {
    var screenSize = MediaQuery.of(context).size;
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      Widget elementTile = InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (value) {
          setState(() {
            value ? _isHovering[i] = true : _isHovering[i] = false;
          });
        },
        onTap: () {
          selectedItem = items[i];
        },
        child: Text(
          items[i],
          style: TextStyle(
            color: _isHovering[i]
                ? primaryColour
                : DynamicTheme.of(context)?.brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
        ),
      );
      Widget spacer = SizedBox(
        height: screenSize.height / 20,
        child: VerticalDivider(
          width: 1,
          color: primaryColour,
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }

    return rowElements;
  }

  ///VARIABLES USED TO MAP TO BE DISPLAYED
  late String selectedItem = 'Locality';

  @override
  void initState() {
    selectedItem = 'Locality';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        selectedItem == 'Locality'
            ? SizedBox(
                height: screenSize.height * 0.75,
                width: screenSize.width,
                child: const LocalityInterventionMap(),
              )
            : SizedBox(
                height: screenSize.height * 0.75,
                width: screenSize.width,
                child: const StateInterventionMap(),
              ),
        Center(
          heightFactor: 1,
          child: Padding(
            padding: EdgeInsets.only(
              //top: screenSize.height * 0.40,
              left: ResponsiveWidget.isSmallScreen(context)
                  ? screenSize.width / 12
                  : screenSize.width / 5,
              right: ResponsiveWidget.isSmallScreen(context)
                  ? screenSize.width / 12
                  : screenSize.width / 5,
            ),
            child: ResponsiveWidget.isSmallScreen(context)
                ? Column(
                    children: [
                      ...Iterable<int>.generate(items.length).map(
                        (int pageIndex) => Padding(
                          padding: EdgeInsets.only(top: screenSize.height / 80),
                          child: Card(
                            //color: Theme.of(context).cardColor,
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenSize.height / 45,
                                  bottom: screenSize.height / 45,
                                  left: screenSize.width / 20),
                              child: Row(
                                children: [
                                  Icon(
                                    icons[pageIndex],
                                  ),
                                  SizedBox(width: screenSize.width / 20),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    onTap: () {},
                                    child: Text(
                                      items[pageIndex],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenSize.height / 50,
                        bottom: screenSize.height / 50,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: generateRowElements(),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
