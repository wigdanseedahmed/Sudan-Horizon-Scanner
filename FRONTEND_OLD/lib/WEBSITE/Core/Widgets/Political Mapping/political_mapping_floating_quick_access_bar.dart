import 'package:sudan_horizon_scanner/imports.dart';

class PoliticalMapFloatingQuickAccessBar extends StatefulWidget {
  const PoliticalMapFloatingQuickAccessBar({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  _PoliticalMapFloatingQuickAccessBarState createState() =>
      _PoliticalMapFloatingQuickAccessBarState();
}

class _PoliticalMapFloatingQuickAccessBarState
    extends State<PoliticalMapFloatingQuickAccessBar> {
  late String selectedItem;

  final List _isHovering = [false, false, false, false, false];
  List<Widget> rowElements = [];

  List<String> items = ['Event', 'Actors', "Coalition", 'Location', 'Search'];
  List<IconData> icons = [
    Icons.location_on,
    Icons.date_range,
    Icons.people,
    Icons.search_sharp
  ];

  List<Widget> generateRowElements() {
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
        child: Row(
          children: [
            Text(
              items[i],
              style: TextStyle(
                color: _isHovering[i]
                    ? primaryColour
                    : DynamicTheme.of(context)?.brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
              ),
            ),
            items[i] == 'Actors'
                ? PopupMenuButton(
                    offset: const Offset(0, 35),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    onSelected: (result) {
                      setState(() {
                        if (result == 'Individuals') {
                          selectedItem = 'Individuals';
                        } else if (result == 'Parties') {
                          selectedItem = 'Parties';
                        } else if (result == 'Interest Groups') {
                          selectedItem = 'Interest Groups';
                        }
                      });
                    },
                    itemBuilder: (context) {
                      List<PopupMenuEntry<Object>> list = [];
                      list.add(
                        PopupMenuItem(
                          child: Text(
                            'Individuals',
                            style: TextStyle(
                                fontSize: widget.screenSize.width / 125),
                          ),
                          value: 'Individuals',
                        ),
                      );
                      list.add(
                        PopupMenuItem(
                          child: Text(
                            'Parties',
                            style: TextStyle(
                                fontSize: widget.screenSize.width / 125),
                          ),
                          value: 'Parties',
                        ),
                      );
                      list.add(
                        PopupMenuItem(
                          child: Text(
                            'Interest Groups',
                            style: TextStyle(
                                fontSize: widget.screenSize.width / 125),
                          ),
                          value: 'Interest Groups',
                        ),
                      );
                      return list;
                    },
                  )
                : Container(),
          ],
        ),
      );
      Widget spacer = SizedBox(
        height: widget.screenSize.height / 20,
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

  @override
  void initState() {
    selectedItem = 'Event';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          heightFactor: 1,
          child: Padding(
            padding: EdgeInsets.only(
              top: widget.screenSize.height * 0.45,
              left: ResponsiveWidget.isSmallScreen(context)
                  ? widget.screenSize.width / 12
                  : widget.screenSize.width / 5,
              right: ResponsiveWidget.isSmallScreen(context)
                  ? widget.screenSize.width / 12
                  : widget.screenSize.width / 5,
            ),
            child: ResponsiveWidget.isSmallScreen(context)
                ? Column(
                    children: [
                      ...Iterable<int>.generate(items.length).map(
                        (int pageIndex) => Padding(
                          padding: EdgeInsets.only(
                              top: widget.screenSize.height / 80),
                          child: Card(
                            color: Theme.of(context).cardColor,
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: widget.screenSize.height / 45,
                                  //bottom: widget.screenSize.height / 45,
                                  left: widget.screenSize.width / 20),
                              child: Row(
                                children: [
                                  Icon(
                                    icons[pageIndex],
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  SizedBox(width: widget.screenSize.width / 20),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    onTap: () {
                                      selectedItem = items[pageIndex];
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          items[pageIndex],
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .button!
                                                .color,
                                            fontSize: 16,
                                          ),
                                        ),
                                        items[pageIndex] == 'Actors'
                                            ? StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter dropDownState) {
                                                return PopupMenuButton(
                                                  offset: const Offset(0, 35),
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                  ),
                                                  onSelected: (result) {
                                                    setState(() {
                                                      if (result ==
                                                          'Individuals') {
                                                        selectedItem =
                                                            'Individuals';
                                                      } else if (result ==
                                                          'Parties') {
                                                        selectedItem =
                                                            'Parties';
                                                      } else if (result ==
                                                          'Interest Groups') {
                                                        selectedItem =
                                                            'Interest Groups';
                                                      }
                                                      print(result);
                                                    });
                                                  },
                                                  itemBuilder: (context) {
                                                    List<PopupMenuEntry<Object>>
                                                        list = [];
                                                    list.add(
                                                      PopupMenuItem(
                                                        child: Text(
                                                          'Individuals',
                                                          style: TextStyle(
                                                              fontSize: widget
                                                                      .screenSize
                                                                      .width /
                                                                  125),
                                                        ),
                                                        value: 'Individuals',
                                                      ),
                                                    );
                                                    list.add(
                                                      PopupMenuItem(
                                                        child: Text(
                                                          'Parties',
                                                          style: TextStyle(
                                                              fontSize: widget
                                                                      .screenSize
                                                                      .width /
                                                                  125),
                                                        ),
                                                        value: 'Parties',
                                                      ),
                                                    );
                                                    list.add(
                                                      PopupMenuItem(
                                                        child: Text(
                                                          'Interest Groups',
                                                          style: TextStyle(
                                                              fontSize: widget
                                                                      .screenSize
                                                                      .width /
                                                                  125),
                                                        ),
                                                        value:
                                                            'Interest Groups',
                                                      ),
                                                    );
                                                    return list;
                                                  },
                                                );
                                              })
                                            : Container(),
                                      ],
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
                        top: widget.screenSize.height / 50,
                        bottom: widget.screenSize.height / 50,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: generateRowElements(),
                      ),
                    ),
                  ),
          ),
        ),
        selectedItem == 'Event'
            ? EventsTimelinePage(screenSize: widget.screenSize)
            : selectedItem == 'Individuals'
                ? IndividualActorsTimelineScreen(screenSize: widget.screenSize)
                : selectedItem == 'Parties'
                    ? PartiesTimelineScreen(screenSize: widget.screenSize)
                    : selectedItem == 'Interest Groups'
                        ? InterestGroupsTimelineScreen(screenSize: widget.screenSize)
                        : selectedItem == 'Coalition'
                            ? CoalitionTimelineScreen(
                                screenSize: widget.screenSize)
                            : selectedItem == 'Location'
                                ? StatePoliticalMapScreen(
                                    screenSize: widget.screenSize)
                                : Container(),
      ],
    );
  }
}
