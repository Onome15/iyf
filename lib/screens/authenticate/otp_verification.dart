import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyl/screens/authenticate/shared_methods.dart';

import '../../provider/auth_state_provider.dart';
import '../../shared/methods.dart';

class OtpVerificationPage extends ConsumerStatefulWidget {
  final String email;
  final String password;

  const OtpVerificationPage(
      {super.key, required this.email, required this.password});

  @override
  ConsumerState<OtpVerificationPage> createState() =>
      OtpVerificationPageState();
}

class OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  bool isLoading = false;

  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  bool _isResendEnabled = false;
  late Timer _timer;
  int _remainingTime = 60;
  String? _errorText;
  String? _resendMessage;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
        });
        _timer.cancel();
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _remainingTime = 60;
      _isResendEnabled = false;
      _resendMessage = null;
    });

    _timer.cancel();
    _startTimer();
  }

  String? _validateOtp() {
    String otp = _controllers.map((controller) => controller.text).join();
    if (otp.length < 6) {
      return 'Please enter a valid 6-digit code';
    } else if (!RegExp(r'^\d{6}$').hasMatch(otp)) {
      return 'OTP should only contain numbers';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authStateProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  'assets/iyl_logo.png',
                  width: 300,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Verify your email address",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "We sent you a 6-digit code to verify your email address (${widget.email})",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          child: TextFormField(
                            controller: _controllers[index],
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              } else if (!RegExp(r'^\d$').hasMatch(value)) {
                                return 'Only numbers are allowed';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (index < 5) {
                                  FocusScope.of(context).nextFocus();
                                }
                              } else if (index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    if (_errorText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          _errorText!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't get the code? ",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: _isResendEnabled
                        ? () async {
                            await authNotifier.requestOtp(
                              widget.email,
                            );
                            _resetTimer();
                            setState(() {
                              _resendMessage =
                                  "Code has been resent. Kindly check your mail.";
                            });
                          }
                        : null,
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        color: _isResendEnabled ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              if (_resendMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _resendMessage!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Text(
                "Expires in $_remainingTime seconds",
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  final otp = _controllers.map((c) => c.text).join();
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _errorText = null;
                      isLoading = true;
                    });
                    try {
                      // Pass password along with email and OTP
                      await authNotifier.confirmOtp(
                          widget.email, otp, widget.password, context);
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
                        "Submit",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
