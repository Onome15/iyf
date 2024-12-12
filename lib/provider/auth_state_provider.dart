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

  Future<void> _checkAuthState() async {
    final loggedIn = await _authService.isLoggedIn();
    state = loggedIn;
  }

  Future<void> login(String email, String password) async {
    try {
      await _authService.login(email, password);
      state = true;
    } catch (e) {
      state = false;
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = false;
  }
}
