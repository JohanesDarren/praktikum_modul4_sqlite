import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartExample extends StatelessWidget{

  const BarChartExample({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh Chart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            barGroups: [

              BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(toY: 100, color: Colors.blueAccent),
                    BarChartRodData(toY: 110, color: Colors.yellow),
                    BarChartRodData(toY: 120, color: Colors.red),
                    BarChartRodData(toY: 90, color: Colors.green),
                  ]
              ),
              BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(toY: 300, color: Colors.blueAccent),
                    BarChartRodData(toY: 250, color: Colors.yellow),
                    BarChartRodData(toY: 270, color: Colors.red),
                    BarChartRodData(toY: 290, color: Colors.green),
                  ]
              ),
              BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(toY: 100, color: Colors.blueAccent),
                    BarChartRodData(toY: 50, color: Colors.yellow),
                    BarChartRodData(toY: 125, color: Colors.red),
                    BarChartRodData(toY: 110, color: Colors.green),
                  ]
              ),
              BarChartGroupData(
                  x: 4,
                  barRods: [
                    BarChartRodData(toY: 400, color: Colors.blueAccent),
                    BarChartRodData(toY: 450, color: Colors.yellow),
                    BarChartRodData(toY: 525, color: Colors.red),
                    BarChartRodData(toY: 590, color: Colors.green),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}