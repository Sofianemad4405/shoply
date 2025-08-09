import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/cart/domain/repo/cart_repo.dart';

class GetCartProducts {
  final CartRepo repo;
  GetCartProducts(this.repo);
  Future<List<ProductEntity>> call() => repo.getCartProducts();
}
