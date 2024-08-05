import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello/constants/color.dart';
import 'package:hello/constants/linksapi.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  Future<List<ChartAges2>> fetchAges() async {
    try {
      var response = await http.get(Uri.parse(link_age));
      print("Ages API response: ${response.body}");

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        int lessthen14 =
            responseBody['data']['Count of users less than 14 ='] ?? 0;
        int from15to20 =
            responseBody['data']['Count of users between 15 and 20 ='] ?? 0;
        int graterthan20 =
            responseBody['data']['Count of users grater than 20 ='] ?? 0;

        return [
          ChartAges2('less than 14', lessthen14),
          ChartAges2('15 - 20', from15to20),
          ChartAges2('greater than 20', graterthan20),
        ];
      } else {
        throw Exception('Failed to fetch ages');
      }
    } catch (e) {
      throw Exception('An error occurred in fetchAges: $e');
    }
  }

  Future<List<ChartData>> fetchLevels() async {
    try {
      var response = await http.get(Uri.parse(link_levels));
      print("levels API response: ${response.body}");

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        int first = responseBody['counts']['count_first'] ?? 0;
        int second = responseBody['counts']['count_second'] ?? 0;
        int third = responseBody['counts']['count_third'] ?? 0;

        return [
          ChartData('Beginners', first, const Color(0xFF47E32F)),
          ChartData('Middle', second, const Color(0xFFECE05C)),
          ChartData('Advanced', third, const Color(0xFF41C9D2))
        ];
      } else {
        throw Exception('Failed to fetch levels');
      }
    } catch (e) {
      throw Exception('An error occurred in fetchLevels: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchAges() and fetchLevels() are now called inside the FutureBuilder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 300,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: medium_Brown,
                    offset: const Offset(0, 1),
                    blurRadius: 10,
                  ),
                ],
                color: offwhite,
              ),
              child: Center(
                child: FutureBuilder<List<ChartAges2>>(
                  future: fetchAges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('An error occurred: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        plotAreaBorderWidth: 0,
                        margin: const EdgeInsets.all(35),
                        series: <CartesianSeries>[
                          StackedColumnSeries<ChartAges2, String>(
                            dataSource: snapshot.data!,
                            color: const Color(0xFF5B947F),
                            width: 0.5,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            xValueMapper: (ChartAges2 data, _) => data.str,
                            yValueMapper: (ChartAges2 data, _) => data.n,
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 300,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: medium_Brown,
                    offset: const Offset(0, 1),
                    blurRadius: 10,
                  ),
                ],
                color: offwhite,
              ),
              child: Center(
                child: FutureBuilder<List<ChartData>>(
                  future: fetchLevels(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('An error occurred: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 60, top: 100),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Color(0xFF47E32F),
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Beginners"),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Padding(
                                  padding: EdgeInsets.only(right: 23),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Color(0xFFECE05C),
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text("Middle")
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Color(0xFF41C9D2),
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Advanced")
                                  ],
                                )
                              ],
                            ),
                          ),
                          SfCircularChart(
                            series: <CircularSeries>[
                              DoughnutSeries<ChartData, String>(
                                dataSource: snapshot.data!,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                              ),
                            ],
                          )
                        ],
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

class ChartAges2 {
  final String str;
  final int n;

  ChartAges2(this.str, this.n);
}
