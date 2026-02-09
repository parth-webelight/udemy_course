// ignore_for_file: no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.teal),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.teal, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.teal, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(authProvider);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  state.isLogin ? "Login" : "Register",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.isLogin ? "Login your account" : "Create your account",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (!state.isLogin)
                        TextFormField(
                          enabled: state.isFieldActive,
                          controller: _userNameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.teal,
                          decoration: _inputDecoration(
                            label: "Username",
                            icon: Icons.person,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter username";
                            }
                            if (value.length < 3) {
                              return "Username must be at least 3 characters";
                            }
                            return null;
                          },
                        ),
                      if (!state.isLogin) const SizedBox(height: 16),
                      TextFormField(
                        enabled: state.isFieldActive,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.teal,
                        decoration: _inputDecoration(
                          label: "Email",
                          icon: Icons.email,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter email";
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                      ),
                      if (!state.isLogin) const SizedBox(height: 16),
                      if (!state.isLogin)
                        TextFormField(
                          enabled: state.isFieldActive,
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.teal,
                          maxLength: 10,
                          decoration: _inputDecoration(
                            label: "Phone Number",
                            icon: Icons.phone,
                          ).copyWith(counterText: ""),
                          validator: (value) {
                            if (value == null || value.length != 10) {
                              return "Enter valid phone number";
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 16),
                      TextFormField(
                        enabled: state.isFieldActive,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.teal,
                        obscureText: true,
                        decoration: _inputDecoration(
                          label: "Password",
                          icon: Icons.lock,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      if (!state.isLogin) const SizedBox(height: 16),
                      if (!state.isLogin)
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          enabled: state.isFieldActive,
                          cursorColor: Colors.teal,
                          obscureText: true,
                          decoration: _inputDecoration(
                            label: "Confirm Password",
                            icon: Icons.lock_outline,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Confirm your password";
                            }
                            if (value != _passwordController.text) {
                              return "Password and confirm password do not match";
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: state.isLoading
                              ? null
                              : () async {
                                  if (!_formKey.currentState!.validate())
                                    return;
                                
                                  FocusScope.of(context).unfocus();
                                  final auth = ref.read(authProvider.notifier);
                                  auth.updateFieldActive();
                                  auth.updateUserName(_userNameController.text);
                                  auth.updateEmail(_emailController.text);
                                  auth.updatePhoneNumber(_phoneNumberController.text);
                                  auth.updatePassword(_passwordController.text);
                                  final response = await ref
                                      .read(authProvider.notifier)
                                      .submit();
                                  if (response != null) {
                                    Fluttertoast.showToast(msg: response);
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: state.isLogin
                                          ? "Login Successful"
                                          : "Signup Successful",
                                    );
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  }
                                },
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.teal,
                                    ),
                                  ),
                                )
                              : Text(
                                  state.isLogin ? "Login" : "Register",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.isLogin
                                ? "Not an account?"
                                : "Already have an account?",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              ref
                                  .read(authProvider.notifier)
                                  .updateLoginState();
                            },
                            child: Text(
                              state.isLogin ? "SignUp" : "Login",
                              style: GoogleFonts.poppins(
                                color: Colors.teal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
