import 'package:shopify/features/cart/domain/repo/cart_repo.dart';

class ClearCartProducts {
  final CartRepo repo;

  ClearCartProducts(this.repo);
  Future<void> call() => repo.clearCart();
}
