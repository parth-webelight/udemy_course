import 'package:flutter/material.dart';
import 'features/auth/view/login_screen.dart' show LoginScreen;
import 'features/auth/view/register_screen.dart' show RegisterScreen;
import 'features/auth/view/splash_screen.dart' show SplashScreen;

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('404 - Page Not Found'))),
        );
    }
  }
}
