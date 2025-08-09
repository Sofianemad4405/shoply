import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/cart/domain/repo/cart_repo.dart';

class IncreaseProductQuantity {
  final CartRepo repo;
  IncreaseProductQuantity(this.repo);
  Future<void> call(ProductEntity product) =>
      repo.increaseQuantity(Product.fromEntity(product));
}
