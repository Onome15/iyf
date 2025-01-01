import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyl/screens/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/auth_state_provider.dart';
import '../../shared/navigateWithFade.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String fullName = '';
  String email = '';
  String role = '';
  bool onboarding = false;
  String referralCode = '';

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('Fullname') ?? 'N/A';
      email = prefs.getString('email') ?? 'N/A';
      role = prefs.getString('role') ?? 'N/A';
      onboarding = prefs.getBool('onboarding') ?? false;
      referralCode = prefs.getString('referralcode') ?? 'N/A';
    });
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    final authNotifier = ref.read(authStateProvider.notifier);
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                navigateWithFade(context, const Wrapper(showSignIn: true));
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
    if (shouldLogout == true) {
      await authNotifier.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false, // Removes the back button
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Full Name: $fullName', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Email: $email', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Role: $role', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('onboarding: $onboarding',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Referral Code: $referralCode',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
