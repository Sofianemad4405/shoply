import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/cart/domain/repo/cart_repo.dart';

class DecreaseProductQuantity {
  final CartRepo repo;
  DecreaseProductQuantity(this.repo);
  Future<void> call(ProductEntity product) =>
      repo.decreaseQuantity(Product.fromEntity(product));
}
