import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello/core/constants/color.dart';
import 'package:hello/core/constants/linksapi.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  int selected = 0;
  int getPeriod(int period) {
    switch (period) {
      case 1:
        return 1;
      case 2:
        return 1;
      case 3:
        return 1;
      default:
        return 0;
    }
  }

  Future<List<ChartData2>> fetchAges() async {
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
          ChartData2('less than 14', lessthen14),
          ChartData2('15 - 20', from15to20),
          ChartData2('greater than 20', graterthan20),
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
          ChartData('Beginners', first, const Color(0xFF8ac926)),
          ChartData('Middle', second, const Color(0xFFffca3a)),
          ChartData('Advanced', third, const Color(0xFF1982c4))
        ];
      } else {
        throw Exception('Failed to fetch levels');
      }
    } catch (e) {
      throw Exception('An error occurred in fetchLevels: $e');
    }
  }

  Future<List<ChartData2>> fetchTypes(int period) async {
    try {
      var response = await http.get(Uri.parse("$link_types/$period"));
      print("Types API response: ${response.body}");

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        List<dynamic> results = responseBody['data']['result'];
        List<ChartData2> chartDataList = [];

        for (var result in results) {
          String typeName = result['type_name'];
          int countTypeBooks = result['count_type_books'] ?? 0;
          chartDataList.add(ChartData2(typeName, countTypeBooks));
        }

        return chartDataList;
      } else {
        throw Exception('Failed to fetch Types');
      }
    } catch (e) {
      throw Exception('An error occurred in fetchTypes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.38,
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
                    child: FutureBuilder<List<ChartData2>>(
                      future: fetchAges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text('An error occurred: ${snapshot.error}'));
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
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
                              StackedColumnSeries<ChartData2, String>(
                                dataSource: snapshot.data!,
                                color: const Color(0xFF03658c),
                                width: 0.5,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                xValueMapper: (ChartData2 data, _) => data.str,
                                yValueMapper: (ChartData2 data, _) => data.n,
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
              const SizedBox(
                width: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.38,
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text('An error occurred: ${snapshot.error}'));
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 80, top: 90),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 4),
                                          child: Icon(
                                            Icons.circle,
                                            color: Color(0xFF8ac926),
                                            size: 20,
                                          ),
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
                                            color: Color(0xFFffca3a),
                                            size: 20,
                                          ),
                                          SizedBox(width: 10),
                                          Text("Middle")
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Padding(
                                      padding: EdgeInsets.only(right: 2),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: Color(0xFF1982c4),
                                            size: 20,
                                          ),
                                          SizedBox(width: 10),
                                          Text("Advanced")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 80,
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
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
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
              child: Stack(
                children: [
                  Center(
                    child: FutureBuilder<List<ChartData2>>(
                      future: fetchTypes(selected),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text('An error occurred: ${snapshot.error}'));
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
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
                              StackedColumnSeries<ChartData2, String>(
                                dataSource: snapshot.data!,
                                color: const Color(0xFF5B947F),
                                width: 0.5,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                xValueMapper: (ChartData2 data, _) => data.str,
                                yValueMapper: (ChartData2 data, _) => data.n,
                              ),
                            ],
                          );
                        } else {
                          return const Center(child: Text('No data available'));
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, top: 15),
                      child: Container(
                        height: 35,
                        width: 148,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Light_Brown, width: 1),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Icon(
                                size: 23,
                                Icons.calendar_today,
                                color: dark_Brown,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 35,
                              color: Colors.grey,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                            ),
                            DropdownButton<int>(
                              borderRadius: BorderRadius.circular(10),
                              dropdownColor: offwhite,
                              underline: const SizedBox.shrink(),
                              icon: Icon(
                                  color: dark_Brown, Icons.arrow_drop_down),
                              style: TextStyle(color: dark_Brown),
                              items: const [
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text("Current time"),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text("Last Year"),
                                ),
                                DropdownMenuItem(
                                    value: 2, child: Text("Last Month")),
                                DropdownMenuItem(
                                    value: 3, child: Text("Last Week"))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selected = value!;
                                });
                              },
                              value: selected,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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

class ChartData2 {
  final String str;
  final int n;

  ChartData2(this.str, this.n);
}
