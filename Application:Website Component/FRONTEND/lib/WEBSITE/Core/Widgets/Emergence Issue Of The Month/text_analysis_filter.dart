import 'package:nb_utils/nb_utils.dart';
import 'package:sudan_horizon_scanner/imports.dart';

class TextAnalysisFilterWS extends StatefulWidget {
  const TextAnalysisFilterWS({
    Key? key,
  }) : super(key: key);

  @override
  State<TextAnalysisFilterWS> createState() => _TextAnalysisFilterWSState();
}

class _TextAnalysisFilterWSState extends State<TextAnalysisFilterWS> {
  /// Filter Variables

  var sourceFilterSelectedOption = [];

  var sentimentAnalysisFilterSelectedOption = [];

  var numberFilterSelectedOption = 'Choose One';
  var minValue = 0.0;
  var maxValue = 0.0;
  var value = 0.0;

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  // late List<MapModel> _data;

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

    return buildFilter(screenSize);
  }

   buildFilter(Size screenSize) {
    return SizedBox(
    height: screenSize.height * 0.77,
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
                    'Filter',
                    style: cardTitleTextStyle,
                  ),
                  IconButton(
                      onPressed: () {
                        sourceFilterSelectedOption = [];

                        sentimentAnalysisFilterSelectedOption = [];

                        numberFilterSelectedOption = 'Choose One';
                        minValue = 0.0;
                        maxValue = 0.0;
                        value = 0.0;
                      },
                      icon: const Icon(Icons.clear))
                ],
              ),
            ),
            const SizedBox(height: 30),
            Material(
              elevation: 8.0,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(4),
              child: ExpansionTile(
                title: const Text('Source'),
                children: [
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                  ExpansionTile(
                    title: Text(qualitativeDataSourceList[0]),
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
                          socialMediaDataSource.length,
                              (index) => CheckListCard(
                            value: socialMediaDataSource[index],
                            title: Text(socialMediaDataSource[index]),
                            selectedColor: Colors.white,
                            checkColor: Colors.indigo,
                            selected: index == socialMediaDataSource.length,
                            enabled: !(index == socialMediaDataSource.length),
                            checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                        onMaximumSelected: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                      ),
                    ],
                  ),
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                  ExpansionTile(
                    title: Text(qualitativeDataSourceList[1]),
                    children: const [
                      /*MultiSelectCheckList(
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
                          socialMediaDataSource.length,
                              (index) => CheckListCard(
                            value: socialMediaDataSource[index],
                            title: Text(socialMediaDataSource[index]),
                            selectedColor: Colors.white,
                            checkColor: Colors.indigo,
                            selected: index == socialMediaDataSource.length,
                            enabled: !(index == socialMediaDataSource.length),
                            checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                        onMaximumSelected: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                      ),*/
                    ],
                  ),
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                   ExpansionTile(
                    title: Text(qualitativeDataSourceList[2]),
                    children: const [
                      /*MultiSelectCheckList(
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
                          socialMediaDataSource.length,
                              (index) => CheckListCard(
                            value: socialMediaDataSource[index],
                            title: Text(socialMediaDataSource[index]),
                            selectedColor: Colors.white,
                            checkColor: Colors.indigo,
                            selected: index == socialMediaDataSource.length,
                            enabled: !(index == socialMediaDataSource.length),
                            checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                        onMaximumSelected: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                      ),*/
                    ],
                  ),
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                   ExpansionTile(
                    title: Text(qualitativeDataSourceList[3]),
                    children: const [
                      /*MultiSelectCheckList(
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
                          socialMediaDataSource.length,
                              (index) => CheckListCard(
                            value: socialMediaDataSource[index],
                            title: Text(socialMediaDataSource[index]),
                            selectedColor: Colors.white,
                            checkColor: Colors.indigo,
                            selected: index == socialMediaDataSource.length,
                            enabled: !(index == socialMediaDataSource.length),
                            checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                        onMaximumSelected: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                      ),*/
                    ],
                  ),
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                  ExpansionTile(
                    title: Text(qualitativeDataSourceList[4]),
                    children: const [
                      /*MultiSelectCheckList(
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
                          socialMediaDataSource.length,
                              (index) => CheckListCard(
                            value: socialMediaDataSource[index],
                            title: Text(socialMediaDataSource[index]),
                            selectedColor: Colors.white,
                            checkColor: Colors.indigo,
                            selected: index == socialMediaDataSource.length,
                            enabled: !(index == socialMediaDataSource.length),
                            checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                        onMaximumSelected: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                      ),*/
                    ],
                  ),
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                  ExpansionTile(
                    title: Text(qualitativeDataSourceList[5]),
                    children: const [
                      /*MultiSelectCheckList(
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
                          socialMediaDataSource.length,
                              (index) => CheckListCard(
                            value: socialMediaDataSource[index],
                            title: Text(socialMediaDataSource[index]),
                            selectedColor: Colors.white,
                            checkColor: Colors.indigo,
                            selected: index == socialMediaDataSource.length,
                            enabled: !(index == socialMediaDataSource.length),
                            checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                        onMaximumSelected: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                      ),*/
                    ],
                  ),
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                  ExpansionTile(
                    title: Text(qualitativeDataSourceList[6]),
                    children: const [
                      /*MultiSelectCheckList(
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
                          socialMediaDataSource.length,
                              (index) => CheckListCard(
                            value: socialMediaDataSource[index],
                            title: Text(socialMediaDataSource[index]),
                            selectedColor: Colors.white,
                            checkColor: Colors.indigo,
                            selected: index == socialMediaDataSource.length,
                            enabled: !(index == socialMediaDataSource.length),
                            checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                        onMaximumSelected: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                      ),*/
                    ],
                  ),
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                  ExpansionTile(
                    title: Text(qualitativeDataSourceList[7]),
                    children: const [
                      /*MultiSelectCheckList(
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
                          socialMediaDataSource.length,
                              (index) => CheckListCard(
                            value: socialMediaDataSource[index],
                            title: Text(socialMediaDataSource[index]),
                            selectedColor: Colors.white,
                            checkColor: Colors.indigo,
                            selected: index == socialMediaDataSource.length,
                            enabled: !(index == socialMediaDataSource.length),
                            checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                        onMaximumSelected: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                      ),*/
                    ],
                  ),
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                  ExpansionTile(
                    title: Text(qualitativeDataSourceList[8]),
                    children: const [
                      /*MultiSelectCheckList(
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
                          socialMediaDataSource.length,
                              (index) => CheckListCard(
                            value: socialMediaDataSource[index],
                            title: Text(socialMediaDataSource[index]),
                            selectedColor: Colors.white,
                            checkColor: Colors.indigo,
                            selected: index == socialMediaDataSource.length,
                            enabled: !(index == socialMediaDataSource.length),
                            checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                        onMaximumSelected: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                      ),*/
                    ],
                  ),
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                  ExpansionTile(
                    title: Text(qualitativeDataSourceList[9]),
                    children: const [
                      /*MultiSelectCheckList(
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
                          socialMediaDataSource.length,
                              (index) => CheckListCard(
                            value: socialMediaDataSource[index],
                            title: Text(socialMediaDataSource[index]),
                            selectedColor: Colors.white,
                            checkColor: Colors.indigo,
                            selected: index == socialMediaDataSource.length,
                            enabled: !(index == socialMediaDataSource.length),
                            checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                        onMaximumSelected: (allSelectedItems, selectedItem) {
                          setState(() {
                            sourceFilterSelectedOption.add(allSelectedItems);
                          });
                        },
                      ),*/
                    ],
                  ),
                  Container(height: screenSize.height * 0.01, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Material(
              elevation: 8.0,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(4),
              child: ExpansionTile(
                title: const Text('Sentiment Analysis'),
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
                        value: qualitativeDataSourceList[index],
                        title: Text(sentimentAnalysisFilter[index]),
                        selectedColor: Colors.white,
                        checkColor: Colors.indigo,
                        selected:
                            index == sentimentAnalysisFilter.length,
                        enabled:
                            !(index == sentimentAnalysisFilter.length),
                        checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onChange: (allSelectedItems, selectedItem) {
                      setState(() {
                        sentimentAnalysisFilterSelectedOption
                            .add(allSelectedItems);
                      });
                    },
                    onMaximumSelected: (allSelectedItems, selectedItem) {
                      setState(() {
                        sentimentAnalysisFilterSelectedOption
                            .add(allSelectedItems);
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
                title: const Text('Repetition'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Number Filter',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.08,
                          height: screenSize.height * 0.05,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: numberFilterSelectedOption,
                            style: const TextStyle(fontSize: 12),
                            icon: const Icon(Icons.expand_more),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                numberFilterSelectedOption = newValue!;

                                minValue = 0.0;
                                maxValue = 0.0;
                                value = 0.0;
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
                  numberFilterSelectedOption == 'Choose One'
                      ? Container()
                      : numberFilterSelectedOption == "Between"
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
                                          style:
                                              const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenSize.width * 0.08,
                                        child: const Text(
                                          "Max Value",
                                          style: TextStyle(fontSize: 12),
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
                                              const TextStyle(fontSize: 12),
                                          onChanged: (newMinValue) {
                                            setState(() {
                                              minValue =
                                                  newMinValue.toDouble();
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenSize.width * 0.08,
                                        child: TextField(
                                          style:
                                              const TextStyle(fontSize: 12),
                                          onChanged: (newMaxValue) {
                                            setState(() {
                                              maxValue =
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
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.11,
                                    child: TextField(
                                      style: const TextStyle(fontSize: 12),
                                      onChanged: (newMaxValue) {
                                        setState(() {
                                          value = newMaxValue.toDouble();
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
                title: const Text('Language'),
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
                      languageFilter.length,
                          (index) => CheckListCard(
                        value: languageFilter[index],
                        title: Text(languageFilter[index]),
                        selectedColor: Colors.white,
                        checkColor: Colors.indigo,
                        selected:
                        index == languageFilter.length,
                        enabled:
                        !(index == languageFilter.length),
                        checkBoxBorderSide:
                        const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onChange: (allSelectedItems, selectedItem) {
                      setState(() {
                        sentimentAnalysisFilterSelectedOption
                            .add(allSelectedItems);
                      });
                    },
                    onMaximumSelected: (allSelectedItems, selectedItem) {
                      setState(() {
                        sentimentAnalysisFilterSelectedOption
                            .add(allSelectedItems);
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
                        selected:
                        index == sdgGoalsList!.length,
                        enabled:
                        !(index == sdgGoalsList!.length),
                        checkBoxBorderSide:
                        const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onChange: (allSelectedItems, selectedItem) {
                      setState(() {
                        sentimentAnalysisFilterSelectedOption
                            .add(allSelectedItems);
                      });
                    },
                    onMaximumSelected: (allSelectedItems, selectedItem) {
                      setState(() {
                        sentimentAnalysisFilterSelectedOption
                            .add(allSelectedItems);
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
  }

  void _scrollToSelectedContent(
      bool isExpanded, double previousOffset, int index, GlobalKey myKey) {
    final keyContext = myKey.currentContext;

    if (keyContext != null) {
      // make sure that your widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      _scrollController.animateTo(
          isExpanded ? (box.size.height * index) : previousOffset,
          duration: Duration(milliseconds: 500),
          curve: Curves.linear);
    }
  }
}
