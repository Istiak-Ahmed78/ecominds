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
