import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapRoad extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapRoad> {
  late MapController controller;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initPosition: GeoPoint(latitude: -6.973141, longitude: 107.631295), // Telkom University
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void drawRoad() async {
    try {
      await controller.drawRoad(
        GeoPoint(latitude: -6.973141, longitude: 107.631295), // Telkom University
        GeoPoint(latitude: -6.9175, longitude: 107.6091),    // Braga
        roadOption: const RoadOption(
          roadColor: Colors.deepPurpleAccent,
          roadWidth: 10,
        ),
      );
    } catch (e) {
      debugPrint("Error drawing road: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OSM Map - Road Navigation"),
      ),
      body: OSMFlutter(
        controller: controller,
        osmOption: OSMOption(
          userTrackingOption: const UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
          zoomOption: const ZoomOption(
            initZoom: 13,
            minZoomLevel: 3,
            maxZoomLevel: 19,
            stepZoom: 1.0,
          ),

          roadConfiguration: const RoadOption(
            roadColor: Colors.yellowAccent,
          ),

        ),
        onMapIsReady: (isReady) {
          if (isReady) {
            drawRoad();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => drawRoad(),
        child: Icon(Icons.directions),
      ),
    );
  }
}
