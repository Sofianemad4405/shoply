import 'package:shopify/features/cart/data/repos/cart_repo_impl.dart';

class ClearCartProducts {
  final CartRepoImpl repo;

  ClearCartProducts(this.repo);
  Future<void> call() => repo.clearCart();
}
