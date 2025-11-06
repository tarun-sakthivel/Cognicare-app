import 'dart:async';
import 'dart:convert';
import 'package:cognicare/utils/local_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  // Replace with your local network IP or 10.0.2.2 for emulator
  final local = dotenv.env['localhost1'] ?? '';
  String get loginUrl => '$local/auth/token';
  String get registerUrl => '$local/auth/';

  // Login
  Future<String> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        'username': email,
        'email': email,
        'password': password,
      },
    );

    print("Status code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];
      final saved = await LocalStorage.saveToken(token);
      if (!saved) {
        throw Exception('Failed to save token');
      }

      // Verify the token was saved correctly
      final savedToken = await LocalStorage.getToken();
      print('AuthRepository: Original token: $token');
      print('AuthRepository: Saved token: $savedToken');

      return token;
    } else if (response.statusCode == 400) {
      throw Exception('Invalid credentials');
    } else {
      throw Exception('Login failed');
    }
  }

  // Signup
  Future<String> signup({
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final response = await http.post(
      Uri.parse(registerUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': username,
        'email': username,
        'password': password,
      }),
    );

    print("Status code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      // Signup returns the user object, you may want to call login next
      return data['access_token'];
    } else {
      throw Exception('Signup failed');
    }
  }
}
