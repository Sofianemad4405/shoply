import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopify/core/app_router.dart';
import 'package:shopify/core/fire_base_auth_service.dart';
import 'package:shopify/core/prefs.dart' show Prefs;
import 'package:shopify/core/services/getit_service.dart';
import 'package:shopify/core/services/getit_service.dart' as GetItService;
import 'package:shopify/features/auth/presentation/view/sign_in_page_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopify/features/auth/presentation/view/sign_up_page_view.dart';
import 'package:shopify/features/splash/splash_screen.dart';
import 'package:shopify/firebase_options.dart';
import 'package:shopify/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Prefs.init();
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log("✅ Firebase Initialized Successfully");
    setupGetit();
    runApp(
      ScreenUtilInit(
        designSize: const Size(375.14, 744.86),
        builder: (context, child) => const Shopify(),
      ),
    );
  } catch (e, s) {
    log("❌ Initialization Error: $e");
    log("❌ Stacktrace: $s");
  }
}

class Shopify extends StatelessWidget {
  const Shopify({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isLoggedIn = Prefs.getBool(Constants.kisLoggedIn);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      // home: FutureBuilder(
      //   future: GetItService.getIt.get<FireBaseAuthService>().isLoggedIn(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.data == true) {
      //         return Root();
      //       } else {
      //         return SigninPageView();
      //       }
      //     } else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
      home: const SplashScreen(),
      // home: isLoggedIn ? Root() : SigninPageView(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Inter",
        useMaterial3: true,
      ),
      routes: {
        SigninPageView.routeName: (context) => SigninPageView(),
        SignUpPageView.routeName: (context) => SignUpPageView(),
      },
    );
  }
}
