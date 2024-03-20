// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class DriverOnMap extends StatefulWidget {
//   final double poly_lat1, poly_lng1, poly_lat2, poly_lng2;
//
//   const DriverOnMap({
//     Key? key,
//     required this.poly_lat1,
//     required this.poly_lng1,
//     required this.poly_lat2,
//     required this.poly_lng2,
//   }) : super(key: key);
//
//   @override
//   _DriverOnMapState createState() => _DriverOnMapState();
// }
//
// class _DriverOnMapState extends State<DriverOnMap> {
//   Completer<GoogleMapController> _controller = Completer();
//   Set<Polyline> _polyline = {};
//   Set<Marker> _markers = {};
//   late LatLngBounds _bounds;
//
//   @override
//   void initState() {
//     super.initState();
//     _createPolylines();
//
//     print("Total KM between two points is = ${calculateDistance(widget.poly_lat1, widget.poly_lng1, widget.poly_lat2, widget.poly_lng2)}");
//   }
//
//   void _createPolylines() {
//     setState(() {
//       _polyline.add(Polyline(
//         polylineId: PolylineId('route'),
//         visible: true,
//         points: [
//           LatLng(widget.poly_lat1, widget.poly_lng1),
//           LatLng(widget.poly_lat2, widget.poly_lng2),
//         ],
//         color: Colors.white, // Changed polyline color to white
//         width: 5,
//       ));
//
//       // Add markers
//       _markers.add(
//         Marker(
//           markerId: MarkerId('start'),
//           position: LatLng(widget.poly_lat1, widget.poly_lng1),
//           infoWindow: InfoWindow(title: 'Start'),
//           icon: BitmapDescriptor.defaultMarker,
//         ),
//       );
//       _markers.add(
//         Marker(
//           markerId: MarkerId('end'),
//           position: LatLng(widget.poly_lat2, widget.poly_lng2),
//           infoWindow: InfoWindow(title: 'End'),
//           icon: BitmapDescriptor.defaultMarker,
//         ),
//       );
//     });
//   }
//
//
//   Future<String> _loadNightStyle() async {
//     // Load the JSON style file from assets
//     String nightStyleJson = await DefaultAssetBundle.of(context)
//         .loadString('assets/themes/aubergine_style.json');
//     return nightStyleJson;
//   }
//
//   //Method for calculating Total KM
//   double calculateDistance(lat1, lon1, lat2, lon2){
//     var p = 0.017453292519943295;
//     var a = 0.5 - cos((lat2 - lat1) * p)/2 +
//         cos(lat1 * p) * cos(lat2 * p) *
//             (1 - cos((lon2 - lon1) * p))/2;
//     return 12742 * asin(sqrt(a));
//   }
//
//
//
//   late GoogleMapController mapController;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       FutureBuilder<String>(
//         future: _loadNightStyle(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                         (widget.poly_lat1 + widget.poly_lat2) / 2,
//                         (widget.poly_lng1 + widget.poly_lng2) / 2,
//                       ),
//                 zoom: 14.5,
//               ),
//               onMapCreated: (controller) {
//                 _controller.complete(controller);
//                 mapController = controller;
//                 mapController.setMapStyle(snapshot.data!);
//               },
//               polylines: _polyline,
//               markers: _markers,
//                 myLocationEnabled: true,
//                 mapType: MapType.normal,
//                 buildingsEnabled: true,
//                 onTap: (_) {},
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error loading night style'));
//           } else {
//             return Center(
//                 child: CircularProgressIndicator(color: Colors.white));
//           }
//         },
//       ),
//
//
//     );
//   }
// }
//

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class DriverOnMap extends StatefulWidget {
  final double poly_lat1, poly_lng1, poly_lat2, poly_lng2;

  const DriverOnMap({
    Key? key,
    required this.poly_lat1,
    required this.poly_lng1,
    required this.poly_lat2,
    required this.poly_lng2,
  }) : super(key: key);

  @override
  _DriverOnMapState createState() => _DriverOnMapState();
}

class _DriverOnMapState extends State<DriverOnMap> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Polyline> _polyline = {};
  Set<Marker> _markers = {};
  late LatLngBounds _bounds;

  @override
  void initState() {
    super.initState();
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    final apiKey =
        'AIzaSyBglflWQihT8c4yf4q2MVa2XBtOrdAylmI'; // Replace with your Google Maps API key
    final start = '${widget.poly_lat1},${widget.poly_lng1}';
    final end = '${widget.poly_lat2},${widget.poly_lng2}';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$start&destination=$end&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    final responseData = json.decode(response.body);

    if (responseData['status'] == 'OK') {
      final List<LatLng> routeCoords = [];
      final List<Steps> steps =
          Directions.fromJson(responseData).routes.first.steps;
      steps.forEach((step) {
        routeCoords.add(LatLng(step.startLocation.lat, step.startLocation.lng));
        routeCoords.addAll(_decodePolyline(step.polyline));
      });

      setState(() {
        _polyline.add(Polyline(
          polylineId: PolylineId('route'),
          visible: true,
          points: routeCoords,
          color: Colors.white,
          width: 5,
        ));

        // Add markers
        _markers.add(
          Marker(
            markerId: MarkerId('start'),
            position: LatLng(widget.poly_lat1, widget.poly_lng1),
            infoWindow: InfoWindow(title: 'Start'),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
        _markers.add(
          Marker(
            markerId: MarkerId('end'),
            position: LatLng(widget.poly_lat2, widget.poly_lng2),
            infoWindow: InfoWindow(title: 'End'),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      });
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }
    return points;
  }

  Future<String> _loadNightStyle() async {
    // Load the JSON style file from assets
    String nightStyleJson = await DefaultAssetBundle.of(context)
        .loadString('assets/themes/aubergine_style.json');
    return nightStyleJson;
  }

  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: _loadNightStyle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  (widget.poly_lat1 + widget.poly_lat2) / 2,
                  (widget.poly_lng1 + widget.poly_lng2) / 2,
                ),
                zoom: 14.5,
              ),
              onMapCreated: (controller) {
                _controller.complete(controller);
                mapController =controller;
                mapController.setMapStyle(snapshot.data);
              },
              polylines: _polyline,
              markers: _markers,
              myLocationEnabled: true,
              mapType: MapType.normal,
              buildingsEnabled: true,
              onTap: (_) {},
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading night style'));
          } else {
            return Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
        },
      ),
    );
  }
}
//

class Directions {
  final List<Routes> routes;

  Directions({required this.routes});

  factory Directions.fromJson(Map<String, dynamic> json) {
    return Directions(
      routes: List<Routes>.from(
          json['routes'].map((route) => Routes.fromJson(route))),
    );
  }
}

class Routes {
  final List<Steps> steps;

  Routes({required this.steps});

  factory Routes.fromJson(Map<String, dynamic> json) {
    return Routes(
      steps: List<Steps>.from(
          json['legs'][0]['steps'].map((step) => Steps.fromJson(step))),
    );
  }
}

class Steps {
  final String polyline;
  final Location startLocation;

  Steps({required this.polyline, required this.startLocation});

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
      polyline: json['polyline']['points'],
      startLocation: Location.fromJson(json['start_location']),
    );
  }
}

class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
