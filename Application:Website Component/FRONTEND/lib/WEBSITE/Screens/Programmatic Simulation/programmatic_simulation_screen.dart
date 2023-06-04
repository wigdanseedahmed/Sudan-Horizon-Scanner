import 'package:nb_utils/nb_utils.dart';
import 'package:sudan_horizon_scanner/imports.dart';

export 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

class ProgrammaticSimulationScreenWS extends StatefulWidget {
  const ProgrammaticSimulationScreenWS({
    Key? key,
    this.localityFilterSelectedOption,
    this.cityFilterSelectedOption,
    this.stateFilterSelectedOption,
    this.provinceFilterSelectedOption,
    this.regionFilterSelectedOption,
    this.initialStartDate,
    this.initialEndDate,
    this.portfolioAffiliationFilterSelectedOption,
    this.interventionDurationTypeFilterSelectedOption,
    this.isOtherPortfolioAffiliationSelected,
    this.subThematicAreasFilterSelectedOption,
    this.languageSelectedOption,
    this.sdgSelectedOption,
    this.donatedAmountFilterSelectedOption,
    this.donatedAmountMinValue,
    this.donatedAmountMaxValue,
    this.donatedAmountValue,
    this.durationFilterSelectedOption,
    this.durationMinValue,
    this.durationMaxValue,
    this.durationValue,
  }) : super(key: key);

  final List? localityFilterSelectedOption;
  final List? cityFilterSelectedOption;
  final List? stateFilterSelectedOption;
  final List? provinceFilterSelectedOption;
  final List? regionFilterSelectedOption;

  final String? initialStartDate;
  final String? initialEndDate;

  final List? portfolioAffiliationFilterSelectedOption;

  final String? interventionDurationTypeFilterSelectedOption;

  final bool? isOtherPortfolioAffiliationSelected;

  final List? subThematicAreasFilterSelectedOption;

  final List? languageSelectedOption;

  final List? sdgSelectedOption;

  final String? donatedAmountFilterSelectedOption;
  final double? donatedAmountMinValue;
  final double? donatedAmountMaxValue;
  final double? donatedAmountValue;

  final String? durationFilterSelectedOption;
  final double? durationMinValue;
  final double? durationMaxValue;
  final double? durationValue;

  @override
  State<ProgrammaticSimulationScreenWS> createState() =>
      _ProgrammaticSimulationScreenWSState();
}

