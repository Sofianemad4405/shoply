import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/cart/data/repos/cart_repo_impl.dart';

class GetCartProducts {
  final CartRepoImpl repo;
  GetCartProducts(this.repo);
  Future<List<ProductEntity>> call() => repo.getCartProducts();
}
