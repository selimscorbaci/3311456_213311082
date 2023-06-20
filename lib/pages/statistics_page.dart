import 'package:chat_app/services/firestore_man.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatefulWidget {
  final Color gradientColor1 = Colors.blue;
  final Color gradientColor2 = Colors.purple;
  final Color gradientColor3 = Colors.grey;
  final Color indicatorStrokeColor = Colors.green;
  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<int> showingTooltipOnSpots = [1, 3, 5];

  List<FlSpot> allSpots = [
    FlSpot(0, 0),
    FlSpot(1, 0),
    FlSpot(2, 0),
    FlSpot(3, 0),
    FlSpot(4, 0),
    FlSpot(5, 0),
    FlSpot(6, 0),
  ];

  String TimePeriod(int value) {
    int period = 6 - value; //0
    String time;
    if (((DateTime.now().hour)) == 0) {
      switch (value) {
        case 0: //18:00
          return "18:00";
        case 1: //19:00
          return "19:00";
        case 2: //20:00
          return "20:00";
        case 3: //21:00
          return "21:00";
        case 4: //22:00
          return "22:00";
        case 5: //23:00
          return "23:00";
        case 6: //00:00
          return "00:00";
      }
    }

    time = (DateTime.now().hour - period <= 9) //00:
        ? "0${DateTime.now().hour - period}:00"
        : "${DateTime.now().hour - period}:00";

    return time;
  }

  void setSpot(int val) async {
    List data = await getsubcollectiondata(); // we need to update allSpots
    List count = [0, 0, 0, 0, 0, 0, 0];
    int hour = DateTime.now().hour;
    switch (val) {
      case 0:
        hour -= 6;
        break;
      case 1:
        hour -= 5;
        break;
      case 2:
        hour -= 4;
        break;
      case 3:
        hour -= 3;
        break;
      case 4:
        hour -= 2;
        break;
      case 5:
        hour -= 1;
        break;
      case 6:
        break;
    }
    for (int i = 0; i < data.length; i++) {
      if ((data[i]['addtime'] as Timestamp).toDate().hour == hour &&
          (data[i]['addtime'] as Timestamp).toDate().year ==
              DateTime.now().year &&
          (data[i]['addtime'] as Timestamp).toDate().month ==
              DateTime.now().month &&
          (data[i]['addtime'] as Timestamp).toDate().day ==
              DateTime.now().day) {
        count[val] += 1;
      }
    }

    allSpots[val] = FlSpot((val).toDouble(), (count[val]).toDouble());
    setState(() {});
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.pink,
      fontFamily: 'Digital',
      fontSize: 18 * chartWidth / 500,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        setSpot(0);
        text = TimePeriod(0);
        break;
      case 1:
        setSpot(1);
        text = TimePeriod(1);
        break;
      case 2:
        setSpot(2);
        text = TimePeriod(2);
        break;
      case 3:
        setSpot(3);
        text = TimePeriod(3);
        break;
      case 4:
        setSpot(4);
        text = TimePeriod(4);
        break;
      case 5:
        setSpot(5);
        text = TimePeriod(5);
        break;
      case 6:
        setSpot(6);
        text = TimePeriod(6);
        break;

      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Future<List> getsubcollectiondata() async {
    List tmp = [];
    List data = [];
    String userid = await FirestoreManagement().currUID();

    QuerySnapshot mainCollectionRef =
        await FirebaseFirestore.instance.collection('messages').get();
    for (QueryDocumentSnapshot maindoc in mainCollectionRef.docs) {
      QuerySnapshot subcollectionDocs =
          await maindoc.reference.collection('messagelist').get();
      for (QueryDocumentSnapshot subDoc in subcollectionDocs.docs) {
        tmp.add(subDoc.data());
      }
    }
    for (int i = 0; i < tmp.length; i++) {
      if (tmp[i]['uid'] == userid) {
        data.add(tmp[i]);
      }
    }

    return data; //returns the current user message properties such as content,addtime,uid
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 4,
        shadow: const Shadow(
          blurRadius: 8,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              widget.gradientColor1.withOpacity(0.4),
              widget.gradientColor2.withOpacity(0.4),
              widget.gradientColor3.withOpacity(0.4),
            ],
          ),
        ),
        dotData: const FlDotData(show: false),
        gradient: LinearGradient(
          colors: [
            widget.gradientColor1,
            widget.gradientColor2,
            widget.gradientColor3,
          ],
          stops: const [0.1, 0.4, 0.9],
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics"),
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, top: 15.0),
                child: AspectRatio(
                  aspectRatio: 2.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 10,
                    ),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return LineChart(
                        LineChartData(
                          showingTooltipIndicators:
                              showingTooltipOnSpots.map((index) {
                            return ShowingTooltipIndicators([
                              LineBarSpot(
                                tooltipsOnBar,
                                lineBarsData.indexOf(tooltipsOnBar),
                                tooltipsOnBar.spots[index],
                              ),
                            ]);
                          }).toList(),
                          lineTouchData: LineTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchCallback: (FlTouchEvent event,
                                LineTouchResponse? response) {
                              if (response == null ||
                                  response.lineBarSpots == null) {
                                return;
                              }
                              if (event is FlTapUpEvent) {
                                final spotIndex =
                                    response.lineBarSpots!.first.spotIndex;
                                setState(() {
                                  if (showingTooltipOnSpots
                                      .contains(spotIndex)) {
                                    showingTooltipOnSpots.remove(spotIndex);
                                  } else {
                                    showingTooltipOnSpots.add(spotIndex);
                                  }
                                });
                              }
                            },
                            mouseCursorResolver: (FlTouchEvent event,
                                LineTouchResponse? response) {
                              if (response == null ||
                                  response.lineBarSpots == null) {
                                return SystemMouseCursors.basic;
                              }
                              return SystemMouseCursors.click;
                            },
                            getTouchedSpotIndicator: (LineChartBarData barData,
                                List<int> spotIndexes) {
                              return spotIndexes.map((index) {
                                return TouchedSpotIndicatorData(
                                  const FlLine(
                                    color: Colors.pink,
                                  ),
                                  FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (spot, percent, barData, index) =>
                                            FlDotCirclePainter(
                                      radius: 8,
                                      color: lerpGradient(
                                        barData.gradient!.colors,
                                        barData.gradient!.stops!,
                                        percent / 100,
                                      ),
                                      strokeWidth: 2,
                                      strokeColor: widget.indicatorStrokeColor,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            touchTooltipData: LineTouchTooltipData(
                              tooltipBgColor: Colors.pink,
                              tooltipRoundedRadius: 8,
                              getTooltipItems:
                                  (List<LineBarSpot> lineBarsSpot) {
                                return lineBarsSpot.map((lineBarSpot) {
                                  return LineTooltipItem(
                                    lineBarSpot.y.toString(),
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                          lineBarsData: lineBarsData,
                          minY: 0,
                          titlesData: FlTitlesData(
                            leftTitles: const AxisTitles(
                              axisNameWidget: Text('count'),
                              axisNameSize: 24,
                              sideTitles: SideTitles(
                                showTitles: false,
                                reservedSize: 0,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  return bottomTitleWidgets(
                                    value,
                                    meta,
                                    constraints.maxWidth,
                                  );
                                },
                                // reservedSize: 30,
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                                reservedSize: 0,
                              ),
                            ),
                            topTitles: const AxisTitles(
                              axisNameWidget: Text(
                                'Your messages for last 7 hours',
                                textAlign: TextAlign.left,
                              ),
                              axisNameSize: 24,
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 0,
                              ),
                            ),
                          ),
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
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

Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
