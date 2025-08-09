import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/category/domain/category_repo.dart';

class FetchCategoryProductsSorted {
  final CategoryRepo categoryRepo;

  FetchCategoryProductsSorted({required this.categoryRepo});
  Future<List<ProductEntity>> call(
    String sortMethod,
    String order,
    String category,
  ) async {
    return await categoryRepo.getCategoryProductsSorted(
      sortMethod,
      order,
      category,
    );
  }
}
