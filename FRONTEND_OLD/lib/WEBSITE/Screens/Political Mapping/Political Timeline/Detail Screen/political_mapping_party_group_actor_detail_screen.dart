import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class PoliticalMappingGroupPartyActorDetailScreen extends StatefulWidget {
  const PoliticalMappingGroupPartyActorDetailScreen(
      {Key? key, this.selectedPartyGroup})
      : super(key: key);

  final PoliticalMappingPartyGroupModel? selectedPartyGroup;

  @override
  State<PoliticalMappingGroupPartyActorDetailScreen> createState() =>
      _PoliticalMappingGroupPartyActorDetailScreenState();
}

class _PoliticalMappingGroupPartyActorDetailScreenState
    extends State<PoliticalMappingGroupPartyActorDetailScreen> {
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
      body: Container(
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
                        image:
                            NetworkImage(widget.selectedPartyGroup!.photoUrl!),
                        fit: BoxFit.fill,
                        placeholder: const AssetImage(
                            'assets/images/placeholder-image.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height / 10),
                Text(
                  widget.selectedPartyGroup!.actorNameEn!,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.024,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenSize.height / 10),
                widget.selectedPartyGroup!.actorAffiliationGroupPartyTypeEn ==
                        null
                    ? Container()
                    : Row(
                        children: [
                          Text(
                            widget.selectedPartyGroup!
                                        .actorAffiliationGroupPartyTypeEn ==
                                    "Political Party"
                                ? "Affiliated Political Party:"
                                : widget.selectedPartyGroup!
                                            .actorAffiliationGroupPartyTypeEn ==
                                        "Interest Groups"
                                    ? "Affiliated Interest Groups:"
                                    : "Affiliated with:",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: screenSize.width * 0.01,
                              fontFamily: 'Montserrat',
                              letterSpacing: 3,
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.01),
                          Text(
                            widget.selectedPartyGroup!
                                .actorAffiliationGroupPartyTypeEn!,
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
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(width: screenSize.width * 0.01),
                    Text(
                      widget.selectedPartyGroup!.startDate! ==
                              widget.selectedPartyGroup!.endDate!
                          ? DateFormat("EEE, MMM d, yyyy").format(
                              DateTime.parse(
                                  widget.selectedPartyGroup!.startDate!))
                          : "${DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(widget.selectedPartyGroup!.startDate!))} - ${DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(widget.selectedPartyGroup!.endDate!))}",
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
                      Icons.tag,
                      color: Colors.grey,
                    ),
                    SizedBox(width: screenSize.width * 0.01),
                    Text(
                      widget.selectedPartyGroup!.status!,
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
                widget.selectedPartyGroup!.actorDetailEn!.overview == null
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
                widget.selectedPartyGroup!.actorDetailEn!.overview == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedPartyGroup!.actorDetailEn!.overview == null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedPartyGroup!.actorDetailEn!.overview!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.overview == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedPartyGroup!.actorDetailEn!.actorBackground ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Background",
                          style: TextStyle(
                            color: primaryColour,
                            fontSize: screenSize.width * 0.02,
                            fontFamily: 'Montserrat',
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.actorBackground ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedPartyGroup!.actorDetailEn!.actorBackground ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedPartyGroup!.actorDetailEn!
                              .actorBackground!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.actorBackground ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedPartyGroup!.actorDetailEn!.politicalCareer ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Political Career",
                          style: TextStyle(
                            color: primaryColour,
                            fontSize: screenSize.width * 0.02,
                            fontFamily: 'Montserrat',
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.politicalCareer ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedPartyGroup!.actorDetailEn!.politicalCareer ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedPartyGroup!.actorDetailEn!
                              .politicalCareer!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.politicalCareer ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedPartyGroup!.actorDetailEn!.ideologies ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ideologies",
                          style: TextStyle(
                            color: primaryColour,
                            fontSize: screenSize.width * 0.02,
                            fontFamily: 'Montserrat',
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.ideologies ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedPartyGroup!.actorDetailEn!.ideologies ==
                        null
                    ? Container()
                    : SizedBox(
                  height: widget.selectedPartyGroup!.actorDetailEn!
                      .references!.length *
                      screenSize.height *
                      0.1,
                  child: ListView.builder(
                      itemCount: widget.selectedPartyGroup!.actorDetailEn!
                          .references!.length,
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
                              width: screenSize.width * 0.68,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  widget.selectedPartyGroup!.actorDetailEn!
                                      .ideologies![index],
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
                widget.selectedPartyGroup!.actorDetailEn!.ideologies ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedPartyGroup!.actorDetailEn!.views == null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Views",
                          style: TextStyle(
                            color: primaryColour,
                            fontSize: screenSize.width * 0.02,
                            fontFamily: 'Montserrat',
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.views == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedPartyGroup!.actorDetailEn!.views == null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedPartyGroup!.actorDetailEn!.views!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.views == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedPartyGroup!.actorDetailEn!.predictions == null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Predictions",
                          style: TextStyle(
                            color: primaryColour,
                            fontSize: screenSize.width * 0.02,
                            fontFamily: 'Montserrat',
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.predictions == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedPartyGroup!.actorDetailEn!.predictions == null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget
                              .selectedPartyGroup!.actorDetailEn!.predictions!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.predictions == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedPartyGroup!.actorDetailEn!.summary == null
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
                widget.selectedPartyGroup!.actorDetailEn!.summary == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedPartyGroup!.actorDetailEn!.summary == null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedPartyGroup!.actorDetailEn!.summary!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedPartyGroup!.actorDetailEn!.summary == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedPartyGroup!.actorDetailEn!.references == null
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
                widget.selectedPartyGroup!.actorDetailEn!.references == null
                    ? Container()
                    : SizedBox(
                        height: widget.selectedPartyGroup!.actorDetailEn!
                                .references!.length *
                            screenSize.height *
                            0.1,
                        child: ListView.builder(
                            itemCount: widget.selectedPartyGroup!.actorDetailEn!
                                .references!.length,
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
                                        "${widget.selectedPartyGroup!.actorDetailEn!.references![index].createdBy!}:",
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
                                        widget
                                            .selectedPartyGroup!
                                            .actorDetailEn!
                                            .references![index]
                                            .link!,
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
      ),
    );
  }
}
