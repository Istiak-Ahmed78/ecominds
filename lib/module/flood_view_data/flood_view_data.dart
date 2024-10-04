import 'package:ecominds/data/repo/nasa_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart'; // Import latlong2 package

class FloodEventScreen extends StatefulWidget {
  @override
  _FloodEventScreenState createState() => _FloodEventScreenState();
}

class _FloodEventScreenState extends State<FloodEventScreen> {
  List<dynamic> floodEvents = [];
  bool isLoading = true;
  String? imageUrl;
  double? latitude;
  double? longitude;

  Future<void> fetchFloodEvents() async {
    try {
      // Replace this with the actual API call for flood events
      List<dynamic> events = await getFloodEvents();
      setState(() {
        floodEvents = events;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching flood events: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    fetchFloodEvents();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        isLoading = false;
      });
      // Location services are not enabled, don't continue
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          isLoading = false;
        });
        // Permissions are denied, don't continue
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, don't continue
      setState(() {
        isLoading = false;
      });
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Use the current location's latitude and longitude
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      // Fetch the image for the current location
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-Time Flood Tracker'),
      ),
      body: isLoading && (latitude == null || longitude == null)
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter:
                    LatLng(latitude!, longitude!), // Example initial map center
                initialZoom: 2.0, // Example zoom level
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName:
                      'com.example.app', // Required for OpenStreetMap policy
                ),
                MarkerLayer(
                  markers: floodEvents.map((event) {
                    final coordinates = event['geometry'][0]['coordinates'];
                    return Marker(
                      point: LatLng(coordinates[1], coordinates[0]),
                      width: 80.0,
                      height: 80.0,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}
