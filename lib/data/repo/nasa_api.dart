import 'dart:convert';

import 'package:ecominds/model/api_response_model.dart';
import 'package:ecominds/utils/api_helper.dart';
import 'package:http/http.dart';

const apiKey = 'hk3XpBVhgwL070uWUVofUxtpxfLMeC2x6gNuYE8z';

Future<ApiResponse?> getPicturesOfTheDayForPuzzle() async {
  try {
    final response = await get(
      Uri.parse('https://api.nasa.gov/planetary/apod?api_key=$apiKey'),
      headers: {},
    );
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  } catch (e) {
    if (isNoInternetIssue(e.toString())) {
      return Future.error(noNetWorkMessage);
    }
    return Future.error(e.toString());
  }
}

Future<ApiResponse?> getSateliteImage() async {
  try {
    final response = await get(
      Uri.parse(
          'https://api.nasa.gov/planetary/earth/imagery?lon=100.75&lat=1.5&date=2014-02-01&api_key=$apiKey'),
      headers: {},
    );
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  } catch (e) {
    if (isNoInternetIssue(e.toString())) {
      return Future.error(noNetWorkMessage);
    }
    return Future.error(e.toString());
  }
}

Future<List<dynamic>> getFloodEvents() async {
  String url = "https://eonet.gsfc.nasa.gov/api/v3/events";

  final response = await get(Uri.parse(url));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    // Filter the events for flood category
    List<dynamic> floodEvents = data['events'].where((event) {
      return event['categories']
          .any((category) => category['title'] == 'Flood');
    }).toList();
    return floodEvents;
  } else {
    throw Exception("Failed to load flood events");
  }
}
