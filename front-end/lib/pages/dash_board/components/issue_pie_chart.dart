import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/model/issue_statics.dart';
import 'package:scrum_master_front_end/widgets/indicator.dart';

class IssuePieChart extends StatefulWidget {
  final IssueStatics issueStatics;

  IssuePieChart(this.issueStatics);

  @override
  State<StatefulWidget> createState() => IssuePieChartState();
}

class IssuePieChartState extends State<IssuePieChart> {
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
                  color: Color(0xff0293ee),
                  text: 'Story',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.orange,
                  text: 'Bug',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef),
                  text: 'Task',
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
    int bugTotal = widget.issueStatics.bugTotal!;
    int taskTotal = widget.issueStatics.taskTotal!;
    int storyTotal = widget.issueStatics.storyTotal!;

    int total = bugTotal + taskTotal + storyTotal;

    String storyPercent =
        (storyTotal.toDouble() * 100 / total).toStringAsFixed(2);
    String taskPercent =
        (taskTotal.toDouble() * 100 / total).toStringAsFixed(2);
    String bugPercent =
        (100 - double.parse(storyPercent) - double.parse(taskPercent))
            .toStringAsFixed(2);
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 45.0 : 30.0;

      final storyTitle = isTouched ? '$storyTotal' : '${storyPercent}%';
      final bugTitle = isTouched ? '$bugTotal' : '${bugPercent}%';
      final taskTitle = isTouched ? '$taskTotal' : '${taskPercent}%';
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: storyTotal.toDouble(),
            title: storyTitle,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(
              'assets/icons/Story.png',
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: bugTotal.toDouble(),
            title: bugTitle,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(
              'assets/icons/Bug.png',
              size: widgetSize,
              borderColor: Colors.orange,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: taskTotal.toDouble(),
            title: taskTitle,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: _Badge(
              'assets/icons/Task.png',
              size: widgetSize,
              borderColor: const Color(0xff845bef),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });

  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(
          svgAsset,
        ),
      ),
    );
  }
}
