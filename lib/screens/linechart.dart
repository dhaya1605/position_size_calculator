import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:calculator/styles.dart';

class LineChartSample2 extends StatefulWidget {
  LineChartSample2(this.weekspots);
  List<FlSpot> weekspots;
  @override
  _LineChartSample2State createState() => _LineChartSample2State(weekspots);
}

class _LineChartSample2State extends State<LineChartSample2> {
  _LineChartSample2State(this.weekspots);
  List<FlSpot> weekspots;
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
    // color5,
    // color4
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {

    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          width: mWidth*0.85,
          height: mHeight*0.3,
          decoration: nMbox,
          child: Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: LineChart(
               mainData(),
            ),
          ),
        ),

      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'M';
              case 2:
                return 'T';
              case 3:
                return 'W';
              case 4:
                return 'T';
              case 5:
                return 'F';
              case 6:
                return 'S';
              case 7:
                return 'S';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {

              case 5:
                return '5';
              case -5:
                return '-5';

              case 0:
                return '0';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 7,
      minY: -10,
      maxY:10,
      lineBarsData: [
        LineChartBarData(
          spots: weekspots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

}


class lineChartMonth extends StatefulWidget {
  lineChartMonth(this.monthspots);
  List<FlSpot> monthspots;
  @override
  _lineChartMonthState createState() => _lineChartMonthState(monthspots);
}

class _lineChartMonthState extends State<lineChartMonth> {
  _lineChartMonthState(this.monthspots);
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
    // color5,
    // color4
  ];
  List<FlSpot> monthspots;

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          width: mWidth*0.85,
          height: mHeight*0.3,
          decoration: nMbox,
          child: Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );


  }
  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 5:
                return '5';
              case 10:
                return '10';
              case 15:
                return '12';
              case 20:
                return '20';
              case 25:
                return '25';
              case 30:
                return '30';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {

              case 5:
                return '50';
              case -5:
                return '-50';

              case 0:
                return '0';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1,
      maxX: 31,
      minY: -10,
      maxY:10,
      lineBarsData: [
        LineChartBarData(
          spots: monthspots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }


}

class lineChartMonth1 extends StatefulWidget {
  lineChartMonth1(this.monthspots);
  List<FlSpot> monthspots;
  @override
  _lineChartMonth1State createState() => _lineChartMonth1State(monthspots);
}

class _lineChartMonth1State extends State<lineChartMonth1> {
  _lineChartMonth1State(this.monthspots);
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
    // color5,
    // color4
  ];
  List<FlSpot> monthspots;

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          width: mWidth*0.85,
          height: mHeight*0.3,
          decoration: nMbox,
          child: Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );


  }
  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1';
              case 2:
                return '2';
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
              case 6:
                return '6';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {

              case 5:
                return '50';
              case -5:
                return '-50';

              case 0:
                return '0';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1,
      maxX: 6,
      minY: -10,
      maxY:10,
      lineBarsData: [
        LineChartBarData(
          spots: monthspots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}

class lineChartMonth3 extends StatefulWidget {
  lineChartMonth3(this.monthspots);
  List<FlSpot> monthspots;
  @override
  _lineChartMonth3State createState() => _lineChartMonth3State(monthspots);
}

class _lineChartMonth3State extends State<lineChartMonth3> {
  _lineChartMonth3State(this.monthspots);
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
    // color5,
    // color4
  ];
  List<FlSpot> monthspots;

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          width: mWidth*0.85,
          height: mHeight*0.3,
          decoration: nMbox,
          child: Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );


  }
  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '2';
              case 4:
                return '4';
              case 6:
                return '6';
              case 8:
                return '8';
              case 10:
                return '10';
              case 12:
                return '12';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {

              case 5:
                return '50';
              case -5:
                return '-50';

              case 0:
                return '0';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1,
      maxX: 12,
      minY: -10,
      maxY:10,
      lineBarsData: [
        LineChartBarData(
          spots: monthspots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}

