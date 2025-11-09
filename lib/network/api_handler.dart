// api/api_handler.dart
import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:njm_mobileapp/utility/Utility.dart';


class ApiHandler {
  static const String baseUrl =
      "http://192.168.31.149:8000"; // Replace with your API base URL

  /// Generic GET Request
  static Future<dynamic> getRequest(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse("$baseUrl$endpoint");

    print("-------------------------------------------------------------------------------------------------------------");
    print("[GET REQUEST]");
    print("Base URL: $baseUrl");
    print("Final URL: $url");
    if (headers != null && headers.isNotEmpty) print("Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);
      print("Response (${response.statusCode}):");
      return _handleResponse(response);
    } catch (e) {
      print("GET request failed: $e");
      rethrow;
    }
  }

  /// Generic POST Request
  static Future<dynamic> postRequest(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final requestBody = jsonEncode(body ?? {});

    print("-------------------------------------------------------------------------------------------------------------");
    print("POST REQUEST");
    print("Base URL: $baseUrl");
    print("Requested URL: $url");
    if (headers != null && headers.isNotEmpty) print("Headers: $headers");
    print("Body:");
    JsonUtils.prettyPrint(body ?? {}); // Pretty-print request body

    try {
      final response = await http.post(
        url,
        headers: headers ?? {"Content-Type": "application/json"},
        body: requestBody,
      );

      print("Response (${response.statusCode}):");
      return _handleResponse(response);
    } catch (e) {
      print("POST request failed: $e");
      rethrow;
    }
  }

  static String buildEndpoint(String path, [Map<String, String>? params]) {
  if (params == null || params.isEmpty) return path;

  params.forEach((key, value) {
    path = path.replaceAll(':$key', value);
  });
  return path;
}


  /// Response Handler (returns JSON as-is and pretty-prints it)
  static dynamic _handleResponse(http.Response response) {
    final responseBody = response.body.isNotEmpty
        ? jsonDecode(response.body)
        : null;

    print("[RESPONSE JSON]");
    if (responseBody != null) {
      JsonUtils.prettyPrint(responseBody); // Pretty-print response
    } else {
      print("Empty response body");
    }
    print("=============================================================================================================");

    return responseBody; // Return JSON as-is
  }
}

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId:
        '737789089001-52l833ucndp6ics9nj3tm5go51li2b5f.apps.googleusercontent.com',
  );

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google Sign-In aborted by user');
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final response = await ApiHandler.postRequest(
        'auth/google/mobile-login',
        body: {
          'idToken': googleAuth.idToken,
          'email': googleUser.email,
          'displayName': googleUser.displayName,
          'photoUrl': googleUser.photoUrl,
        },
      );

      print('Google Sign-In successful: $response');
      return response;
    } catch (error) {
      print('Google Sign-In failed: $error');
      return null;
    }
  }
}
