import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopify/core/services/getit_service.dart' as GetItService;
import 'package:shopify/core/utils/prefs.dart' show Prefs;
import 'package:shopify/core/services/getit_service.dart';
import 'package:shopify/features/cart/data/repos/cart_repo_impl.dart';
import 'package:shopify/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shopify/features/category/presentation/cubit/caterories_products_cubit/category_products_cubit.dart';
import 'package:shopify/features/category/presentation/cubit/home_categories_cubit/home_categories_cubit.dart';
import 'package:shopify/features/search/presentation/cubit/cubit/search_cubit.dart';
import 'package:shopify/features/wishlist/data/repo/wishlist_repo_implementation.dart';
import 'package:shopify/features/wishlist/presentation/cubit/cubit/wishlist_cubit.dart';
import 'package:shopify/firebase_options.dart';
import 'package:shopify/shoply.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/home/presentation/cubit/home_cubit.dart';

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
        builder:
            (context, child) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => HomeCubit()),
                BlocProvider(create: (context) => HomeCategoriesCubit()),
                BlocProvider(create: (context) => CategoryProductsCubit()),
                BlocProvider(create: (context) => SearchCubit()),
                BlocProvider(
                  create:
                      (context) => CartCubit(
                        cartService: GetItService.getIt.get<CartRepoImpl>(),
                      )..getCartProducts(),
                ),
                BlocProvider(
                  create:
                      (context) => WishlistCubit(
                        GetItService.getIt.get<WishlistRepoImpl>(),
                      )..getWishlistProducts(),
                ),
              ],
              child: const Shoply(),
            ),
      ),
    );
  } catch (e, s) {
    log("❌ Initialization Error: $e");
    log("❌ Stacktrace: $s");
  }
}
