import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iyl/screens/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/navigateWithFade.dart';
import '../shared/toast.dart';

class AuthService {
  // Base URL of the API
  final String baseUrl = 'https://innovateyourlife.ai';

  //register endpoint
  Future<void> registerUser(
      {required String fullName,
      required String email,
      required String password,
      required String role,
      required BuildContext context}) async {
    const String endpoint = '/api/Authentication/Register';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    final Map<String, dynamic> body = {
      "FullName": fullName,
      "Email": email,
      "Password": password,
      "Role": role,
      "accesskey": " ",
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        showToast(message: 'Registration successful, proceed to login');
        await Future.delayed(const Duration(seconds: 2));
        navigateWithFade(
            context,
            const Wrapper(
              showSignIn: true,
            ));
      } else {
        showToast(
          message: 'Registration failed: ${response.body}',
        );
      }
    } catch (e) {
      showToast(
        message: 'Failed to register: $e',
      );
    }
  }

  // Login endpoint
  Future<void> login(String email, String password) async {
    const String endpoint = '/api/Authentication/Loginv1';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    final Map<String, dynamic> body = {
      "Email": email,
      "Password": password,
      "OTP": ""
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        if (responseData.isNotEmpty) {
          final Map<String, dynamic> userData = responseData[0];
          final token = userData['token'];

          if (token != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('authToken', token);
            await prefs.setString('Fullname', userData['Fullname']);
            await prefs.setString('email', userData['email']);
            await prefs.setString('role', userData['role']);
            await prefs.setString('referralcode', userData['referralcode']);
            showToast(message: 'Login successful');
          }
        }
      } else {
        showToast(message: 'Error: Login failed - ${response.body}');
      }
    } catch (e) {
      showToast(message: 'Error: Failed to login - $e');
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    return token != null;
  }

  // Logout method
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('authToken');
    await prefs.remove('Fullname');
    await prefs.remove('email');
    await prefs.remove('role');
    await prefs.remove('referralcode');

    showToast(message: 'Logout successful');
  }

  // Change Password endpoint
  Future<void> changePassword(String email, String newPassword) async {
    const String endpoint = '/api/Authentication/ChangePassword';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    // Request body
    final Map<String, dynamic> body = {
      "Email": email,
      "Password": newPassword,
      "OTP": ""
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        showToast(message: 'Password changed successfully');
      } else {
        showToast(
          message: 'Failed to change password: ${response.body}',
        );
      }
    } catch (e) {
      showToast(
        message: 'Failed to change password: $e',
      );
    }
  }
}
