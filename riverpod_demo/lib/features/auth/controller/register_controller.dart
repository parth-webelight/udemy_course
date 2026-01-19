// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/custom_dialog.dart';
import '../model/register_model.dart';

final registerProvider =
    StateNotifierProvider<RegisterViewModel, RegisterModel>((ref) {
      return RegisterViewModel();
    });

class RegisterViewModel extends StateNotifier<RegisterModel> {
  RegisterViewModel()
    : super(
        RegisterModel(
          userName: "",
          email: "",
          password: "",
          confirmPassword: "",
          isPasswordVisible: false,
          isConfirmPasswordVisible: false,
          usernameError: null,
          emailError: null,
          passwordError: null,
          confirmPasswordError: null,
          isLoading: false,
          isEnable: true,
          generalError: null,
        ),
      );

  final emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  final passwordRegex = RegExp(r'^[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{8,}$');

  void togglePassword() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPassword() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  void updatePassword(String value) {
    String? error;

    if (value.isEmpty) {
      error = "Password required";
    } else if (!passwordRegex.hasMatch(value)) {
      error = "Must be 8+ characters and include allowed symbols.";
    } else {
      error = null;
    }

    state = state.copyWith(password: value, passwordError: error);
  }

  void updateConfirmPassword(String value) {
    String? error;

    if (value.isEmpty) {
      error = "Confirm password required";
    } else if (value != state.password) {
      error = "Passwords do not match";
    } else {
      error = null;
    }

    state = state.copyWith(confirmPassword: value, confirmPasswordError: error);
  }

  void updateUserName(String value) {
    state = state.copyWith(
      userName: value,
      usernameError: value.isEmpty ? "Username required" : null,
    );
  }

  void updateEmail(String value) {
    String? err;

    if (value.isEmpty) {
      err = "Email required";
    } else if (!emailRegex.hasMatch(value)) {
      err = "Invalid email format";
    } else {
      err = null;
    }

    state = state.copyWith(email: value, emailError: err);
  }

  void updateEnableField(bool value) {
    state = state.copyWith(isEnable: value);
  }

  bool validateForm() {
    String? userErr;
    String? emailErr;
    String? passErr;
    String? confirmErr;

    if (state.userName.isEmpty) userErr = "Username required";

    if (state.email.isEmpty)
      emailErr = "Email required";
    else if (!emailRegex.hasMatch(state.email))
      emailErr = "Invalid email format";

    if (state.password.isEmpty)
      passErr = "Password required";
    else if (!passwordRegex.hasMatch(state.password))
      passErr = "Password format invalid";

    if (state.confirmPassword.isEmpty)
      confirmErr = "Confirm password required";
    else if (state.confirmPassword != state.password)
      confirmErr = "Passwords do not match";

    state = state.copyWith(
      usernameError: userErr,
      emailError: emailErr,
      passwordError: passErr,
      confirmPasswordError: confirmErr,
    );

    return userErr == null &&
        emailErr == null &&
        passErr == null &&
        confirmErr == null;
  }

  Future<bool> register(BuildContext context) async {
    updateEnableField(false);

    if (!validateForm()) {
      updateEnableField(true);
      return false;
    }
    showLoaderDialog(context);
    state = state.copyWith(isLoading: true, generalError: null);

    try {
      await Future.delayed(const Duration(seconds: 2));
      
      state = state.copyWith(isLoading: false);
      updateEnableField(true);
      Navigator.of(context).pop(); 
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, generalError: e.toString());
      updateEnableField(true);
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