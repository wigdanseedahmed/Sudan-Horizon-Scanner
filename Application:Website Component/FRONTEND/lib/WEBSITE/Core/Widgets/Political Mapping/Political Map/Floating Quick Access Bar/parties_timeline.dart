import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class PartiesTimelineScreen extends StatefulWidget {
  const PartiesTimelineScreen({
    Key? key,
    required this.screenSize,
  }) : super(key: key);
  final Size screenSize;

  @override
  _PartiesTimelineScreenState createState() => _PartiesTimelineScreenState();
}

class _PartiesTimelineScreenState extends State<PartiesTimelineScreen> with TickerProviderStateMixin {
  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  late List<PoliticalMappingPartyGroupModel> readJsonFileContent =
  <PoliticalMappingPartyGroupModel>[];
  late List<PoliticalMappingPartyGroupModel> searchData =
  <PoliticalMappingPartyGroupModel>[];

  Future<List<PoliticalMappingPartyGroupModel>>
  readPoliticalPartiesFromJsonFile() async {
    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getPoliticalMappingPartyGroups);

    /// Create Request to get data and response to read data
    final response = await http.get(
      uri,
      headers: {
        //"Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
        "Content-Type, Access-Control-Allow-Origin, Accept",
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
      },
    );
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      setState(() {
        readJsonFileContent =
            politicalMappingPartyGroupModelFromJson(response.body); //(jsonString);
        //print("ALL  Events: $readJsonFileContent");

        if (initialStartDate == "2022" &&
            initialEndDate == "----") {
          searchData = readJsonFileContent
              .where((PoliticalMappingPartyGroupModel partyGroupActor) =>
          DateFormat("yyyy")
              .format(DateTime.parse(partyGroupActor.startDate!))
              .toString()
              .toLowerCase() ==
              "2022")
              .toList();

          //print("start date = 2022 and end date = -: $searchData");
        } else {
          searchData = searchData;
          //print("search data: $searchData");
        }
      });
      return searchData;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  ///VARIABLES USED FOR DROP DOWN MENU IN FILTER
  String initialStartDate = "2022";
  String initialEndDate = "----";

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(
              left: screenSize.width * 0.2,
              top: screenSize.height * 0.05,
              right: screenSize.width * 0.2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Start Year",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenSize.width / 85,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(width: screenSize.width / 8),
                    Container(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.06,
                      alignment: Alignment.centerLeft,
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter dropDownState) {
                        return DropdownSearch<String>(
                          dropdownSearchBaseStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: screenSize.width / 85,
                            fontFamily: 'Montserrat',
                            letterSpacing: 3,
                          ),
                          dropdownSearchDecoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: screenSize.width / 85,
                              fontFamily: 'Montserrat',
                              letterSpacing: 3,
                            ),
                          ),
                          //mode of dropdown
                          mode: Mode.MENU,
                          //to show search box
                          showSearchBox: true,
                          //list of dropdown items
                          items: startDatePoliticalYearList,
                          onChanged: (String? newValue) {
                            dropDownState(() {
                              initialStartDate = newValue!;
                              if (initialStartDate == "----") {
                                setState(() {
                                  // no search field input, display all items
                                  searchData = readJsonFileContent
                                      .where(
                                          (PoliticalMappingPartyGroupModel partyGroupActor) =>
                                      DateFormat("yyyy")
                                          .format(DateTime.parse(
                                          partyGroupActor.startDate!))
                                          .toString()
                                          .toLowerCase() ==
                                          "2022")
                                      .toList();
                                });
                              } else {
                                setState(() {
                                  searchData = readJsonFileContent
                                      .where(
                                          (PoliticalMappingPartyGroupModel partyGroupActor) =>
                                      DateFormat("yyyy")
                                          .format(DateTime.parse(
                                          partyGroupActor.startDate!))
                                          .toString()
                                          .toLowerCase() ==
                                          newValue.toString().toLowerCase())
                                      .toList();
                                  initialEndDate = "----";
                                });
                              }
                            });
                          },
                          //show selected item
                          selectedItem: initialStartDate,
                        );
                      }),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "End year",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenSize.width / 85,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(width: screenSize.width / 12),
                    Container(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.06,
                      alignment: Alignment.centerLeft,
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter dropDownState) {
                        return DropdownSearch<String>(
                          dropdownSearchBaseStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: screenSize.width / 85,
                            fontFamily: 'Montserrat',
                            letterSpacing: 3,
                          ),
                          dropdownSearchDecoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: screenSize.width / 85,
                              fontFamily: 'Montserrat',
                              letterSpacing: 3,
                            ),
                          ),
                          //mode of dropdown
                          mode: Mode.MENU,
                          //to show search box
                          showSearchBox: true,
                          //list of dropdown items
                          items: endDatePoliticalYearList,
                          onChanged: (String? newValue) {
                            dropDownState(() {
                              initialEndDate = newValue!;
                              if (initialEndDate == "----") {
                                setState(() {
                                  // no search field input, display all items
                                  searchData = readJsonFileContent
                                      .where(
                                          (PoliticalMappingPartyGroupModel event) =>
                                      DateFormat("yyyy")
                                          .format(DateTime.parse(
                                          event.startDate!))
                                          .toString()
                                          .toLowerCase() ==
                                          "2022")
                                      .toList();
                                });
                              } else {
                                setState(() {
                                  searchData = readJsonFileContent
                                      .where(
                                          (PoliticalMappingPartyGroupModel event) =>
                                      DateFormat("yyyy")
                                          .format(DateTime.parse(
                                          event.endDate!))
                                          .toString()
                                          .toLowerCase() ==
                                          newValue.toString().toLowerCase())
                                      .toList();
                                  initialStartDate = "----";
                                });
                              }
                            });
                          },
                          //show selected item
                          selectedItem: initialEndDate,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: readPoliticalPartiesFromJsonFile(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (!data.hasData) {
              //data.connectionState == ConnectionState.waiting
              return const Center(child: CircularProgressIndicator());
            } else {
              return SizedBox(
                width: widget.screenSize.width * 0.65,
                height: searchData.length * widget.screenSize.height * 0.5,
                child: partiesTimelineModel(),
              );
            }
          },
        ),
      ],
    );
  }

  partiesTimelineModel() => Timeline.builder(
    itemBuilder: centerPartiesTimelineBuilder,
    itemCount: searchData.length,
    physics: const NeverScrollableScrollPhysics(),
    position: TimelinePosition.Center,
  );

  TimelineModel centerPartiesTimelineBuilder(BuildContext context, int i) {
    return TimelineModel(
      SizedBox(
        width: widget.screenSize.width * 0.25,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PoliticalMappingGroupPartyActorDetailScreen(selectedPartyGroup: searchData[i]),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: widget.screenSize.width,
                  height: widget.screenSize.height * 0.25,
                  child: Image.network(
                    searchData[i].photoUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  searchData[i].startDate! == searchData[i].endDate!?
                  DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(searchData[i].startDate!)):
                  "${DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(searchData[i].startDate!))} - ${DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(searchData[i].endDate!))}",
                  style: TextStyle(
                    color: primaryColour,
                    fontSize: 13,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  searchData[i].actorNameEn!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
      position:
      i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
      isFirst: i == 0,
      isLast: i == doodles.length,
      //iconBackground: doodle.iconBackground!,
      icon: const Icon(Icons.circle),
    );
  }
}