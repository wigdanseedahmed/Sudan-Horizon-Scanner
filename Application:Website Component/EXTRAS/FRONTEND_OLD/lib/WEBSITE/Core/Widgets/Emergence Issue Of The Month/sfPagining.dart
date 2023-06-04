import 'package:sudan_horizon_scanner/imports.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataPagerWithListView extends StatefulWidget {
  @override
  _DataPagerWithListView createState() => _DataPagerWithListView();
}

List<PagingProduct> _paginatedIssuesOfTheMonthData = [];

List<PagingProduct> _issuesOfTheMonth = [];
int rowsPerPage = 10;

class _DataPagerWithListView extends State<DataPagerWithListView> {
  static const double dataPagerHeight = 70.0;
  bool showLoadingIndicator = false;
  double pageCount = 0;

  @override
  void initState() {
    super.initState();
    _issuesOfTheMonth = List.from(populateData());
    pageCount = (_issuesOfTheMonth.length / rowsPerPage).ceilToDouble();
  }

  void rebuildList() {
    setState(() {});
  }

  Widget loadListView(BoxConstraints constraints) {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];

      if (_issuesOfTheMonth.isNotEmpty) {
        stackChildren.add(ListView.custom(
            childrenDelegate: CustomSliverChildBuilderDelegate(indexBuilder)));
      }

