// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart' show showDialog, BuildContext, Navigator;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/features/auth/model/login_model.dart';
import '../../../widgets/custom_dialog.dart' show CustomLoaderDialog;

final loginProvider = StateNotifierProvider<LoginViewModel, LoginModel>((ref) {
  return LoginViewModel();
});

class LoginViewModel extends StateNotifier<LoginModel> {
  LoginViewModel()
    : super(
        LoginModel(
          username: "",
          password: "",
          isPasswordVisible: false,
          usernameError: null,
          passwordError: null,
          isLoading: false,
          generalError: null,
        ),
      );

  void updateUsername(String value) {
    state = state.copyWith(
      username: value,
      usernameError: value.trim().isEmpty ? "Email required" : null,
      generalError: null,
    );
  }

  void updatePassword(String value) {
    state = state.copyWith(
      password: value,
      passwordError: value.trim().isEmpty ? "Password required" : null,
      generalError: null,
    );
  }

  void togglePassword() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  bool validate() {
    String? userError;
    String? passError;

    if (state.username.isEmpty) {
      userError = "Email required";
    }

    if (state.password.isEmpty) {
      passError = "Password required";
    }

    state = state.copyWith(usernameError: userError, passwordError: passError);

    return userError == null && passError == null;
  }

  Future<bool> login(BuildContext context) async {
    if (!validate()) return false;
    showLoaderDialog(context);
    state = state.copyWith(isLoading: true, generalError: null);
    
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (state.username.trim().toLowerCase() == "test@example.com" && 
          state.password.trim() == "password123") {
        state = state.copyWith(isLoading: false);
        Navigator.of(context).pop();
        return true;
      } else {
        state = state.copyWith(isLoading: false, generalError: "Invalid credentials");
        Navigator.of(context).pop();
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, generalError: e.toString());
      Navigator.of(context).pop(); 
      return false;
    }
  }
  void showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomLoaderDialog(),
    );
  }

}
