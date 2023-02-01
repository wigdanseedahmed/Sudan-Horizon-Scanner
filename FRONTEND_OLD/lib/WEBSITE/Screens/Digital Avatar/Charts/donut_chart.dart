import 'package:sudan_horizon_scanner/imports.dart';
import 'package:http/http.dart' as http;

class DonutChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DonutChart({Key? key, required this.screenSize}) : super(key: key);

  final Size screenSize;

  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  ///VARIABLES USED TO COUNT DOCUMENTS
  late int allClusterDocumentsCount = 0;
  late int agricultureClusterDocumentsCount = 0;
  late int conflictClusterDocumentsCount = 0;
  late int economicClusterDocumentsCount = 0;
  late int educationClusterDocumentsCount = 0;
  late int environmentClusterDocumentsCount = 0;
  late int foodSecurityAndNutritionClusterDocumentsCount = 0;
  late int genderClusterDocumentsCount = 0;
  late int healthClusterDocumentsCount = 0;
  late int infrastructureClusterDocumentsCount = 0;
  late int populationClusterDocumentsCount = 0;
  late int povertyClusterDocumentsCount = 0;

  ///VARIABLES USED TO RETRIEVE AND FILTER THROUGH DATA FROM BACKEND
  late List<ClusterModel> readJsonFileContent = <ClusterModel>[];
  late List<ClusterModel> cluster = <ClusterModel>[];
  late List<ClusterModel> searchClustersData = <ClusterModel>[];
  late List<ClusterModel> searchClusterWithAllIndicatorsData = <ClusterModel>[];
  late ClusterModel searchClusterWithSingleIndicatorsData = ClusterModel();

  TextEditingController taskSearchBarTextEditingController =
      TextEditingController();

  Future<List<ClusterModel>> readClustersFromJsonFile() async {
    /// Read Local Json File Directly
    /*String jsonString = await DefaultAssetBundle.of(context)
        .loadString('jsonDataFiles/interventions/project_data.json');*/
    //print(jsonString);

    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.cluster);

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

    if (response.statusCode == 200) {
      setState(() {
        readJsonFileContent = digitalAvatarListClusterModelFromJson(
            response.body); //(jsonString);
        //print("ALL CLUSTERS: $readJsonFileContent");

        allClusterDocumentsCount = readJsonFileContent.length;
        agricultureClusterDocumentsCount = readJsonFileContent
            .where((ClusterModel clusterInfo) =>
                clusterInfo.cluster == "Agriculture")
            .length;
        conflictClusterDocumentsCount = readJsonFileContent
            .where(
                (ClusterModel clusterInfo) => clusterInfo.cluster == "Conflict")
            .length;
        economicClusterDocumentsCount = readJsonFileContent
            .where(
                (ClusterModel clusterInfo) => clusterInfo.cluster == "Economic")
            .length;
        educationClusterDocumentsCount = readJsonFileContent
            .where((ClusterModel clusterInfo) =>
                clusterInfo.cluster == "Education")
            .length;
        environmentClusterDocumentsCount = readJsonFileContent
            .where((ClusterModel clusterInfo) =>
                clusterInfo.cluster == "Environment")
            .length;
        foodSecurityAndNutritionClusterDocumentsCount = readJsonFileContent
            .where((ClusterModel clusterInfo) =>
                clusterInfo.cluster == "Food Security and Nutrition")
            .length;
        genderClusterDocumentsCount = readJsonFileContent
            .where(
                (ClusterModel clusterInfo) => clusterInfo.cluster == "Gender")
            .length;
        healthClusterDocumentsCount = readJsonFileContent
            .where(
                (ClusterModel clusterInfo) => clusterInfo.cluster == "Health")
            .length;
        infrastructureClusterDocumentsCount = readJsonFileContent
            .where((ClusterModel clusterInfo) =>
                clusterInfo.cluster == "Infrastructure")
            .length;
        populationClusterDocumentsCount = readJsonFileContent
            .where((ClusterModel clusterInfo) =>
                clusterInfo.cluster == "Population")
            .length;
        povertyClusterDocumentsCount = readJsonFileContent
            .where(
                (ClusterModel clusterInfo) => clusterInfo.cluster == "Poverty")
            .length;
      });

      return readJsonFileContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');
    readClustersFromJsonFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenSize.height * 0.45,
      width: widget.screenSize.width * 0.295,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.grey.shade50
            : Colors.white10,
      ),
      child: _buildDefaultDoughnutChart(),
    );
  }

  /// Return the circular chart with default doughnut series.
  SfCircularChart _buildDefaultDoughnutChart() {
    return SfCircularChart(
      title: ChartTitle(
        text: 'Total Dataset Distribution Between Clusters',
        textStyle: TextStyle(
          fontSize: widget.screenSize.width / 100,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
        alignment: ChartAlignment.near,
        textStyle: TextStyle(
          fontSize: widget.screenSize.width / 170,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
      series: _getDefaultDoughnutSeries(),
      tooltipBehavior: _tooltip,
    );
  }

  /// Returns the doughnut series which need to be render.
  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '10%',
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: 'Agriculture',
                y: (agricultureClusterDocumentsCount /
                        allClusterDocumentsCount) *
                    100,
                text:
                    '${double.parse(((agricultureClusterDocumentsCount / allClusterDocumentsCount) * 100).toStringAsFixed(2))}%'),
            ChartSampleData(
                x: 'Economic',
                y: (economicClusterDocumentsCount / allClusterDocumentsCount) *
                    100,
                text:
                    '${double.parse(((economicClusterDocumentsCount / allClusterDocumentsCount) * 100).toStringAsFixed(2))}%'),
            ChartSampleData(
                x: 'Education',
                y: (educationClusterDocumentsCount / allClusterDocumentsCount) *
                    100,
                text:
                    '${double.parse(((educationClusterDocumentsCount / allClusterDocumentsCount) * 100).toStringAsFixed(2))}%'),
            ChartSampleData(
                x: 'Environment',
                y: (environmentClusterDocumentsCount /
                        allClusterDocumentsCount) *
                    100,
                text:
                    '${double.parse(((environmentClusterDocumentsCount / allClusterDocumentsCount) * 100).toStringAsFixed(2))}%'),
            ChartSampleData(
                x: 'Food Security\nand Nutrition',
                y: (foodSecurityAndNutritionClusterDocumentsCount /
                        allClusterDocumentsCount) *
                    100,
                text:
                    '${double.parse(((foodSecurityAndNutritionClusterDocumentsCount / allClusterDocumentsCount) * 100).toStringAsFixed(2))}%'),
            ChartSampleData(
                x: 'Gender',
                y: (genderClusterDocumentsCount / allClusterDocumentsCount) *
                    100,
                text:
                    '${double.parse(((genderClusterDocumentsCount / allClusterDocumentsCount) * 100).toStringAsFixed(2))}%'),
            ChartSampleData(
                x: 'Health',
                y: (healthClusterDocumentsCount / allClusterDocumentsCount) *
                    100,
                text:
                    '${double.parse(((healthClusterDocumentsCount / allClusterDocumentsCount) * 100).toStringAsFixed(2))}%'),
            ChartSampleData(
                x: 'Infrastructure',
                y: (infrastructureClusterDocumentsCount /
                        allClusterDocumentsCount) *
                    100,
                text:
                    '${double.parse(((infrastructureClusterDocumentsCount / allClusterDocumentsCount) * 100).toStringAsFixed(2))}%'),
            ChartSampleData(
                x: 'Population',
                y: (populationClusterDocumentsCount /
                        allClusterDocumentsCount) *
                    100,
                text:
                    '${double.parse(((populationClusterDocumentsCount / allClusterDocumentsCount) * 100).toStringAsFixed(2))}%'),
            ChartSampleData(
                x: 'Poverty',
                y: (povertyClusterDocumentsCount / allClusterDocumentsCount) *
                    100,
                text:
                    '${double.parse(((povertyClusterDocumentsCount / allClusterDocumentsCount) * 100).toStringAsFixed(2))}%'),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
  }
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
