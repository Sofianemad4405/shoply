import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/cart/data/data_sources/cart_data_source.dart';
import 'package:shopify/features/cart/domain/repo/cart_repo.dart';
import 'package:shopify/core/utils/fire_base_auth_service.dart';

class CartRepoImpl implements CartRepo {
  final CartDataSourceImpl cartDataSource;
  final FireBaseAuthService fireBaseAuthService;
  CartRepoImpl({
    required this.cartDataSource,
    required this.fireBaseAuthService,
  });
  @override
  Future<void> addToCart(ProductEntity product) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    await cartDataSource.addToCart(Product.fromEntity(product), userId);
  }

  @override
  Future<void> removeFromCart(ProductEntity product) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    await cartDataSource.removeFromCart(Product.fromEntity(product), userId);
  }

  @override
  Future<void> clearCart() async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    await cartDataSource.clearCart(userId);
  }

  @override
  Future<void> decreaseQuantity(ProductEntity product) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    await cartDataSource.decreaseQuantity(Product.fromEntity(product), userId);
  }

  @override
  Future<List<ProductEntity>> getCartProducts() async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    final products = await cartDataSource.getCartProducts(userId);
    return products.map((product) => product.toEntity()).toList();
  }

  @override
  Future<void> increaseQuantity(ProductEntity product) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    await cartDataSource.increaseQuantity(Product.fromEntity(product), userId);
  }

  @override
  Future<bool> checkIfInCart(String productId) async {
    final userId = await fireBaseAuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    return cartDataSource.checkIfInCart(productId, userId);
  }
}
