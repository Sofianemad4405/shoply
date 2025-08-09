// import 'package:bloc/bloc.dart';
// import 'package:shopify/core/models/product_entity.dart';
// import 'package:shopify/core/services/fire_store_service.dart';
// import 'package:shopify/core/services/getit_service.dart';
// import 'package:shopify/core/models/product_model.dart';
// import 'package:shopify/features/home/data/repos/home_service.dart';

// part 'home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   // final LikesCubit likesCubit;
//   // final CartCubit cartCubit;
//   HomeCubit() : super(HomeLoading());

//   bool isAsc = true;

//   List<Product> allProducts = [];

//   Future<void> init() async {
//     emit(HomeLoading());
//     allProducts = await fetchAllProducts();
//     emit(HomeLoaded(products: allProducts));
//   }

//   // void loadLikes() {
//   //   likesCubit.getLikedProducts(allProducts);
//   // }

//   // void loadCart() {
//   //   log("ya alby ${cartCubit.cartBox.length.toString()}");
//   //   cartCubit.getCartProducts(allProducts);
//   // }

//   Future<List<Product>> fetchAllProducts() async {
//     emit(HomeLoading());
//     try {
//       final products =
//           await HomeService(
//             databaseService: getIt<FireStoreService>(),
//           ).getAllProducts();
//       allProducts = products;
//       emit(HomeLoaded(products: products));
//       return products;
//     } catch (e) {
//       emit(HomeError(message: e.toString()));
//       return [];
//     }
//   }

//   Future<List<Product>> fetchProductsSorted(String sortBy, String order) async {
//     emit(HomeLoading());
//     try {
//       final products = await HomeService(
//         databaseService: getIt<FireStoreService>(),
//       ).sortProductsByPrice(sortBy, order);
//       emit(HomeLoaded(products: products));
//       return products;
//     } catch (e) {
//       emit(HomeError(message: e.toString()));
//       return [];
//     }
//   }

//   // Future<void> saveProducts(List<Product> products) async {
//   //   for (var product in products) {
//   //     await box.put(product.id, product);
//   //   }
//   //   allProducts = box.values.toList();
//   // }
// }
