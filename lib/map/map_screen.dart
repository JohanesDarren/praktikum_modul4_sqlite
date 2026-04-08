import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SimpleMapScreen extends StatelessWidget {
  const SimpleMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coba OpenStreetMap',
      home: Scaffold(
        appBar: AppBar(title: Text('Coba OpenStreetMap')),
        body: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(-6.973141110592442, 107.63129581108053),
            initialZoom: 13,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.ppbl2026',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(-6.973141110592442, 107.63129581108053),
                  width: 80,
                  height: 80,
                  child: Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
                Marker(
                  point: LatLng(-6.9367391,107.5879816),
                  width: 80,
                  height: 80,
                  child: Icon(Icons.airplanemode_active_outlined, color: Colors.green, size: 40),
                ),

              ],
            ),

            PolylineLayer(  polylines: [
              Polyline(
                points: [
                  LatLng(-6.973141, 107.631295), // Telkom University
                  LatLng(-6.9175, 107.6091),    // Braga
                ],
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
            ),
          ],
        ),
      ),
    );
  }
}
