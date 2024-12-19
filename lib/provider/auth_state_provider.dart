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
      return isValid; // Return the result of the validation
    } catch (e) {
      state = false; // Set the state to indicate failure
      rethrow; // Re-throw the exception for error handling upstream
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
      // Confirm the OTP
      await _authService.confirmOtp(email, otp, password, context);

      // After successful OTP confirmation, set state to logged in
      state = true;
    } catch (e) {
      state = false; // Update state if OTP confirmation fails
      rethrow;
    }
  }

  /// Logs out the user
  Future<void> logout() async {
    await _authService.logout();
    state = false;
  }
}
