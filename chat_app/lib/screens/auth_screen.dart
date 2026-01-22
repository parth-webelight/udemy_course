// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _submit(WidgetRef ref) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    final authNotifier = ref.read(authStateProvider.notifier);
    
    authNotifier.updateEmail(_emailController.text);
    authNotifier.updatePassword(_passwordController.text);
    if (!ref.read(authStateProvider).isLogin) {
      authNotifier.updateUserName(_usernameController.text);
    }
    
    final error = await authNotifier.submit();
    if (error != null && mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6C63FF),
              Color(0xFF9C88FF),
              Color(0xFFE8E4FF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  
                  Container(
                    width: screenWidth * 0.4,
                    height: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      "assets/images/Chat.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  
                  SizedBox(height: screenHeight * 0.03),
                  
                  Consumer(
                    builder: (context, ref, child) {
                      final authState = ref.watch(authStateProvider);
                      
                      return Text(
                        authState.isLogin ? 'Welcome Back!' : 'Create Account',
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: screenHeight * 0.01),
                  
                  Consumer(
                    builder: (context, ref, child) {
                      final authState = ref.watch(authStateProvider);
                      
                      return Text(
                        authState.isLogin 
                            ? 'Sign in to continue chatting' 
                            : 'Join our chat community',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: screenHeight * 0.04),
                  
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: screenWidth > 600 ? 400 : double.infinity,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.06),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final authState = ref.watch(authStateProvider);
                          
                          return Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                if (!authState.isLogin) ...[
                                  TextFormField(
                                    controller: _usernameController,
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      prefixIcon: const Icon(Icons.person_outline),
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    enableSuggestions: false,
                                    validator: (value) {
                                      if(value == null || value.isEmpty || value.trim().length < 4) {
                                        return 'Please enter at least 4 characters.';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                ],
                                
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    prefixIcon: const Icon(Icons.email_outlined),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter email';
                                    }
                                    return null;
                                  },
                                ),
                                
                                SizedBox(height: screenHeight * 0.02),
                                
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.length < 6) {
                                      return 'Password must be 6+ chars';
                                    }
                                    return null;
                                  },
                                ),
                                
                                SizedBox(height: screenHeight * 0.03),
                                
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: authState.isLoading ? null : () => _submit(ref),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: authState.isLoading 
                                          ? Colors.grey[300] 
                                          : const Color(0xFF6C63FF),
                                      foregroundColor: authState.isLoading 
                                          ? Colors.grey[600] 
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: authState.isLoading
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                    Colors.grey[600]!,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                authState.isLogin ? 'Signing in...' : 'Creating account...',
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.04,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            authState.isLogin ? 'Login' : 'Create Account',
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.045,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),
                                
                                SizedBox(height: screenHeight * 0.02),
                                
                                TextButton(
                                  onPressed: authState.isLoading ? null : () {
                                    _emailController.clear();
                                    _passwordController.clear();
                                    _usernameController.clear();
                                    ref.read(authStateProvider.notifier).toggleMode();
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.035,
                                        color: authState.isLoading ? Colors.grey[400] : Colors.grey[600],
                                      ),
                                      children: [
                                        TextSpan(
                                          text: authState.isLogin
                                              ? "Don't have an account? "
                                              : 'Already have an account? ',
                                        ),
                                        TextSpan(
                                          text: authState.isLogin ? 'Sign Up' : 'Login',
                                          style: TextStyle(
                                            color: authState.isLoading ? Colors.grey[400] : const Color(0xFF6C63FF),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
