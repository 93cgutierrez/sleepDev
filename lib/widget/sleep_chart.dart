import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SleepChart extends StatefulWidget {
  final List<FlSpot> sleepData;

  const SleepChart({super.key, required this.sleepData});

  @override
  State<SleepChart> createState() => _SleepChartState();
}

class _SleepChartState extends State<SleepChart> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 10,
          )),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 50,
              showTitles: true,
              interval: 1.0,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return _textAxis("Short Nap");
                  case 2:
                    return _textAxis("Awake");
                  case 4:
                    return _textAxis("REM Sleep");
                  case 6:
                    return _textAxis("Light Sleep");
                  case 8:
                    return _textAxis("Deep Sleep");
                  default:
                    return Container();
                }
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 20,
              showTitles: true,
              interval: 1.0,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return _textAxis("Mon");
                  case 1:
                    return _textAxis("Tues");
                  case 2:
                    return _textAxis("Wed");
                  case 3:
                    return _textAxis("Thu");
                  case 4:
                    return _textAxis("Fri");
                  case 5:
                    return _textAxis("Sat");
                  case 6:
                    return _textAxis("Sun");
                  default:
                    return Container();
                }
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: widget.sleepData,
            isCurved: true,
            color: Colors.blueAccent,
            barWidth: 3,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: true),
          ),
        ],
      ),
    );
  }

  // Widget para los textos del eje
  Widget _textAxis(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}
