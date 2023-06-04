import 'package:sudan_horizon_scanner/imports.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;

class TextAnalysisWidget extends StatefulWidget {

  final List<IssueOfMonthDataModel> finalSearchList;


  const TextAnalysisWidget({
    Key? key, required this.finalSearchList,
  }) : super(key: key);

  @override
  State<TextAnalysisWidget> createState() => _TextAnalysisWidgetState();
}

List<IssueOfMonthDataModel> _paginatedFinalSearchListData = [];

int _rowsPerPage = 10;

class _TextAnalysisWidgetState extends State<TextAnalysisWidget> {
  static const double dataPagerHeight = 70.0;
  bool showLoadingIndicator = false;
  double pageCount = 0;


  List<IssueOfMonthDataModel> dataSearchList = <IssueOfMonthDataModel>[];

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dataSearchList = widget.finalSearchList;
      pageCount = (widget.finalSearchList.length / _rowsPerPage).ceilToDouble();

    });


    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    showLoadingIndicator = false;
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return buildDataContentPerSource(screenSize);
  }


  buildDataContentPerSource(Size screenSize) {

    pageCount = (dataSearchList.length / _rowsPerPage).ceilToDouble();

    return SizedBox(
      height: screenSize.height  * 0.9,
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              child: loadListView(constraint, screenSize),
            ),
            SizedBox(
              height: dataPagerHeight,
              child: SfDataPager(
                // key: PageStorageKey(dataSearchList),
                  pageCount: pageCount,
                  onPageNavigationStart: (pageIndex) {
                    setState(() {
                      showLoadingIndicator = true;
                    });
                  },
                  onPageNavigationEnd: (pageIndex) {
                    setState(() {
                      showLoadingIndicator = false;
                    });
                  },
                  delegate: CustomSliverChildBuilderDelegate(indexBuilder, dataSearchList)
                    ..addListener(rebuildList)),
            )
          ],
        );
      }),
    );
  }


  void rebuildList() {
    setState(() {});
  }

  Widget loadListView(BoxConstraints constraints, Size screenSize) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_paginatedFinalSearchListData.isNotEmpty) {
        stackChildren.add(
          ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: CustomSliverChildBuilderDelegate(
              indexBuilder,
                widget.finalSearchList
            ),
          ),
        );
      }

      if (showLoadingIndicator) {
        stackChildren.add(
          Container(
            color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      }

      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }


  Widget indexBuilder(BuildContext context, int index) {
    var screenSize = MediaQuery.of(context).size;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth,
            height: screenSize.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.25,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(
                            _paginatedFinalSearchListData[index].source ==
                                null
                                ? ""
                                : _paginatedFinalSearchListData[index]
                                .source!
                                .substring(0, 2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_paginatedFinalSearchListData[index]
                              .source ==
                              null
                              ? ""
                              : _paginatedFinalSearchListData[index].source!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.08,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _paginatedFinalSearchListData[index].issueString ==
                            null
                            ? ""
                            : _paginatedFinalSearchListData[index]
                            .issueString!,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedFinalSearchListData[index].repetition ==
                            null
                            ? ""
                            : '${_paginatedFinalSearchListData[index].repetition.toString()} K',
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _paginatedFinalSearchListData[index]
                            .sentimentAnalysis ==
                            null
                            ? ""
                            : _paginatedFinalSearchListData[index]
                            .sentimentAnalysis!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 60,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _paginatedFinalSearchListData[index]
                          .sentimentAnalysis ==
                          "Negative"
                          ? Colors.red
                          : _paginatedFinalSearchListData[index]
                          .sentimentAnalysis ==
                          "Neutral"
                          ? Colors.yellow
                          : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomSliverChildBuilderDelegate extends SliverChildBuilderDelegate
    with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegate(builder, this.finalSearchList)
      : super(builder);

  final List<IssueOfMonthDataModel> finalSearchList;


  @override
  int get childCount => finalSearchList.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * _rowsPerPage;
    int endRowIndex = startRowIndex + _rowsPerPage;

    if (endRowIndex > finalSearchList.length) {
      endRowIndex = finalSearchList.length - 1;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedFinalSearchListData = finalSearchList
        .getRange(startRowIndex, endRowIndex)
        .toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegate oldDelegate) {
    return true;
  }
}


