class AuthStateModel {
  final String email;
  final String password;
  final String userName;
  final bool isLogin;
  final bool isLoading;

  const AuthStateModel({
    this.email = '',
    this.password = '',
    this.userName = '',
    this.isLogin = true,
    this.isLoading = false,
  });

  AuthStateModel copyWith({
    String? email,
    String? password,
    String? userName,
    bool? isLogin,
    bool? isLoading,
  }) {
    return AuthStateModel(
      email: email ?? this.email,
      password: password ?? this.password,
      userName: userName ?? this.userName,
      isLogin: isLogin ?? this.isLogin,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}