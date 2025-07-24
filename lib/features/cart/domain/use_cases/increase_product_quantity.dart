import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/cart/data/repos/cart_repo_impl.dart';

class IncreaseProductQuantity {
  final CartRepoImpl repo;
  IncreaseProductQuantity(this.repo);
  Future<void> call(ProductEntity product) =>
      repo.increaseQuantity(Product.fromEntity(product));
}
