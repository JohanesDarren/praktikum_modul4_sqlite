import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SimpleMapScreen extends StatelessWidget {
  const SimpleMapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coba Open Street Map',
      home: Scaffold(
        appBar: AppBar(title: Text('Coba OpenStreetMap')),
        body: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(-6.973141110592442, 107.63129581108053),
            initialZoom: 10,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.ppbl',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(-6.973141110592442, 107.63129581108053),
                  width: 100,
                  height: 100,
                  child: Icon(Icons.accessible_forward, color: Colors.blueGrey, size: 40),
                ),
              ],
            ),
            MarkerLayer(markers: [
              Marker(
                point: LatLng(-6.975901620078193, 107.63661619542846),
                width: 80,
                height: 80,
                child: Icon(Icons.location_on, color: Colors.red, size: 40),
              ),
            ],),
            PolygonLayer(
              polygons: [
                Polygon(
                  points: [
                    LatLng(-6.975901620078193, 107.63661619542846),
                    LatLng(-6.973141110592442, 107.63129581108053),
                    LatLng(-6.970938119861664, 107.63690100750935)],

                  color: Colors.blue,
                ),
              ],
            ),
            OverlayImageLayer(
              overlayImages: [
                OverlayImage( // Unrotated
                  bounds: LatLngBounds(
                    LatLng(-6.975901620078193, 107.63661619542846),
                    LatLng(-6.970938119861664, 107.63690100750935),
                  ),
                  imageProvider: NetworkImage('https://ypt.or.id/wp-content/uploads/2018/09/telu.png'),
                ),
              ],
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: [
                    LatLng(-6.973141110592442, 107.63129581108053),
                    LatLng(-6.975901620078193, 107.63661619542846)],
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