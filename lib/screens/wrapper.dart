import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyl/screens/home/home_page.dart';
import '../provider/auth_state_provider.dart';
import 'authenticate/login.dart';
import 'authenticate/register.dart';

class Wrapper extends ConsumerStatefulWidget {
  final bool showSignIn;

  const Wrapper({super.key, required this.showSignIn});
  @override
  ConsumerState<Wrapper> createState() => WrapperState();
}

class WrapperState extends ConsumerState<Wrapper> {
  late bool showSignIn;

  @override
  void initState() {
    super.initState();
    showSignIn = widget.showSignIn;
  }

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(authStateProvider);

    if (isLoggedIn) {
      return const HomePage();
    } else {
      return showSignIn
          ? LoginScreen(onToggleView: toggleView)
          : RegisterScreen(onToggleView: toggleView);
    }
  }
}
