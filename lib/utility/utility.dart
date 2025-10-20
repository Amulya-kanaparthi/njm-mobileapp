import 'dart:convert';

class Utility {
  // Email Validator
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Phone Number Validator
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    const pattern = r'^[0-9]{10}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  // Password Validator
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    const pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 characters,include upper & lower case letters,1 number and 1 special character';
    }
    return null;
  }

  // Username Validator
  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    const pattern = r'^[a-zA-Z0-9_]{3,15}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Username must be 3-15 characters,letters, numbers, or underscores only';
    }
    return null;
  }

  static void prettyPrintJson(dynamic jsonObject) {
    const encoder = JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(jsonObject);
    print(prettyString);
  }
}

class JsonUtils {
  /// Pretty-print any JSON object
  static void prettyPrint(dynamic jsonObject) {
    const encoder = JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(jsonObject);
    print(prettyString);
  }
}