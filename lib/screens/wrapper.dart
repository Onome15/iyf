import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyl/screens/home/home_page.dart';
import '../provider/auth_state_provider.dart';
import 'authenticate/login.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authStateProvider);

    return isLoggedIn ? const HomePage() : const LoginScreen();
  }
}