      if (showLoadingIndicator) {
        stackChildren.add(Container(
          color: Colors.black12,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ));
      }
      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
        bottom: true,
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Fruits'),
          ),
          body: LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                Container(
                  height: constraint.maxHeight - dataPagerHeight,
                  child: loadListView(constraint),
                ),
                Container(
                  height: dataPagerHeight,
                  child: SfDataPager(
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
                      delegate:
                      CustomSliverChildBuilderDelegate(indexBuilder)
                        ..addListener(rebuildList)),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget indexBuilder(BuildContext context, int index) {
    final PagingProduct data = _paginatedIssuesOfTheMonthData[index];
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: LayoutBuilder(
        builder: (context, constraint) {
          return Container(
              width: constraint.maxWidth,
              height: 100,
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(data.image!, width: 100, height: 100),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 5, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: constraint.maxWidth - 130,
                          child: Text(data.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  fontSize: 15)),
                        ),
                        Container(
                          width: constraint.maxWidth - 130,
                          child: Text(data.weight!,
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 10)),
                        ),
                        Container(
                          width: constraint.maxWidth - 130,
                          child: Row(
                            children: [
                              Container(
                                color: Colors.green.shade900,
                                padding: EdgeInsets.all(3),
                                child: Row(
                                  children: [
                                    Text('${data.reviewValue}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13)),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('${data.ratings}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 11))
                            ],
                          ),
                        ),
                        Container(
                          width: constraint.maxWidth - 130,
                          child: Row(
                            children: [
                              Container(
                                child: Text('\$${data.price}',
                                    style: TextStyle(
                                        color: Colors.green.shade800,
                                        fontSize: 13)),
                              ),
                              SizedBox(width: 8),
                              Text('${data.offer}',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 10))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}

class CustomSliverChildBuilderDelegate extends SliverChildBuilderDelegate
    with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegate(builder) : super(builder);

  @override
  int get childCount => _paginatedIssuesOfTheMonthData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startRowIndex = newPageIndex * rowsPerPage;
    int endRowIndex = startRowIndex + rowsPerPage;

    if (endRowIndex > _issuesOfTheMonth.length) {
      endRowIndex = _issuesOfTheMonth.length - 1;
    }

    await Future.delayed(Duration(milliseconds: 2000));
    _paginatedIssuesOfTheMonthData =
        _issuesOfTheMonth.getRange(startRowIndex, endRowIndex).toList(growable: false);
    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegate oldDelegate) {
    return true;
  }
}


///-------------------------------


final PagingProductRepository pagingProductRepository =
PagingProductRepository();

List<PagingProduct> populateData() {
  final List<PagingProduct> pagingProducts = [];
  var index = 0;
  for (int i = 0; i < pagingProductRepository.names.length; i++) {
    if (index == 21) index = 0;

    var p = new PagingProduct(
        name: pagingProductRepository.names[i],
        price: pagingProductRepository.prices[i],
        image: 'images/${pagingProductRepository.names1[i % 22] + '.jpg'}',
        offer: pagingProductRepository.offer[i],
        ratings: pagingProductRepository.ratings[i],
        reviewValue: pagingProductRepository.reviewValue[i],
        weight: pagingProductRepository.weights[i]);

    index++;
    pagingProducts.add(p);
  }

  return pagingProducts;
}

///-------------------------------

class PagingProduct {
  PagingProduct(
      {this.name,
        this.ratings,
        this.image,
        this.weight,
        this.price,
        this.offer,
        this.reviewValue});

  final String? name;

  final String? ratings;

  final String? image;

  final String? weight;

  final double? price;

  final String? offer;

  final double? reviewValue;
}


class PagingProductRepository {
  List<String> names = [
    'Fuji Apple',
    'Honey Banana',
    'Hawaiian Papaya',
    'Lime',
    'Pomegranate',
    'Mandarin Orange',
    'Watermelon',
    'Apricot',
    'Black Grapes',
    'Redrose Cherry',
    'Avacado',
    'Organic Dragon',
    'Asian Guava',
    'Kesar Mango',
    'Organic Lemon',
    'Bluberry',
    'Jackfruit',
    'Fuzzy Kiwi',
    'Peaches',
    'Pineapple',
    'Strawberry',
    'Rasberry',
    'Gala Apple',
    'Saba Banana',
    'Red Papaya',
    'Key Lime',
    'Pomegranate',
    'Blood Orange',
    'Watermelon',
    'Apium Apricot',
    'Fresh Grapes',
    'Bing Cherry',
    'Avacado',
    'Dragon',
    'Guava',
    'Fresh Mango',
    'Lemon',
    'Bluberry',
    'Jackfruit',
    'Fuzzy Kiwi',
    'Gala Peaches',
    'Fresh Pineapple',
    'Red Strawberry',
    'Rasberry',
    'Apple',
    'Banana',
    'Marsh Papaya',
    'Key Lime',
    'Fresh Pomegranate',
    'Manddarin Orange',
    'Fresh Watermelon',
    'Dried Apricot',
    'Black Grapes',
    'Redrose Cherry',
    'Asian Avacado',
    'Dragon',
    'Guava',
    'Langra Mango',
    'Organic Lemon',
    'Fresh Bluberry',
    'Jackfruit',
    'Hardy Kiwi',
    'Gala Peaches',
    'Fresh Pineapple',
    'Red Strawberry',
    'Rasberry',
    'Gala Apple',
    'Saba Banana',
    'Red Papaya',
    'Key Limes',
  ];

  List<String> ratings = [
    '1500 Reviews',
    '1000 Reviews',
    '1200 Reviews',
    '1400 Reviews',
    '1600 Reviews',
    '1700 Reviews',
    '1800 Reviews',
    '1900 Reviews',
    '2500 Reviews',
    '1500 Reviews',
    '1800 Reviews',
    '1700 Reviews',
    '1460 Reviews',
    '1760 Reviews',
    '1660 Reviews',
    '1230 Reviews',
    '1850 Reviews',
    '1120 Reviews',
    '1980 Reviews',
    '1540 Reviews',
    '1980 Reviews',
    '1340 Reviews',
    '1340 Reviews',
    '1870 Reviews',
    '1360 Reviews',
    '1870 Reviews',
    '1230 Reviews',
    '1650 Reviews',
    '1860 Reviews',
    '1750 Reviews',
    '1570 Reviews',
    '1650 Reviews',
    '1660 Reviews',
    '1650 Reviews',
    '1270 Reviews',
    '1700 Reviews',
    '1540 Reviews',
    '1860 Reviews',
    '1480 Reviews',
    '1680 Reviews',
    '1240 Reviews',
    '1860 Reviews',
    '1240 Reviews',
    '1860 Reviews',
    '1200 Reviews',
    '1400 Reviews',
    '1600 Reviews',
    '1700 Reviews',
    '1800 Reviews',
    '1900 Reviews',
    '2500 Reviews',
    '2150 Reviews',
    '1380 Reviews',
    '1700 Reviews',
    '1460 Reviews',
    '1760 Reviews',
    '1660 Reviews',
    '1230 Reviews',
    '1850 Reviews',
    '1120 Reviews',
    '1980 Reviews',
    '1540 Reviews',
    '1980 Reviews',
    '1340 Reviews',
    '1340 Reviews',
    '1870 Reviews',
    '1360 Reviews',
    '1870 Reviews',
    '1230 Reviews',
    '1650 Reviews',
    '1240 Reviews',
  ];

  List<double> reviewValue = [
    4.5,
    3.1,
    2.2,
    4.3,
    3.4,
    2.5,
    3.6,
    4.7,
    4.8,
    3.9,
    2.5,
    4.2,
    3.1,
    4.2,
    2.3,
    4.4,
    3.5,
    4.6,
    2.7,
    4.8,
    3.9,
    4.6,
    2.5,
    2.1,
    3.2,
    4.3,
    4.4,
    3.5,
    4.6,
    2.7,
    4.8,
    4.9,
    2.3,
    3.4,
    4.1,
    2.2,
    4.3,
    3.4,
    4.5,
    4.6,
    2.7,
    3.8,
    4.9,
    3.4,
    4.7,
    2.5,
    4.6,
    4.9,
    2.2,
    4.3,
    3.4,
    2.5,
    3.6,
    4.7,
    4.8,
    3.9,
    2.5,
    4.2,
    3.1,
    4.2,
    2.3,
    4.4,
    3.5,
    4.6,
    2.7,
    4.8,
    3.9,
    4.6,
    2.5,
    2.1,
    3.2,
    4.3,
    4.4,
    3.5,
    4.8
  ];

  List<String> names1 = [
    'Apple',
    'Banana',
    'Papaya',
    'Lime',
    'Pomegranate',
    'Orange',
    'Watermelon',
    'Apricot',
    'Grapes',
    'Cherry',
    'Avacado',
    'Dragon',
    'Guava',
    'Mango',
    'Lemon',
    'Blueberry',
    'Jackfruit',
    'Kiwi',
    'Peach',
    'Pineapple',
    'Strawberry',
    'Raspberry'
  ];

  List<String> weights = [
    '1 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '2 lb',
    '2 lb',
    '2 lb',
    '1 lb',
    '2 lb',
    '1.5 lb',
    '2 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '2 lb',
    '1 lb',
    '1 lb',
    '1.5 lb',
    '1 lb',
    '1.5 lb',
    '2 lb',
    '1 lb',
    '1.5 lb',
    '1 lb',
    '1.5 lb',
    '2 lb',
    '2 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '2 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '1.5 lb',
    '2 lb',
    '1 lb',
    '2 lb',
    '1 lb',
    '2 lb',
    '1 lb',
    '1.5 lb',
    '2 lb',
    '2 lb',
    '1 lb',
    '2 lb',
    '1 lb',
    '2 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '2 lb',
    '1.5 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '2 lb',
    '2 lb',
    '1 lb',
    '1 lb',
    '1 lb',
    '2 lb'
  ];

  List<double> prices = [
    2.47,
    1.40,
    5.48,
    2.28,
    1.45,
    5.00,
    3.98,
    3.50,
    6.50,
    7.48,
    6.29,
    2.46,
    1.47,
    2.10,
    4.40,
    5.00,
    8.27,
    7.33,
    9.99,
    2.00,
    3.97,
    3.79,
    1.17,
    6.40,
    1.78,
    2.18,
    3.78,
    2.12,
    3.98,
    9.95,
    6.50,
    6.18,
    1.05,
    2.76,
    3.47,
    7.10,
    6.40,
    8.25,
    7.17,
    8.33,
    1.55,
    6.00,
    1.55,
    1.15,
    5.48,
    2.18,
    1.40,
    4.95,
    3.88,
    1.39,
    6.40,
    7.38,
    6.19,
    2.36,
    1.57,
    2.20,
    4.30,
    5.10,
    8.37,
    7.23,
    9.89,
    2.10,
    3.87,
    3.29,
    1.07,
    6.10,
    2.08,
    1.78,
    4.28,
    2.10,
    1.15
  ];

  List<String> offer = [
    '10 % Off',
    '25 % Off',
    '50 % Off',
    '30 % Off',
    '60 % Off',
    '35 % Off',
    '40 % Off',
    '70 % Off',
    '25 % Off',
    '90 % Off',
    '20 % Off',
    '45 % Off',
    '50 % Off',
    '20 % Off',
    '15 % Off',
    '10 % Off',
    '20 % Off',
    '45 % Off',
    '10 % Off',
    '20 % Off',
    '15 % Off',
    '40 % Off',
    '20 % Off',
    '15 % Off',
    '50 % Off',
    '20 % Off',
    '15 % Off',
    '80 % Off',
    '20 % Off',
    '45 % Off',
    '30 % Off',
    '80 % Off',
    '35 % Off',
    '10 % Off',
    '30 % Off',
    '75 % Off',
    '50 % Off',
    '20 % Off',
    '55 % Off',
    '40 % Off',
    '20 % Off',
    '85 % Off',
    '10 % Off',
    '20 % Off',
    '50 % Off',
    '30 % Off',
    '60 % Off',
    '35 % Off',
    '40 % Off',
    '70 % Off',
    '25 % Off',
    '90 % Off',
    '20 % Off',
    '45 % Off',
    '50 % Off',
    '20 % Off',
    '15 % Off',
    '10 % Off',
    '20 % Off',
    '45 % Off',
    '10 % Off',
    '20 % Off',
    '15 % Off',
    '40 % Off',
    '20 % Off',
    '15 % Off',
    '50 % Off',
    '20 % Off',
    '15 % Off',
    '80 % Off',
    '30 % Off'
  ];
}

