import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/Likes/cubit/likes_cubit.dart';
import 'package:shopify/features/cart/cubits/cart_cubit.dart';
import 'package:shopify/features/cart/cubits/cart_states.dart';
import 'package:shopify/features/home/cubit/home_cubit.dart';
import 'package:shopify/root.dart';

void main() {
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
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => LikesCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Root(),
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
