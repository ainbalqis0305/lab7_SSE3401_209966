import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = LinkedHashSet<Marker>();
  Set<Polygon> _polygons = LinkedHashSet<Polygon>();
  Set<Polyline> _polylines = LinkedHashSet<Polyline>();
  Set<Circle> _circles = LinkedHashSet<Circle>();

  late GoogleMapController _mapController;
  late BitmapDescriptor _markerIcon;

  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolygons();
    _setPolylines();
    _setCircles();
    _setMapStyle();
    //_loadMapStyle();
  }

  /*void _loadMapStyle() async {
  String style = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
  _mapController.setMapStyle(jsonEncode(jsonDecode(style)));
}*/

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/noodle_icon.png');
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _mapController.setMapStyle(style);
  }

  void _setPolygons() {
    List<LatLng> polygonLatLongs = <LatLng>[];
    polygonLatLongs.add(LatLng(3.1329, 101.6839)); //KL
    polygonLatLongs.add(LatLng(3.1320, 101.6840));
    polygonLatLongs.add(LatLng(3.1339, 101.6811));
    polygonLatLongs.add(LatLng(3.1389, 101.6842));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: polygonLatLongs,
        fillColor: Colors.white,
        strokeWidth: 1,
      ),
    );
  }

  void _setPolylines() {
    List<LatLng> polylinesLatLongs = <LatLng>[];
    polylinesLatLongs.add(LatLng(3.1349, 101.6803)); //KL
    polylinesLatLongs.add(LatLng(3.1329, 101.6839)); //KL
    polylinesLatLongs.add(LatLng(3.1320, 101.6840));
    polylinesLatLongs.add(LatLng(3.1339, 101.6811));
    polylinesLatLongs.add(LatLng(3.1389, 101.6842));

    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        points: polylinesLatLongs,
        color: Colors.purple,
        width: 1,
      ),
    );
  }

  void _setCircles() {
    _circles.add(
      Circle(
        circleId: CircleId("0"),
        center: LatLng(3.1319, 101.6841),
        radius: 1000,
        strokeWidth: 2,
        fillColor: Color.fromRGBO(102, 51, 153, .5),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(3.1319, 101.6841),
            infoWindow: InfoWindow(
                title: "Kuala Lumpur", snippet: "An interesting city"),
            icon: _markerIcon),
      );
    });
  }

  //_setMapStyle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
        ),
        body: Stack(children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(3.1319, 101.6841),
              zoom: 12,
            ),
            markers: _markers,
            polygons: _polygons,
            polylines: _polylines,
            circles: _circles,
            myLocationEnabled: true,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: Text("Coding with Ain"),
          )
        ]));
  }
}
