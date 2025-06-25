import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopify/features/Info/cubits/cubit/profile_cubit.dart';
import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
import 'package:shopify/features/auth/cubit/auth_cubit.dart';
import 'package:shopify/features/auth/view/sign_up_page.dart';
import 'package:shopify/features/cart/cubits/cart_cubit.dart';
import 'package:shopify/features/cart/cubits/cart_states.dart';
import 'package:shopify/features/home/cubit/home_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopify/features/home/model/product_model.dart';
import 'package:shopify/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    await Hive.initFlutter();
    log("✅ Hive Initialized");

    // Register Adapters
    Hive.registerAdapter(ProductAdapter());
    // Open Boxes
    await Hive.openBox('userBox');
    await Hive.openBox<Product>('likedBox');
    await Hive.openBox<Product>('cartBox');

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  CartCubit(NoProductsState(message: "Your cart is empty")),
        ),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => LikesCubit()),
        BlocProvider(
          create:
              (context) => HomeCubit(
                cartCubit: context.read<CartCubit>(),
                likesCubit: context.read<LikesCubit>(),
              ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignUpPage(),
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
