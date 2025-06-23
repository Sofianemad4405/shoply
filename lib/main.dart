import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/Info/cubits/cubit/profile_cubit.dart';
import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
import 'package:shopify/features/auth/view/sign_up_page.dart';
import 'package:shopify/features/cart/cubits/cart_cubit.dart';
import 'package:shopify/features/cart/cubits/cart_states.dart';
import 'package:shopify/features/home/cubit/home_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopify/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase Initialized Successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(const Shopify());
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
