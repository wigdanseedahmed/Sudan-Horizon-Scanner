import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class PoliticalMappingIndividualActorDetailScreen extends StatefulWidget {
  const PoliticalMappingIndividualActorDetailScreen(
      {Key? key, this.selectedIndividual})
      : super(key: key);

  final PoliticalMappingIndividualModel? selectedIndividual;

  @override
  State<PoliticalMappingIndividualActorDetailScreen> createState() =>
      _PoliticalMappingIndividualActorDetailScreenState();
}

class _PoliticalMappingIndividualActorDetailScreenState
    extends State<PoliticalMappingIndividualActorDetailScreen> {
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
                            NetworkImage(widget.selectedIndividual!.photoUrl!),
                        fit: BoxFit.fill,
                        placeholder: const AssetImage(
                            'assets/images/placeholder-image.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height / 10),
                Text(
                  widget.selectedIndividual!.actorNameEn!,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.024,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenSize.height / 50),
                Text(
                  widget.selectedIndividual!.jobTitle!,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.019,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenSize.height / 10),
                widget.selectedIndividual!.actorAffiliationGroupPartyNameEn ==
                        null
                    ? Container()
                    : Row(
                        children: [
                          Text(
                            widget.selectedIndividual!
                                        .actorAffiliationGroupPartyTypeEn ==
                                    "Political Party"
                                ? "Affiliated Political Party:"
                                : widget.selectedIndividual!
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
                            widget.selectedIndividual!
                                .actorAffiliationGroupPartyNameEn!,
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
                      widget.selectedIndividual!.startDate! ==
                              widget.selectedIndividual!.endDate!
                          ? DateFormat("EEE, MMM d, yyyy").format(
                              DateTime.parse(
                                  widget.selectedIndividual!.startDate!))
                          : "${DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(widget.selectedIndividual!.startDate!))} - ${DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(widget.selectedIndividual!.endDate!))}",
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
                      widget.selectedIndividual!.status!,
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
                widget.selectedIndividual!.actorDetailEn!.overview == null
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
                widget.selectedIndividual!.actorDetailEn!.overview == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedIndividual!.actorDetailEn!.overview == null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedIndividual!.actorDetailEn!.overview!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!.overview == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedIndividual!.actorDetailEn!.personalBackground ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Personal Background",
                          style: TextStyle(
                            color: primaryColour,
                            fontSize: screenSize.width * 0.02,
                            fontFamily: 'Montserrat',
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!.personalBackground ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedIndividual!.actorDetailEn!.personalBackground ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedIndividual!.actorDetailEn!
                              .personalBackground!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!.personalBackground ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedIndividual!.actorDetailEn!.educationBackground ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Education Background",
                          style: TextStyle(
                            color: primaryColour,
                            fontSize: screenSize.width * 0.02,
                            fontFamily: 'Montserrat',
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!.educationBackground ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedIndividual!.actorDetailEn!.educationBackground ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedIndividual!.actorDetailEn!
                              .educationBackground!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!.educationBackground ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedIndividual!.actorDetailEn!
                            .earlyAndInternationalCareer ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Early And International Career",
                          style: TextStyle(
                            color: primaryColour,
                            fontSize: screenSize.width * 0.02,
                            fontFamily: 'Montserrat',
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!
                            .earlyAndInternationalCareer ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedIndividual!.actorDetailEn!
                            .earlyAndInternationalCareer ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedIndividual!.actorDetailEn!
                              .earlyAndInternationalCareer!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!
                            .earlyAndInternationalCareer ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedIndividual!.actorDetailEn!.politicalCareer ==
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
                widget.selectedIndividual!.actorDetailEn!.politicalCareer ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedIndividual!.actorDetailEn!.politicalCareer ==
                        null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedIndividual!.actorDetailEn!
                              .politicalCareer!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!.politicalCareer ==
                        null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedIndividual!.actorDetailEn!.views == null
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
                widget.selectedIndividual!.actorDetailEn!.views == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedIndividual!.actorDetailEn!.views == null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedIndividual!.actorDetailEn!.views!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!.views == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedIndividual!.actorDetailEn!.predictions == null
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
                widget.selectedIndividual!.actorDetailEn!.predictions == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedIndividual!.actorDetailEn!.predictions == null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget
                              .selectedIndividual!.actorDetailEn!.predictions!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!.predictions == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedIndividual!.actorDetailEn!.summary == null
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
                widget.selectedIndividual!.actorDetailEn!.summary == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 30),
                widget.selectedIndividual!.actorDetailEn!.summary == null
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectedIndividual!.actorDetailEn!.summary!,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                widget.selectedIndividual!.actorDetailEn!.summary == null
                    ? Container()
                    : SizedBox(height: screenSize.height / 10),
                widget.selectedIndividual!.actorDetailEn!.references == null
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
                widget.selectedIndividual!.actorDetailEn!.references == null
                    ? Container()
                    : SizedBox(
                        height: widget.selectedIndividual!.actorDetailEn!
                                .references!.length *
                            screenSize.height *
                            0.1,
                        child: ListView.builder(
                            itemCount: widget.selectedIndividual!.actorDetailEn!
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
                                        "${widget.selectedIndividual!.actorDetailEn!.references![index].createdBy!}:",
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
                                            .selectedIndividual!
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
