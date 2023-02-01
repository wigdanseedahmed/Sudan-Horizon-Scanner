import 'package:nb_utils/nb_utils.dart';
import 'package:sudan_horizon_scanner/imports.dart';

export 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

class ProgrammaticSimulationHomeScreenWS extends StatefulWidget {
  const ProgrammaticSimulationHomeScreenWS({Key? key}) : super(key: key);

  @override
  State<ProgrammaticSimulationHomeScreenWS> createState() =>
      _ProgrammaticSimulationHomeScreenWSState();
}

class _ProgrammaticSimulationHomeScreenWSState
    extends State<ProgrammaticSimulationHomeScreenWS> {
  /// Filter Variables

  List localityFilterSelectedOption = [];
  List cityFilterSelectedOption = [];
  List stateFilterSelectedOption = [];
  List provinceFilterSelectedOption = [];
  List regionFilterSelectedOption = [];


  String initialStartDate = "";
  String initialEndDate= "";

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

  /// VARIABLES FOR STEPPER

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  late Color _activeColor;
  Color? _inactiveColor = Colors.grey[100];
  late double lineWidth = 4.0;

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
                          SizedBox(
                            height: screenSize.height,
                            child: Stepper(
                              elevation: 0.0,
                              type: stepperType,
                              physics: const ScrollPhysics(),
                              currentStep: _currentStep,
                              onStepTapped: (step) => tapped(step),
                              onStepContinue: continued,
                              onStepCancel: cancel,
                              steps: <Step>[
                                Step(
                                  title: Text(
                                    'Interventions\n & SDGs',
                                    style: cardTitleTextStyle,
                                  ),
                                  content: Center(
                                    child: SizedBox(
                                      width: screenSize.width * 0.5,
                                      child:
                                          buildInterventionsAndSDG(screenSize),
                                    ),
                                  ),
                                  isActive: _currentStep >= 0,
                                  state: _currentStep >= 0
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                                Step(
                                  title: Text(
                                    'Donated Amount',
                                    style: cardTitleTextStyle,
                                  ),
                                  content: Center(
                                    child: SizedBox(
                                      width: screenSize.width * 0.5,
                                      child:
                                          buildDonatedAmountFilter(screenSize),
                                    ),
                                  ),
                                  isActive: _currentStep >= 1,
                                  state: _currentStep >= 1
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                                Step(
                                  title: Text(
                                    'Date',
                                    style: cardTitleTextStyle,
                                  ),
                                  content: Center(
                                    child: SizedBox(
                                      width: screenSize.width * 0.5,
                                      child: buildDateFilter(screenSize),
                                    ),
                                  ),
                                  isActive: _currentStep >= 2,
                                  state: _currentStep >= 2
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                                Step(
                                  title: Text(
                                    'Location',
                                    style: cardTitleTextStyle,
                                  ),
                                  content: Center(
                                    child: SizedBox(
                                      width: screenSize.width * 0.5,
                                      child: buildLocationFilter(screenSize),
                                    ),
                                  ),
                                  isActive: _currentStep >= 3,
                                  state: _currentStep >= 3
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                              ],
                            ),
                          ),
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

  buildInterventionsAndSDG(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.5,
      width: screenSize.width * 0.205,
      child: Material(
        elevation: 8,
        shadowColor: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width * 0.4,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(height: screenSize.height * 0.03),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
                child: Material(
                  elevation: 2.0,
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
                          height: screenSize.height * 0.01,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.1),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
                child: Material(
                  elevation: 2.0,
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
              ),
              SizedBox(height: screenSize.height * 0.1),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
                child: Material(
                  elevation: 2.0,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildDonatedAmountFilter(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.5,
      width: screenSize.width * 0.205,
      child: Material(
        elevation: 10,
        shadowColor: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width / 5.5,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.05,
                    right: screenSize.width * 0.05,
                    top: screenSize.height * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Money Filter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.25,
                      height: screenSize.height * 0.05,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: donatedAmountFilterSelectedOption,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        underline:
                            Container(height: 0.8, color: Colors.black45),
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
                            .map<DropdownMenuItem<String>>((String value) {
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
                          padding: EdgeInsets.only(
                              left: screenSize.width * 0.05,
                              right: screenSize.width * 0.05,
                              top: screenSize.height * 0.1),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: screenSize.width * 0.15,
                                    child: const Text(
                                      "Min Value",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.15,
                                    child: const Text(
                                      "Max Value",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                                    width: screenSize.width * 0.15,
                                    child: TextField(
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                                    width: screenSize.width * 0.15,
                                    child: TextField(
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                          padding: EdgeInsets.only(
                              left: screenSize.width * 0.05,
                              right: screenSize.width * 0.05,
                              top: screenSize.height * 0.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Value",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.25,
                                child: TextField(
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
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
        shadowColor: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width / 5.5,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.05,
                    right: screenSize.width * 0.05,
                    top: screenSize.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Intervention Contract Term',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.2,
                      height: screenSize.height * 0.05,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value:  interventionDurationTypeFilterSelectedOption,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        underline:
                        Container(height: 0.8, color: Colors.black45),
                        icon: const Icon(Icons.expand_more),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            if (newValue.isEmptyOrNull) {
                              interventionDurationTypeFilterSelectedOption = "Choose One";
                            } else {
                              interventionDurationTypeFilterSelectedOption = newValue!;
                            }
                          });
                        },
                        items: interventionDurationTypeList.map<DropdownMenuItem<String>>((String value) {
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
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.05,
                    right: screenSize.width * 0.05,
                    top: screenSize.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Duration Of Intervention',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.2,
                      height: screenSize.height * 0.05,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: durationFilterSelectedOption,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        underline:
                            Container(height: 0.8, color: Colors.black45),
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
                        items: numberFilter
                            .map<DropdownMenuItem<String>>((String value) {
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
                          padding: EdgeInsets.only(
                              left: screenSize.width * 0.05,
                              right: screenSize.width * 0.05),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: screenSize.width * 0.15,
                                    child: const Text(
                                      "Min Value",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.15,
                                    child: const Text(
                                      "Max Value",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                                    width: screenSize.width * 0.15,
                                    child: TextField(
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                                    width: screenSize.width * 0.15,
                                    child: TextField(
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                          padding: EdgeInsets.only(
                              left: screenSize.width * 0.05,
                              right: screenSize.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Value",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: TextField(
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onChanged: (newMaxValue) {
                                    setState(() {
                                      durationValue = newMaxValue.toDouble();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.05,
                    right: screenSize.width * 0.05,
                    top: screenSize.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.15,
                      child: const Text(
                        "Start Date",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.001),
                    SizedBox(
                      width: screenSize.width * 0.15,
                      child: const Text(
                        "End Date",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.05,
                    right: screenSize.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.15,
                      alignment: Alignment.centerLeft,
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter dropDownState) {
                        return CupertinoDateTextBox(
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
                      width: screenSize.width * 0.15,
                      alignment: Alignment.centerLeft,
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter dropDownState) {
                        return CupertinoDateTextBox(
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
        shadowColor: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: screenSize.width / 5.5,
          color: Colors.white,
          child: ListView(
            children: <Widget>[

              SizedBox(height: screenSize.height * 0.03),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
                child: Material(
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
              ),
              SizedBox(height: screenSize.height * 0.1),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
                child: Material(
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
              ),
              SizedBox(height: screenSize.height * 0.1),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
                child: Material(
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
              ),
              SizedBox(height: screenSize.height / 50),
            ],
          ),
        ),
      ),
    );
  }

  ///-------------------------- FOR STEPPER --------------------------///

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
         ProgrammaticSimulationScreenWS(
           localityFilterSelectedOption: localityFilterSelectedOption,
           cityFilterSelectedOption: cityFilterSelectedOption,
           stateFilterSelectedOption: stateFilterSelectedOption,
           provinceFilterSelectedOption: provinceFilterSelectedOption,
           regionFilterSelectedOption: regionFilterSelectedOption,
           initialStartDate: initialStartDate,
           initialEndDate: initialEndDate,
           portfolioAffiliationFilterSelectedOption: portfolioAffiliationFilterSelectedOption,
           interventionDurationTypeFilterSelectedOption: interventionDurationTypeFilterSelectedOption,
           isOtherPortfolioAffiliationSelected: isOtherPortfolioAffiliationSelected,
           subThematicAreasFilterSelectedOption: subThematicAreasFilterSelectedOption,
           languageSelectedOption: languageSelectedOption,
           sdgSelectedOption: sdgSelectedOption,
           donatedAmountFilterSelectedOption: donatedAmountFilterSelectedOption,
           donatedAmountMinValue: donatedAmountMinValue,
           donatedAmountMaxValue: donatedAmountMaxValue,
           donatedAmountValue: donatedAmountValue,
           durationFilterSelectedOption: durationFilterSelectedOption,
           durationMinValue: durationMinValue,
           durationMaxValue: durationMaxValue,
           durationValue: durationValue,
        ),
      ),
    );
  }

  cancel() {
    if(_currentStep > 0) {
      setState(() => _currentStep -= 1);
    } else {
      localityFilterSelectedOption = [];
      cityFilterSelectedOption = [];
      stateFilterSelectedOption = [];
      provinceFilterSelectedOption = [];
      regionFilterSelectedOption = [];

      initialStartDate = "";
      initialEndDate = "";

      portfolioAffiliationFilterSelectedOption = [];

      interventionDurationTypeFilterSelectedOption = "Choose One";

      isOtherPortfolioAffiliationSelected = false;

      subThematicAreasFilterSelectedOption = [];

      languageSelectedOption = [];

      sdgSelectedOption = [];

      donatedAmountFilterSelectedOption = 'Choose One';
      donatedAmountMinValue = 0.0;
      donatedAmountMaxValue = 0.0;
      donatedAmountValue = 0.0;

      durationFilterSelectedOption = 'Choose One';
      durationMinValue = 0.0;
      durationMaxValue = 0.0;
      durationValue = 0.0;
    }
  }
}



class NumberStepper extends StatelessWidget {
  final double width;
  final totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;
  NumberStepper({
    Key? key,
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
  })  : assert(curStep > 0 == true && curStep <= totalSteps + 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        left: 24.0,
        right: 24.0,
      ),
      width: this.width,
      child: Row(
        children: _steps(),
      ),
    );
  }

  getCircleColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep)
      color = currentStepColor;
    else
      color = Colors.white;
    return color;
  }

  getBorderColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep)
      color = currentStepColor;
    else
      color = inactiveColor;

    return color;
  }

  getLineColor(i) {
    var color =
    curStep > i + 1 ? Colors.blue.withOpacity(0.4) : Colors.grey[200];
    return color;
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        Container(
          width: 28.0,
          height: 28.0,
          child: getInnerElementOfStepper(i),
          decoration: new BoxDecoration(
            color: circleColor,
            borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
            border: new Border.all(
              color: borderColor,
              width: 1.0,
            ),
          ),
        ),
      );

      //line between step circles
      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              height: lineWidth,
              color: lineColor,
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget getInnerElementOfStepper(index) {
    if (index + 1 < curStep) {
      return Icon(
        Icons.check,
        color: Colors.white,
        size: 16.0,
      );
    } else if (index + 1 == curStep) {
      return Center(
        child: Text(
          '$curStep',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      );
    } else
      return Container();
  }
}
