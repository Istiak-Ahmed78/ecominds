import 'package:ecominds/data/repo/nasa_api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  String? imageUrl;
  bool isLoading = false;
  double? latitude;
  double? longitude;

  // Replace with your own NASA API key
  final String apiUrl = 'https://api.nasa.gov/planetary/earth/imagery';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Method to get the current location of the user
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
      fetchImage(); // Fetch the image for the current location
    });
  }

  // Fetch image using current location
  Future<void> fetchImage() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (latitude != null && longitude != null) {
        // Construct the URL with the current latitude and longitude
        imageUrl =
            '$apiUrl?lon=$longitude&lat=$latitude&date=2020-05-01&dim=0.1&api_key=$apiKey';
      }

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        imageUrl = null;
      });
      print('Error fetching image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NASA Landsat 8 Image for Current Location',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : longitude == null
                ? const Text('Turn on your location')
                : imageUrl != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 50),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: const Text(
                              'NASA Landsat 8 Image for Current Location',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Image.network(imageUrl!),
                        ],
                      )
                    : const Text('No image available or failed to load'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
