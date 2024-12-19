import 'package:flutter/material.dart';

import '../../../services/auth.dart';
import '../../../shared/navigateWithFade.dart';
import '../../../shared/toast.dart';
import '../../wrapper.dart';
import '../shared_methods.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({required this.email, Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
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
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                buildLabel("OTP"),
                buildTextField(
                  "Enter OTP",
                  _otpController,
                  (value) {
                    if (value!.isEmpty) {
                      return "Please enter the OTP sent to your email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                buildLabel("New Password"),
                buildPasswordField(
                  _passwordController,
                  obscureText: _obscureText,
                  onToggleVisibility: (isVisible) {
                    setState(() {
                      _obscureText = isVisible;
                    });
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final success = await AuthService().changePassword(
                          widget.email,
                          _passwordController.text.trim(),
                          _otpController.text.trim(),
                        );

                        if (success) {
                          showToast(
                              message:
                                  'Password changed successfully, proceed to login');
                          Future.delayed(const Duration(seconds: 2), () {
                            navigateWithFade(
                              context,
                              const Wrapper(
                                showSignIn: true,
                              ),
                            );
                          });
                        } else {
                          showToast(
                              message: "OTP is incorrect. Please try again.");
                        }
                      } catch (e) {
                        showToast(message: "Error: $e");
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
                          "RESET PASSWORD",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
