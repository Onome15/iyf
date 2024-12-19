import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth.dart';

// Auth state provider
final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  return AuthStateNotifier(AuthService());
});

class AuthStateNotifier extends StateNotifier<bool> {
  final AuthService _authService;

  AuthStateNotifier(this._authService) : super(false) {
    // Check the initial authentication state
    _checkAuthState();
  }

  /// Checks if the user is logged in
  Future<void> _checkAuthState() async {
    final loggedIn = await _authService.isLoggedIn();
    state = loggedIn;
  }

  /// Requests an OTP for the given email
  Future<void> requestOtp(String email) async {
    try {
      await _authService.requestOtp(email);
    } catch (e) {
      state = false; // Ensure state reflects failure
      rethrow;
    }
  }

  /// Validates Credentials
  Future<bool> validateCredentials(String email, String password) async {
    try {
      final isValid = await _authService.validateCredentials(email, password);
      return isValid;
    } catch (e) {
      state = false;
      rethrow;
    }
  }

  /// Confirms OTP and performs login
  Future<void> confirmOtp(
    String email,
    String otp,
    String password,
    BuildContext context,
  ) async {
    try {
      await _authService.confirmOtp(email, otp, password, context);
      state = true;
    } catch (e) {
      state = false;
      rethrow;
    }
  }

  /// Logs out the user
  Future<void> logout() async {
    await _authService.logout();
    state = false;
  }
}
