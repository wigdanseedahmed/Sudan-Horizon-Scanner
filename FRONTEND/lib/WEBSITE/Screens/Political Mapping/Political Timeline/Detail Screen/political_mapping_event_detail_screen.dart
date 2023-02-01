import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class PoliticalMappingEventDetailScreen extends StatefulWidget {
  const PoliticalMappingEventDetailScreen({Key? key, this.selectedEvent})
      : super(key: key);

  final PoliticalMappingEventModel? selectedEvent;

  @override
  State<PoliticalMappingEventDetailScreen> createState() =>
      _PoliticalMappingEventDetailScreenState();
}

class _PoliticalMappingEventDetailScreenState
    extends State<PoliticalMappingEventDetailScreen> {
  late List<PoliticalMappingIndividualModel> readPoliticalIndividualsData =
      <PoliticalMappingIndividualModel>[];

  Future<List<PoliticalMappingIndividualModel>>
      readPoliticalIndividualsFromJsonFile() async {
    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getPoliticalMappingIndividuals);

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
        readPoliticalIndividualsData = politicalMappingIndividualModelFromJson(
            response.body); //(jsonString);
        //print("ALL  individuals: $readJsonFileContent");
      });
      return readPoliticalIndividualsData;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  late List<PoliticalMappingPartyGroupModel> readPoliticalPartyGroupData =
      <PoliticalMappingPartyGroupModel>[];

  Future<List<PoliticalMappingPartyGroupModel>>
      readPoliticalPartyGroupFromJsonFile() async {
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
        readPoliticalPartyGroupData = politicalMappingPartyGroupModelFromJson(
            response.body); //(jsonString);
        //print("ALL  readPoliticalPartyGroupData: $readPoliticalPartyGroupData");
      });
      return readPoliticalPartyGroupData;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContentsWS(_opacity),
      ),
      body: FutureBuilder(
        future: readPoliticalPartyGroupFromJsonFile(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (!data.hasData) {
            //data.connectionState == ConnectionState.waiting
            return const Center(child: CircularProgressIndicator());
          } else {
            return FutureBuilder(
              future: readPoliticalIndividualsFromJsonFile(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(child: Text("${data.error}"));
                } else if (!data.hasData) {
                  //data.connectionState == ConnectionState.waiting
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return buildBody(context, screenSize);
                }
              },
            );
          }
        },
      ),
    );
  }

  buildBody(BuildContext context, Size screenSize) {
    return Container(
      color: DynamicTheme.of(context)?.brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF323232),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
              left: screenSize.width * 0.1, right: screenSize.width * 0.1),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.5,
                    width: screenSize.width,
                    child: FadeInImage(
                      image: NetworkImage(widget.selectedEvent!.photoUrl!),
                      fit: BoxFit.fill,
                      placeholder: const AssetImage(
                          'assets/images/placeholder-image.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height / 10),
              Text(
                widget.selectedEvent!.eventNameEn!,
                style: TextStyle(
                  fontSize: screenSize.width * 0.024,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.height / 10),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  Text(
                    widget.selectedEvent!.startDate! ==
                            widget.selectedEvent!.endDate!
                        ? DateFormat("EEE, MMM d, yyyy").format(
                            DateTime.parse(widget.selectedEvent!.startDate!))
                        : "${DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(widget.selectedEvent!.startDate!))} - ${DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(widget.selectedEvent!.endDate!))}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenSize.width * 0.01,
                      fontFamily: 'Montserrat',
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height / 50),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  Text(
                    "${widget.selectedEvent!.localityNameEn!}, ${widget.selectedEvent!.stateNameEn!}, ${widget.selectedEvent!.countryEn!}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenSize.width * 0.01,
                      fontFamily: 'Montserrat',
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height / 10),
              widget.selectedEvent!.eventDetailEn!.overview == null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Overview",
                        style: TextStyle(
                          color: primaryColour,
                          fontSize: screenSize.width * 0.02,
                          fontFamily: 'Montserrat',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
              widget.selectedEvent!.eventDetailEn!.overview == null
                  ? Container()
                  : SizedBox(height: screenSize.height / 30),
              widget.selectedEvent!.eventDetailEn!.overview == null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.selectedEvent!.eventDetailEn!.overview!,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.01,
                          fontFamily: 'Montserrat',
                          letterSpacing: 2,
                        ),
                      ),
                    ),
              widget.selectedEvent!.eventDetailEn!.overview == null
                  ? Container()
                  : SizedBox(height: screenSize.height / 10),
              widget.selectedEvent!.partyGroupInvolvedEn == null
                  ? widget.selectedEvent!.peopleInvolvedEn == null
                      ? Container()
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Involved Actors",
                            style: TextStyle(
                              color: primaryColour,
                              fontSize: screenSize.width * 0.02,
                              fontFamily: 'Montserrat',
                              letterSpacing: 6,
                            ),
                          ),
                        )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Involved Actors",
                        style: TextStyle(
                          color: primaryColour,
                          fontSize: screenSize.width * 0.02,
                          fontFamily: 'Montserrat',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
              widget.selectedEvent!.partyGroupInvolvedEn == null
                  ? widget.selectedEvent!.peopleInvolvedEn == null
                      ? Container()
                      : SizedBox(height: screenSize.height / 30)
                  : SizedBox(height: screenSize.height / 30),
              widget.selectedEvent!.peopleInvolvedEn == null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Involved Individuals",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenSize.width * 0.012,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
              widget.selectedEvent!.peopleInvolvedEn == null
                  ? Container()
                  : SizedBox(
                      height: screenSize.height * 0.3,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.selectedEvent!.peopleInvolvedEn!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: screenSize.width * 0.01),
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius:
                                //         BorderRadius.circular(8.0)),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(
                                      width: screenSize.width * 0.1,
                                      height: screenSize.height * 0.2,
                                      child: Image.network(
                                        readPoliticalIndividualsData
                                            .where((element) =>
                                                element.actorNameEn ==
                                                widget.selectedEvent!
                                                    .peopleInvolvedEn![index])
                                            .toList()[0]
                                            .photoUrl!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      widget.selectedEvent!
                                          .peopleInvolvedEn![index],
                                      maxLines: 4,
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.009,
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 2,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8.0),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
              widget.selectedEvent!.peopleInvolvedEn == null
                  ? Container()
                  : SizedBox(height: screenSize.height / 30),
              widget.selectedEvent!.partyGroupInvolvedEn == null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Involved Political Parties/Interest Groups",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenSize.width * 0.012,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
              widget.selectedEvent!.partyGroupInvolvedEn == null
                  ? Container()
                  : SizedBox(
                      height: screenSize.height * 0.35,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.selectedEvent!.partyGroupInvolvedEn!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: screenSize.width * 0.01),
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius:
                                //         BorderRadius.circular(8.0)),
                                clipBehavior: Clip.antiAlias,
                                child: SizedBox(
                                  width: screenSize.width * 0.12,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: screenSize.height * 0.2,
                                        child: Image.network(
                                          readPoliticalPartyGroupData
                                              .where((element) =>
                                                  element.actorNameEn ==
                                                  widget.selectedEvent!
                                                          .partyGroupInvolvedEn![
                                                      index])
                                              .toList()[0]
                                              .photoUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        widget.selectedEvent!
                                            .partyGroupInvolvedEn![index],
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontSize: screenSize.width * 0.009,
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 2,
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8.0),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
              widget.selectedEvent!.partyGroupInvolvedEn == null
                  ? widget.selectedEvent!.peopleInvolvedEn == null
                      ? Container()
                      : SizedBox(height: screenSize.height / 10)
                  : SizedBox(height: screenSize.height / 10),
              widget.selectedEvent!.eventDetailEn!.details == null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Details",
                        style: TextStyle(
                          color: primaryColour,
                          fontSize: screenSize.width * 0.02,
                          fontFamily: 'Montserrat',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
              widget.selectedEvent!.eventDetailEn!.details == null
                  ? Container()
                  : SizedBox(height: screenSize.height / 30),
              widget.selectedEvent!.eventDetailEn!.details == null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.selectedEvent!.eventDetailEn!.details!,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.01,
                          fontFamily: 'Montserrat',
                          letterSpacing: 2,
                        ),
                      ),
                    ),
              widget.selectedEvent!.eventDetailEn!.details == null
                  ? Container()
                  : SizedBox(height: screenSize.height / 10),
              widget.selectedEvent!.eventDetailEn!.effectedOnPeople == null &&
                      widget.selectedEvent!.eventDetailEn!
                              .effectOnPartiesGroups ==
                          null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Effect on Actors",
                        style: TextStyle(
                          color: primaryColour,
                          fontSize: screenSize.width * 0.02,
                          fontFamily: 'Montserrat',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
              widget.selectedEvent!.eventDetailEn!.effectedOnPeople == null &&
                      widget.selectedEvent!.eventDetailEn!
                              .effectOnPartiesGroups ==
                          null
                  ? Container()
                  : SizedBox(height: screenSize.height / 10),
              widget.selectedEvent!.eventDetailEn!.summary == null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Summary",
                        style: TextStyle(
                          color: primaryColour,
                          fontSize: screenSize.width * 0.02,
                          fontFamily: 'Montserrat',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
              widget.selectedEvent!.eventDetailEn!.summary == null
                  ? Container()
                  : SizedBox(height: screenSize.height / 30),
              widget.selectedEvent!.eventDetailEn!.summary == null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.selectedEvent!.eventDetailEn!.summary!,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.01,
                          fontFamily: 'Montserrat',
                          letterSpacing: 2,
                        ),
                      ),
                    ),
              widget.selectedEvent!.eventDetailEn!.summary == null
                  ? Container()
                  : SizedBox(height: screenSize.height / 10),
              widget.selectedEvent!.eventDetailEn!.references == null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "References",
                        style: TextStyle(
                          color: primaryColour,
                          fontSize: screenSize.width * 0.02,
                          fontFamily: 'Montserrat',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
              widget.selectedEvent!.eventDetailEn!.references == null
                  ? Container()
                  : SizedBox(height: screenSize.height / 30),
              widget.selectedEvent!.eventDetailEn!.references == null
                  ? Container()
                  : SizedBox(
                      height: widget.selectedEvent!.eventDetailEn!.references!
                              .length *
                          screenSize.height *
                          0.1,
                      child: ListView.builder(
                          itemCount: widget
                              .selectedEvent!.eventDetailEn!.references!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SizedBox(
                                  height: screenSize.height * 0.05,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Icon(Icons.circle,
                                        color: primaryColour, size: 8.0),
                                  ),
                                ),
                                SizedBox(width: screenSize.width * 0.03),
                                SizedBox(
                                  height: screenSize.height * 0.05,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${widget.selectedEvent!.eventDetailEn!.references![index].createdBy!}:",
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.01,
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenSize.width * 0.01),
                                SizedBox(
                                  width: screenSize.width * 0.68,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      widget.selectedEvent!.eventDetailEn!
                                          .references![index].link!,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.01,
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 2,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
              SizedBox(height: screenSize.height / 10),
              const BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
