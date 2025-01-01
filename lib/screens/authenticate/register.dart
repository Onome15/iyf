import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared_methods.dart';
import 'package:iyl/services/auth.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final VoidCallback? onToggleView;

  const RegisterScreen({super.key, this.onToggleView});

  @override
  ConsumerState<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool isCoach = true;
  bool isLoading = false;

  final Map<String, GlobalKey<FormState>> formKeys = {
    'Coach': GlobalKey<FormState>(),
    'User': GlobalKey<FormState>(),
  };

  final Map<String, TextEditingController> fullNameControllers = {
    'Coach': TextEditingController(),
    'User': TextEditingController(),
  };

  final Map<String, TextEditingController> emailControllers = {
    'Coach': TextEditingController(),
    'User': TextEditingController(),
  };

  final Map<String, TextEditingController> passwordControllers = {
    'Coach': TextEditingController(),
    'User': TextEditingController(),
  };

  final Map<String, TextEditingController> confirmPasswordControllers = {
    'Coach': TextEditingController(),
    'User': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    String currentRole = isCoach ? 'Coach' : 'User';

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKeys[currentRole],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    'assets/iyl_logo.png',
                    width: 300,
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    "Create An Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildToggleButton("Coach", isCoach),
                      const SizedBox(width: 16),
                      _buildToggleButton("User", !isCoach),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                buildLabel("Full Name"),
                buildTextField(
                  "Full Name",
                  fullNameControllers[currentRole]!,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please enter your full name";
                    } else if (!value.contains(" ") ||
                        value.trim().split(" ").length < 2) {
                      return "Please enter both first and last name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                buildLabel("Email Address"),
                buildTextField(
                  "Email Address",
                  emailControllers[currentRole]!,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    } else if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                buildLabel("Password"),
                buildTextField(
                  "Password",
                  passwordControllers[currentRole]!,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                buildLabel("Confirm Password"),
                buildTextField(
                  "Confirm Password",
                  confirmPasswordControllers[currentRole]!,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please confirm your password";
                    } else if (value !=
                        passwordControllers[currentRole]!.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (formKeys[currentRole]!.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      String fullName = fullNameControllers[currentRole]!.text;
                      String email = emailControllers[currentRole]!.text.trim();
                      String password = passwordControllers[currentRole]!.text;
                      String role = currentRole;

                      try {
                        await AuthService().registerUser(
                          context: context,
                          fullName: fullName,
                          email: email,
                          password: password,
                          role: role,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Registration failed: $e"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  style: buttonStyle,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )
                      : const Text(
                          "SIGN UP",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an account already? ",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: widget.onToggleView,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCoach = label == "Coach";
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
