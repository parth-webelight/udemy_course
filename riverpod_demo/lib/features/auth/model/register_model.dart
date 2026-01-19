class RegisterModel {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  final String? usernameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLoading;
  final bool isEnable;
  final String? generalError;

  RegisterModel({
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.usernameError,
    required this.emailError,
    required this.passwordError,
    required this.confirmPasswordError,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.isLoading,
    required this.isEnable,
    required this.generalError,
  });

  RegisterModel copyWith({
    String? userName,
    String? email,
    String? password,
    String? confirmPassword,
    String? usernameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isLoading,
    bool? isEnable,
    String? generalError,
  }) {
    return RegisterModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      usernameError: usernameError,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      isEnable: isLoading ?? this.isEnable,
      generalError: generalError,
    );
  }
}
