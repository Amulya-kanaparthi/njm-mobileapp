import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  static const String baseUrl = "http://10.0.2.2:8000/"; // Replace with your API base URL

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

class AuthService{
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email','profile'
    ],
    serverClientId: '737789089001-52l833ucndp6ics9nj3tm5go51li2b5f.apps.googleusercontent.com',
  );

  Future<Map<String,dynamic>?> signInWithGoogle() async{
    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if(googleUser == null){
        print('Google Sign-In aborted by user');
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final response = await ApiHandler.postRequest('auth/google/mobile-login', body : {
        'idToken': googleAuth.idToken,
        'email': googleUser.email,
        'displayName': googleUser.displayName,
        'photoUrl': googleUser.photoUrl,
      });
      
      print('Google Sign-In successful: $response');
      return response;
    }catch(error){
      print('Google Sign-In failed: $error');
      return null;
    }
  }
}