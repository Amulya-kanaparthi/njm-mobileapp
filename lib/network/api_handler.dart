import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHandler {
  static const String baseUrl = "http://localhost:8000/"; // Replace with your API base URL

  ///  Generic GET Request
  static Future<dynamic> getRequest(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.get(url, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception("GET request failed: $e");
    }
  }

  ///  Generic POST Request
  static Future<dynamic> postRequest(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.post(
        url,
        headers: headers ?? {"Content-Type": "application/json"},
        body: jsonEncode(body ?? {}),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("POST request failed: $e");
    }
  }

  /// Response Handler
  static dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (statusCode >= 200 && statusCode < 300) {
      return responseBody; // ✅ Success
    } else if (statusCode == 401) {
      throw Exception("Unauthorized request");
    } else if (statusCode == 404) {
      throw Exception("Resource not found");
    } else {
      throw Exception("Error ${response.statusCode}: ${responseBody?['message'] ?? 'Unknown error'}");
    }
  }
}