class _ProgrammaticSimulationScreenWSState
    extends State<ProgrammaticSimulationScreenWS> {
  /// Filter Variables

  List localityFilterSelectedOption = [];
  List cityFilterSelectedOption = [];
  List stateFilterSelectedOption = [];
  List provinceFilterSelectedOption = [];
  List regionFilterSelectedOption = [];

  String initialStartDate = "";
  String initialEndDate = "";

  List portfolioAffiliationFilterSelectedOption = [];

  String interventionDurationTypeFilterSelectedOption = "Choose One";

  bool isOtherPortfolioAffiliationSelected = false;

  List subThematicAreasFilterSelectedOption = [];

  List languageSelectedOption = [];

  List sdgSelectedOption = [];

  String donatedAmountFilterSelectedOption = 'Choose One';
  double donatedAmountMinValue = 0.0;
  double donatedAmountMaxValue = 0.0;
  double donatedAmountValue = 0.0;

  String durationFilterSelectedOption = 'Choose One';
  double durationMinValue = 0.0;
  double durationMaxValue = 0.0;
  double durationValue = 0.0;

  /// VARIABLES FOR BUDGET

  List<BudgetChartData> budgetChartData = [];

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
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
    /// BUDGET CHART VARIABLES
    budgetChartData.add(BudgetChartData("Overhead", 40));
    budgetChartData.add(BudgetChartData("Remaining Money", 60));

    /// FILTER VARIABLES
    localityFilterSelectedOption = widget.localityFilterSelectedOption!;
    cityFilterSelectedOption = widget.cityFilterSelectedOption!;
    stateFilterSelectedOption = widget.stateFilterSelectedOption!;
    provinceFilterSelectedOption = widget.provinceFilterSelectedOption!;
    regionFilterSelectedOption = widget.regionFilterSelectedOption!;
    initialStartDate = widget.initialStartDate!;
    initialEndDate = widget.initialEndDate!;
    portfolioAffiliationFilterSelectedOption =
        widget.portfolioAffiliationFilterSelectedOption!;
    interventionDurationTypeFilterSelectedOption =
        widget.interventionDurationTypeFilterSelectedOption!;
    isOtherPortfolioAffiliationSelected =
        widget.isOtherPortfolioAffiliationSelected!;
    subThematicAreasFilterSelectedOption =
        widget.subThematicAreasFilterSelectedOption!;
    languageSelectedOption = widget.languageSelectedOption!;
    sdgSelectedOption = widget.sdgSelectedOption!;
    donatedAmountFilterSelectedOption =
        widget.donatedAmountFilterSelectedOption!;
    donatedAmountMinValue = widget.donatedAmountMinValue!;
    donatedAmountMaxValue = widget.donatedAmountMaxValue!;
    donatedAmountValue = widget.donatedAmountValue!;
    durationFilterSelectedOption = widget.durationFilterSelectedOption!;
    durationMinValue = widget.durationMinValue!;
    durationMaxValue = widget.durationMaxValue!;
    durationValue = widget.durationValue!;

    /// SCREEN VARIABLES
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(screenSize),
        body: SafeArea(child: buildBody(screenSize)),
      );
    });
  }

  buildAppBar(Size screenSize) {
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: TopBarContentsWS(_opacity),
    );
  }

  buildBody(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          fit: FlexFit.loose,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  children: <Widget>[
                    IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              height: screenSize.height * 0.6,
                              width: screenSize.width,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  gradient: LinearGradient(colors: [
                                    Colors.blue,
                                    Colors.blue.shade200,
                                    Colors.blue.shade50,
                                  ])),
                              child: SvgPicture.asset(
                                  'assets/svg/Picture 1.svg',
                                  semanticsLabel: 'Picture 1'),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildInterventionsAndSDGSFilter(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                  buildDonatedAmountFilter(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                  buildDateFilter(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                  buildLocationFilter(screenSize),
                                ],
                              ),
                              SizedBox(width: screenSize.width * 0.02),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildInputSummary(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                  buildBudgetHealth(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                  buildRecommendation1(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                  buildRecommendation2(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                  buildRecommendation3(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                  buildRecommendation4(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                  buildRiskAnalysis(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                  buildNewsFeedBack(screenSize),
                                  SizedBox(height: screenSize.height * 0.02),
                                ],
                              ),
                              SizedBox(width: screenSize.width * 0.0095),
                            ],
                          ),
                          SizedBox(height: screenSize.height / 10),
                          const BottomBar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///-------------------------- FOR FILTER THROUGH ISSUES OF THE MONTH DATA --------------------------///

  buildInterventionsAndSDGSFilter(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.5,
      width: screenSize.width * 0.205,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width / 5.5,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Interventions\n & SDGs',
                      style: cardTitleTextStyle,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          portfolioAffiliationFilterSelectedOption = [];

                          subThematicAreasFilterSelectedOption = [];

                          sdgSelectedOption = [];

                          donatedAmountFilterSelectedOption = 'Choose One';
                          donatedAmountMinValue = 0.0;
                          donatedAmountMaxValue = 0.0;
                          donatedAmountValue = 0.0;
                        });
                      },
                      icon: const Icon(Icons.clear),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  title: const Text('Type of Intervention'),
                  children: [
                    MultiSelectCheckList(
                      maxSelectableCount: 5,
                      textStyles: const MultiSelectTextStyles(
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                      ),
                      listViewSettings: ListViewSettings(
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                      ),
                      //controller: _controller,
                      items: List.generate(
                        portfolioAffiliationForProgrammaticSimulationList!
                            .length,
                        (index) => CheckListCard(
                          value:
                              portfolioAffiliationForProgrammaticSimulationList![
                                  index],
                          title: Text(
                              portfolioAffiliationForProgrammaticSimulationList![
                                  index]),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected: index ==
                              portfolioAffiliationForProgrammaticSimulationList!
                                  .length,
                          enabled: !(index ==
                              portfolioAffiliationForProgrammaticSimulationList!
                                  .length),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            portfolioAffiliationFilterSelectedOption =
                                allSelectedItems;
                          } else {
                            portfolioAffiliationFilterSelectedOption = [];
                          }

                          if (allSelectedItems.contains("Others") == true) {
                            isOtherPortfolioAffiliationSelected = true;
                          } else {
                            isOtherPortfolioAffiliationSelected = false;
                          }
                        });
                      },
                      onMaximumSelected: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            portfolioAffiliationFilterSelectedOption =
                                allSelectedItems;
                          } else {
                            portfolioAffiliationFilterSelectedOption = [];
                          }

                          if (allSelectedItems.contains("Others") == true) {
                            isOtherPortfolioAffiliationSelected = true;
                          } else {
                            isOtherPortfolioAffiliationSelected = false;
                          }
                        });
                      },
                    ),
                    Container(
                        height: screenSize.height * 0.01, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  title: const Text('Sub-Thematic Areas'),
                  children: [
                    MultiSelectCheckList(
                      maxSelectableCount: 5,
                      textStyles: const MultiSelectTextStyles(
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                      ),
                      listViewSettings: ListViewSettings(
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                      ),
                      //controller: _controller,
                      items: List.generate(
                        sentimentAnalysisFilter.length,
                        (index) => CheckListCard(
                          value: sentimentAnalysisFilter[index],
                          title: Text(sentimentAnalysisFilter[index]),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected: index == sentimentAnalysisFilter.length,
                          enabled: !(index == sentimentAnalysisFilter.length),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            subThematicAreasFilterSelectedOption =
                                allSelectedItems;
                          } else {
                            subThematicAreasFilterSelectedOption = [];
                          }
                        });
                      },
                      onMaximumSelected: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            subThematicAreasFilterSelectedOption =
                                allSelectedItems;
                          } else {
                            subThematicAreasFilterSelectedOption = [];
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  title: const Text('SDG'),
                  children: [
                    MultiSelectCheckList(
                      maxSelectableCount: 5,
                      textStyles: const MultiSelectTextStyles(
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                      ),
                      listViewSettings: ListViewSettings(
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                      ),
                      //controller: _controller,
                      items: List.generate(
                        sdgGoalsList!.length,
                        (index) => CheckListCard(
                          value: sdgGoalsList![index],
                          title: Text(sdgGoalsList![index]),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected: index == sdgGoalsList!.length,
                          enabled: !(index == sdgGoalsList!.length),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            sdgSelectedOption = allSelectedItems;
                          } else {
                            sdgSelectedOption = [];
                          }
                        });
                      },
                      onMaximumSelected: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            sdgSelectedOption = allSelectedItems;
                          } else {
                            sdgSelectedOption = [];
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height / 50),
            ],
          ),
        ),
      ),
    );
  }

  buildDonatedAmountFilter(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.3,
      width: screenSize.width * 0.205,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width / 5.5,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Donated\nAmount',
                      style: cardTitleTextStyle,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          donatedAmountFilterSelectedOption = 'Choose One';
                          donatedAmountMinValue = 0.0;
                          donatedAmountMaxValue = 0.0;
                          donatedAmountValue = 0.0;
                        });
                      },
                      icon: const Icon(Icons.clear),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  title: const Text('Donation Amount'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Money Filter',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.08,
                            height: screenSize.height * 0.05,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: donatedAmountFilterSelectedOption,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              icon: const Icon(Icons.expand_more),
                              iconSize: 24,
                              elevation: 16,
                              onChanged: (String? newValue) {
                                setState(() {
                                  donatedAmountFilterSelectedOption = newValue!;

                                  donatedAmountMinValue = 0.0;
                                  donatedAmountMaxValue = 0.0;
                                  donatedAmountValue = 0.0;
                                });
                              },
                              items: donatedAmountFilter
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    donatedAmountFilterSelectedOption == 'Choose One'
                        ? Container()
                        : donatedAmountFilterSelectedOption == "Between"
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: const Text(
                                            "Min Value",
                                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: const Text(
                                            "Max Value",
                                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: TextField(
                                            style:
                                                const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                            onChanged: (newMinValue) {
                                              setState(() {
                                                donatedAmountMinValue =
                                                    newMinValue.toDouble();
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: TextField(
                                            style:
                                                const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                            onChanged: (newMaxValue) {
                                              setState(() {
                                                donatedAmountMaxValue =
                                                    newMaxValue.toDouble();
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Value",
                                      style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.11,
                                      child: TextField(
                                        style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                        onChanged: (newMaxValue) {
                                          setState(() {
                                            donatedAmountValue =
                                                newMaxValue.toDouble();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height / 50),
            ],
          ),
        ),
      ),
    );
  }

  buildDateFilter(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.5,
      width: screenSize.width * 0.205,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width / 5.5,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: cardTitleTextStyle,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          durationFilterSelectedOption = 'Choose One';
                          durationMinValue = 0.0;
                          durationMaxValue = 0.0;
                          durationValue = 0.0;

                          initialStartDate = "";
                          initialEndDate = "";
                        });
                      },
                      icon: const Icon(Icons.clear),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  title: const Text('Intervention Duration Type'),
                  children: [
                    MultiSelectCheckList(
                      maxSelectableCount: 1,
                      textStyles: const MultiSelectTextStyles(
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                      ),
                      listViewSettings: ListViewSettings(
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                      ),
                      //controller: _controller,
                      items: List.generate(
                        interventionDurationTypeList.length,
                        (index) => CheckListCard(
                          value: interventionDurationTypeList[index],
                          title: Text(interventionDurationTypeList[index]),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected:
                              index == interventionDurationTypeList.length,
                          enabled:
                              !(index == interventionDurationTypeList.length),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            interventionDurationTypeFilterSelectedOption =
                                allSelectedItems[0].toString();
                          } else {
                            interventionDurationTypeFilterSelectedOption =
                                "Choose One";
                          }
                        });
                      },
                      onMaximumSelected: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            interventionDurationTypeFilterSelectedOption =
                                allSelectedItems[0].toString();
                          } else {
                            interventionDurationTypeFilterSelectedOption =
                                "Choose One";
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  title: const Text('Duration Of Intervention'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Duration Filter',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.08,
                            height: screenSize.height * 0.05,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: durationFilterSelectedOption,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              icon: const Icon(Icons.expand_more),
                              iconSize: 24,
                              elevation: 16,
                              onChanged: (String? newValue) {
                                setState(() {
                                  durationFilterSelectedOption = newValue!;

                                  durationMinValue = 0.0;
                                  durationMaxValue = 0.0;
                                  durationValue = 0.0;
                                });
                              },
                              items: numberFilter.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    durationFilterSelectedOption == 'Choose One'
                        ? Container()
                        : durationFilterSelectedOption == "Between"
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: const Text(
                                            "Min Value",
                                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: const Text(
                                            "Max Value",
                                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: TextField(
                                            style:
                                                const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                            onChanged: (newMinValue) {
                                              setState(() {
                                                durationMinValue =
                                                    newMinValue.toDouble();
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.08,
                                          child: TextField(
                                            style:
                                                const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                            onChanged: (newMaxValue) {
                                              setState(() {
                                                durationMaxValue =
                                                    newMaxValue.toDouble();
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Value",
                                      style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.11,
                                      child: TextField(
                                        style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                        onChanged: (newMaxValue) {
                                          setState(() {
                                            durationValue =
                                                newMaxValue.toDouble();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  title: const Text('Date'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.075,
                            child: const Text(
                              "Start Date",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.001),
                          SizedBox(
                            width: screenSize.width * 0.075,
                            child: const Text(
                              "End Date",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: screenSize.height * 0.1,
                            width: screenSize.width * 0.075,
                            alignment: Alignment.centerLeft,
                            child: StatefulBuilder(builder:
                                (BuildContext context, StateSetter dropDownState) {
                              return CupertinoDateTextBox(
                                fontSize: 14.0,
                                initialValue: initialStartDate.isEmptyOrNull
                                    ? DateTime.now()
                                    : DateFormat("yyyy-MM-dd")
                                    .parse(initialStartDate),
                                onDateChange: (DateTime newdate) {
                                  //print(newdate);
                                  setState(() {
                                    initialStartDate =
                                        newdate.toIso8601String();
                                  });
                                },
                                hintText: initialStartDate.isEmptyOrNull
                                    ? DateFormat("EEE, MMM d, yyyy")
                                    .format(DateTime.now())
                                    : initialStartDate,
                              );
                            }),
                          ),
                          SizedBox(width: screenSize.width * 0.001),
                          Container(
                            height: screenSize.height * 0.1,
                            width: screenSize.width * 0.075,
                            alignment: Alignment.centerLeft,
                            child: StatefulBuilder(builder:
                                (BuildContext context, StateSetter dropDownState) {
                              return CupertinoDateTextBox(
                                fontSize: 14.0,
                                initialValue: initialEndDate.isEmptyOrNull
                                    ? DateTime.now()
                                    : DateFormat("yyyy-MM-dd")
                                    .parse(initialEndDate),
                                onDateChange: (DateTime newdate) {
                                  //print(newdate);
                                  setState(() {
                                    initialEndDate =
                                        newdate.toIso8601String();
                                  });
                                },
                                hintText: initialEndDate.isEmptyOrNull
                                    ? DateFormat("EEE, MMM d, yyyy")
                                    .format(DateTime.now())
                                    : initialEndDate,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height / 50),
            ],
          ),
        ),
      ),
    );
  }

  buildLocationFilter(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.5,
      width: screenSize.width * 0.205,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width / 5.5,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Location',
                      style: cardTitleTextStyle,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          localityFilterSelectedOption = [];
                          cityFilterSelectedOption = [];
                          stateFilterSelectedOption = [];
                          provinceFilterSelectedOption = [];
                          regionFilterSelectedOption = [];
                        });
                      },
                      icon: const Icon(Icons.clear),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  title: const Text('Locality'),
                  children: [
                    MultiSelectCheckList(
                      maxSelectableCount: 5,
                      textStyles: const MultiSelectTextStyles(
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                      ),
                      listViewSettings: ListViewSettings(
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                      ),
                      //controller: _controller,
                      items: List.generate(
                        localitiesList.length,
                        (index) => CheckListCard(
                          value: localitiesList[index],
                          title: Text(localitiesList[index]),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected: index == localitiesList.length,
                          enabled: !(index == localitiesList.length),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            localityFilterSelectedOption = allSelectedItems;
                          } else {
                            localityFilterSelectedOption = [];
                          }
                        });
                      },
                      onMaximumSelected: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            localityFilterSelectedOption = allSelectedItems;
                          } else {
                            localityFilterSelectedOption = [];
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  title: const Text('City'),
                  children: [
                    MultiSelectCheckList(
                      maxSelectableCount: 5,
                      textStyles: const MultiSelectTextStyles(
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                      ),
                      listViewSettings: ListViewSettings(
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                      ),
                      //controller: _controller,
                      items: List.generate(
                        cityList.length,
                        (index) => CheckListCard(
                          value: cityList[index],
                          title: Text(cityList[index]),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected: index == cityList.length,
                          enabled: !(index == cityList.length),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            cityFilterSelectedOption = allSelectedItems;
                          } else {
                            cityFilterSelectedOption = [];
                          }
                        });
                      },
                      onMaximumSelected: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            cityFilterSelectedOption = allSelectedItems;
                          } else {
                            cityFilterSelectedOption = [];
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: ExpansionTile(
                  title: const Text('State'),
                  children: [
                    MultiSelectCheckList(
                      maxSelectableCount: 5,
                      textStyles: const MultiSelectTextStyles(
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                      ),
                      listViewSettings: ListViewSettings(
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                      ),
                      //controller: _controller,
                      items: List.generate(
                        stateList.length,
                        (index) => CheckListCard(
                          value: stateList[index],
                          title: Text(stateList[index]),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected: index == stateList.length,
                          enabled: !(index == stateList.length),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            stateFilterSelectedOption = allSelectedItems;
                          } else {
                            stateFilterSelectedOption = [];
                          }
                        });
                      },
                      onMaximumSelected: (allSelectedItems, selectedItem) {
                        setState(() {
                          if (allSelectedItems.isNotEmpty) {
                            stateFilterSelectedOption = allSelectedItems;
                          } else {
                            stateFilterSelectedOption = [];
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height / 50),
            ],
          ),
        ),
      ),
    );
  }

  ///-------------------------- FOR PROGRAMMATIC SIMULATION --------------------------///

  buildProgrammaticSimulation(Size screenSize) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: screenSize.height / 1.3,
        //screenSize.height * projectItems.length * 0.11 + 0.3,
        width: screenSize.width * 0.755,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[],
            ),
          ],
        ),
      ),
    );
  }

  ///-------------------------- FOR INPUT SUMMARY --------------------------///

  buildInputSummary(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.51,
      width: screenSize.width * 0.735,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width * 0.735,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "INPUT SUMMARY",
                style: TextStyle(
                  fontSize: screenSize.width * 0.015,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: screenSize.height * 0.05),
                        Text(
                          "INTERVENTIONS & SDGs",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 2,
                            color: Colors.blue.shade200,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        Row(
                          children: [
                            SizedBox(
                              width: screenSize.width * 0.15,
                              child: Text(
                                "TYPE OF INTERVENTION",
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.008,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.008,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                                children: [
                                  TextSpan(
                                    text: "TYPE OF INTERVENTION",
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.008,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " intervention.",
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.008,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.003),
                        Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.05),
                          child: SizedBox(
                            width: screenSize.width * 0.25,
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.blue.shade600,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.003),
                        Row(
                          children: [
                            SizedBox(
                              width: screenSize.width * 0.15,
                              child: Text(
                                "SUB-THEMATIC AREAS",
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.008,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.008,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                                children: [
                                  TextSpan(
                                    text: "SUB-THEMATIC AREA ",
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.008,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "area.",
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.008,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.003),
                        Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.05),
                          child: SizedBox(
                            width: screenSize.width * 0.25,
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.blue.shade600,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.003),
                        Row(
                          children: [
                            SizedBox(
                              width: screenSize.width * 0.15,
                              child: Text(
                                "SDG",
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.008,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.008,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                                children: [
                                  TextSpan(
                                    text: "SDG.",
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.008,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.003),
                        SizedBox(
                          width: screenSize.width * 0.323,
                          child: const Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.003),
                        Text(
                          "DONATED AMOUNT",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.01,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 2,
                            color: Colors.blue.shade200,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        Row(
                          children: [
                            SizedBox(
                              width: screenSize.width * 0.15,
                              child: Text(
                                "AMOUNT",
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.008,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.008,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                                children: [
                                  TextSpan(
                                    text: "\$ amount",
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.008,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.45,
                    child: const VerticalDivider(
                      width: 50,
                      thickness: 1,
                      color: Colors.black,
                      endIndent: 10,
                      indent: 10,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: screenSize.height * 0.05),
                      Text(
                        "DATE",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.01,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 2,
                          color: Colors.blue.shade200,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: Text(
                              "INTERVENTION DURATION TYPE",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                              children: [
                                TextSpan(
                                  text: "Short/Long",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.008,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                                TextSpan(
                                  text: " Term.",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.008,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.003),
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * 0.05),
                        child: SizedBox(
                          width: screenSize.width * 0.25,
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.003),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                              children: [
                                TextSpan(
                                  text: "3 - 60",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.008,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                                TextSpan(
                                  text: " Months.",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.008,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.003),
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * 0.05),
                        child: SizedBox(
                          width: screenSize.width * 0.25,
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.003),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: Text(
                              "DATE",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                              children: [
                                TextSpan(
                                  text: "Start Date - End Date",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.008,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.003),
                      SizedBox(
                        width: screenSize.width * 0.32,
                        child: const Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.003),
                      Text(
                        "LOCATION",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.01,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 2,
                          color: Colors.blue.shade200,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: Text(
                              "LOCALITY",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                              children: [
                                TextSpan(
                                  text: "Khartoum",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.008,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.003),
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * 0.05),
                        child: SizedBox(
                          width: screenSize.width * 0.25,
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.003),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: Text(
                              "CITY",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                              children: [
                                TextSpan(
                                  text: "Khartoum",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.008,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.003),
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * 0.05),
                        child: SizedBox(
                          width: screenSize.width * 0.25,
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.003),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: Text(
                              "STATE",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: screenSize.width * 0.008,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                              children: [
                                TextSpan(
                                  text: "Khartoum",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.008,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///-------------------------- FOR BUDGET HEALTH CHART --------------------------///

  buildBudgetHealth(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.5,
      width: screenSize.width * 0.735,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width * 0.735,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenSize.width * 0.33,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "BUDGET DISTRIBUTION",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.015,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenSize.width * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: screenSize.height * 0.005),
                          Center(
                            child: Text(
                              "The donated amount will be divided into the money used for the overhead and the remaining money that will be used to obtain the outcome wanted.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue.shade200,
                                fontSize: screenSize.width * 0.01,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.05),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.08,
                                child: Text(
                                  "OVERHEAD",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.01,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.008,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "OVER HEAD AMOUNT ",
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.008,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "overhead.",
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.008,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenSize.height * 0.05),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.08,
                                child: Text(
                                  "REMAINING",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.01,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.008,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "REMAINING AMOUNT ",
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.008,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "remaining amount.",
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.008,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenSize.height * 0.2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: screenSize.width * 0.35,
                child: SfCircularChart(
                  //tooltipBehavior: _tooltipBehavior,
                  legend: Legend(
                    position: LegendPosition.bottom,
                    isVisible: true,
                    isResponsive: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<BudgetChartData, String>(
                      dataSource: budgetChartData,
                      // pointColorMapper: (BudgetChartData data, _) => data.color,
                      xValueMapper: (BudgetChartData data, _) => data.x,
                      yValueMapper: (BudgetChartData data, _) => data.y,
                      // Radius of doughnut's inner circle
                      innerRadius: '80%',
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        // Positioning the data label
                        labelPosition: ChartDataLabelPosition.outside,
                      ),
                      enableTooltip: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///-------------------------- FOR RECOMMENDATION --------------------------///

  buildRecommendation1(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.51,
      width: screenSize.width * 0.735,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width * 0.735,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "RECOMMENDATION BASED ON INPUT",
                style: TextStyle(
                  fontSize: screenSize.width * 0.015,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Center(
                child: Text(
                  "The first recommendation is based on all the inputted information and what the outcome might be.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue.shade200,
                    fontSize: screenSize.width * 0.01,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildRecommendation2(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.51,
      width: screenSize.width * 0.735,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width * 0.735,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "RECOMMENDATION BASED ON LOCATION CHOSEN",
                style: TextStyle(
                  fontSize: screenSize.width * 0.015,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Center(
                child: Text(
                  "The second recommendation is based on almost all the inputted information with the\nexception of changing the sub-thematic area to obtain the best outcome possible for the chosen location.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue.shade200,
                    fontSize: screenSize.width * 0.01,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildRecommendation3(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.51,
      width: screenSize.width * 0.735,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width * 0.735,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "RECOMMENDATION BASED ON SUB-THEMATIC AREA CHOSEN",
                style: TextStyle(
                  fontSize: screenSize.width * 0.015,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Center(
                child: Text(
                  "The third recommendation is based on almost all the inputted information with the\nexception of changing the location to obtain the best outcome possible for the chosen sub-thematic area.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue.shade200,
                    fontSize: screenSize.width * 0.01,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildRecommendation4(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.51,
      width: screenSize.width * 0.735,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width * 0.735,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "RECOMMENDATION BASED ON EMERGING ISSUES",
                style: TextStyle(
                  fontSize: screenSize.width * 0.015,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Center(
                child: Text(
                  "The fourth recommendation is based on the risk assessments\ndone to determine the most type of interventions need per geographical area.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue.shade200,
                    fontSize: screenSize.width * 0.01,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  ///-------------------------- FOR RISK ANALYSIS --------------------------///

  buildRiskAnalysis(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.51,
      width: screenSize.width * 0.735,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width * 0.735,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "RISK ANALYSIS",
                style: TextStyle(
                  fontSize: screenSize.width * 0.015,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Center(
                child: Text(
                  "Here you will find the risk analysis for the chosen inputs.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue.shade200,
                    fontSize: screenSize.width * 0.01,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///-------------------------- FOR NEWS FEEDBACK --------------------------///

  buildNewsFeedBack(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.51,
      width: screenSize.width * 0.735,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width * 0.735,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "NEWS",
                style: TextStyle(
                  fontSize: screenSize.width * 0.015,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Center(
                child: Text(
                  "Here you will find some new about the current issues.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue.shade200,
                    fontSize: screenSize.width * 0.01,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


///------------------------------- COMPONENTS -------------------------------///

class BudgetChartData {
  BudgetChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}
