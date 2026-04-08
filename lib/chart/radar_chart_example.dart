import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RadarchartExample extends StatelessWidget{

  const RadarchartExample({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh Chart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RadarChart(
          RadarChartData(
            // read about it in the RadarChartData section
            dataSets: [
              RadarDataSet(
                fillColor: Colors.blue.withOpacity(0.4),
                borderColor: Colors.blue,
                entryRadius: 3,
                dataEntries: const [
                  RadarEntry(value: 4),
                  RadarEntry(value: 6),
                  RadarEntry(value: 5),
                  RadarEntry(value: 4),
                  RadarEntry(value: 7),
                  RadarEntry(value: 8),
                ],
                borderWidth: 2,
              ),

            ],
          ),
        ),
      ),

    );
  }
}