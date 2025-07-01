import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopify/features/Info/cubits/cubit/profile_cubit.dart';
import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
import 'package:shopify/features/auth/cubit/auth_cubit.dart';
import 'package:shopify/features/auth/view/sign_up_page.dart';
import 'package:shopify/features/cart/cubits/cart_cubit.dart';
import 'package:shopify/features/home/cubit/home_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopify/features/home/model/product_model.dart';
import 'package:shopify/firebase_options.dart';
import 'package:shopify/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    await Hive.initFlutter();
    log("✅ Hive Initialized");

    // Register Adapters
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(MetaAdapter());
    Hive.registerAdapter(ReviewAdapter());
    // Open Boxes
    await Hive.openBox('userBox');
    await Hive.openBox<Product>('productsBox');
    await Hive.openBox<bool>('likedBox');
    await Hive.openBox<bool>('cartBox');

    log("✅ Hive Boxes Opened Successfully");
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log("✅ Firebase Initialized Successfully");

    runApp(const Shopify());
  } catch (e, s) {
    log("❌ Initialization Error: $e");
    log("❌ Stacktrace: $s");
  }
}

class Shopify extends StatelessWidget {
  const Shopify({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box('userBox');
    bool isLoggedIn = userBox.get('isLoggedIn', defaultValue: false);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => LikesCubit()),
        BlocProvider(
          create:
              (context) => HomeCubit(
                cartCubit: context.read<CartCubit>(),
                likesCubit: context.read<LikesCubit>(),
              )..init(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            isLoggedIn
                ? Root(
                  userData: userBox.get('userData'),
                  userCredential: userBox.get('userCredential'),
                )
                : SignUpPage(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.white),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Inter",
          useMaterial3: true,
        ),
      ),
    );
  }
}
