import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/model/issue_statics.dart';
import 'package:scrum_master_front_end/model/performance_statics.dart';
import 'package:scrum_master_front_end/widgets/indicator.dart';

class PerformancePieChart extends StatefulWidget {
  final PerformanceStatics performanceStatics;

  PerformancePieChart(this.performanceStatics);

  @override
  State<StatefulWidget> createState() => PerformancePieChartState();
}

class PerformancePieChartState extends State<PerformancePieChart> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Colors.red,
                  text: 'Not completed',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.green,
                  text: 'Complete early',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.orange,
                  text: 'Complete late',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    int earlyIssueTotal = widget.performanceStatics.earlyIssueTotal!;
    int lateIssueTotal = widget.performanceStatics.lateIssueTotal!;
    int notCompletedIssueTotal =
        widget.performanceStatics.notCompletedIssueTotal!;

    int total = earlyIssueTotal + lateIssueTotal + notCompletedIssueTotal;

    String storyPercent =
        (notCompletedIssueTotal.toDouble() * 100 / total).toStringAsFixed(2);
    String taskPercent =
        (lateIssueTotal.toDouble() * 100 / total).toStringAsFixed(2);
    String bugPercent =
        (100 - double.parse(storyPercent) - double.parse(taskPercent))
            .toStringAsFixed(2);
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;

      final notCompletedTitle =
          isTouched ? '$notCompletedIssueTotal' : '${storyPercent}%';
      final earlyIssueTitle = isTouched ? '$earlyIssueTotal' : '${bugPercent}%';
      final lateIssueTitle = isTouched ? '$lateIssueTotal' : '${taskPercent}%';
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: notCompletedIssueTotal.toDouble(),
            title: notCompletedTitle,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: earlyIssueTotal.toDouble(),
            title: earlyIssueTitle,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
              color: Colors.orange,
              value: lateIssueTotal.toDouble(),
              title: lateIssueTitle,
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ));
        default:
          throw Exception('Oh no');
      }
    });
  }
}

