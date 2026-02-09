// SP
class AuthStateModel {
  final String email;
  final String password;
  final String userName;
  final String phoneNumber;
  final bool isLogin;
  final bool isLoading;
  final bool isFieldActive;

  const AuthStateModel({
    this.email = '',
    this.password = '',
    this.userName = '',
    this.phoneNumber = '',
    this.isLoading = false,
    this.isLogin = true,
    this.isFieldActive = true,
  });

  AuthStateModel copyWith({
    String? email,
    String? password,
    String? userName,
    String? phoneNumber,
    bool? isLogin,
    bool? isLoading,
    bool? isFieldActive
  }) {
    return AuthStateModel(
      email: email ?? this.email,
      password: password ?? this.password,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLogin: isLogin ?? this.isLogin,
      isLoading: isLoading ?? this.isLoading,
      isFieldActive: isFieldActive ?? this.isFieldActive,
    );
  }
}