import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:riverpod_demo/routes.dart';


void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return const MaterialApp(
          title: 'Riverpod',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.onGenerateRoute,
          initialRoute: Routes.splash,
        );
      },
    );
  }
}