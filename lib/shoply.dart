import 'package:flutter/material.dart';
import 'package:shopify/core/utils/app_router.dart';
import 'package:shopify/features/splash/splash_screen.dart';

class Shoply extends StatelessWidget {
  const Shoply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      home: const SplashScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white),
        scaffoldBackgroundColor: Color(0xffEFF0F1),
        fontFamily: "Inter",
        useMaterial3: true,
      ),
    );
  }
}
