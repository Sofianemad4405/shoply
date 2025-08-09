import 'package:shopify/features/category/data/datasource/category_data_source.dart';
import 'package:shopify/features/category/domain/category_repo.dart';
import 'package:shopify/core/models/product_model.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryDataSource categoryDataSource;

  CategoryRepoImpl({required this.categoryDataSource});
  @override
  Future<List<Product>> fetchCategoryProducts(String category) async {
    return await categoryDataSource.fetchCategoryProducts(category);
  }

  @override
  Future<List<Product>> getCategoryProductsSorted(
    String sortMethod,
    String order,
    String category,
  ) async {
    return await categoryDataSource.fetchCategoryProductsSorted(
      sortMethod,
      order,
      category,
    );
  }
}
