class LoginModel {
  final String username;
  final String password;
  final bool isPasswordVisible;
  final String? usernameError;
  final String? passwordError;
  final bool isLoading;
  final String? generalError;

  LoginModel({
    required this.username,
    required this.password,
    required this.isPasswordVisible,
    required this.usernameError,
    required this.passwordError,
    required this.isLoading,
    required this.generalError,
  });

  LoginModel copyWith({
    String? username,
    String? password,
    bool? isPasswordVisible,
    String? usernameError,
    String? passwordError,
    bool? isLoading,
    String? generalError,
  }) {
    return LoginModel(
      username: username ?? this.username,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      usernameError: usernameError,
      passwordError: passwordError,
      isLoading: isLoading ?? this.isLoading,
      generalError: generalError,
    );
  }
}
