import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyl/screens/authenticate/forget_password/forget_password.dart';
import 'package:iyl/shared/toast.dart';
import '../../provider/auth_state_provider.dart';
import '../../shared/navigateWithFade.dart';
import 'otp_verification.dart';
import 'shared_methods.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final VoidCallback? onToggleView;

  const LoginScreen({super.key, this.onToggleView});

  @override
  ConsumerState<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authStateProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 250, 24, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/iyl_logo.png',
                      width: 300,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  buildLabel("Email Address"),
                  buildTextField(
                    "Email Address",
                    _emailController,
                    (value) =>
                        value!.isEmpty ? "Please enter your email" : null,
                  ),
                  const SizedBox(height: 20),
                  buildLabel("Password"),
                  buildPasswordField(
                    _passwordController,
                    obscureText: _obscureText,
                    onToggleVisibility: (isVisible) {
                      setState(() {
                        _obscureText = isVisible;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.red[300]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          final isValid =
                              await authNotifier.validateCredentials(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                          if (isValid) {
                            await authNotifier.requestOtp(
                              _emailController.text.trim(),
                            );
                            // Navigate to OTP page
                            navigateWithFade(
                              context,
                              OtpVerificationPage(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          }
                        } catch (e) {
                          showToast(message: 'Error: $e');
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
                            "LOGIN",
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
                          "Not a member? ",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: widget.onToggleView,
                          child: const Text(
                            "Register",
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
      ),
    );
  }
}
