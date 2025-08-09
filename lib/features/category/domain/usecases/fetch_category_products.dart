import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/category/domain/category_repo.dart';

class FetchCategoryProducts {
  final CategoryRepo categoryRepo;

  FetchCategoryProducts({required this.categoryRepo});
  Future<List<ProductEntity>> call(String categoryName) async {
    return await categoryRepo.fetchCategoryProducts(categoryName);
  }
}
