import 'dart:convert';

import 'package:ecominds/model/api_response_model.dart';
import 'package:http/http.dart';

Future<ApiResponse?> getPicturesOfTheDayForPuzzle() async {
  try {
    final response = await get(
      Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=hk3XpBVhgwL070uWUVofUxtpxfLMeC2x6gNuYE8z'),
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

bool isNoInternetIssue(String error) {
  return error
      .startsWith('ClientException with SocketException: Failed host lookup:');
}

bool isNoInternetIssueUpdateProfile(String error) {
  return error
      .startsWith('ClientException with SocketException: Failed host lookup:');
}

const String noNetWorkMessage = 'No internet connection! please try again.';
