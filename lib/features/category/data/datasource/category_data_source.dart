import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/core/services/api_service.dart';

class CategoryDataSource {
  final ApiService apiService;

  CategoryDataSource({required this.apiService});

  Future<List<Product>> fetchCategoryProducts(String categoryName) async {
    final response = await apiService.getCategoryProducts(categoryName);
    return response.fold((l) => [], (r) => r);
  }

  Future<List<Product>> fetchCategoryProductsSorted(
    String sortMethod,
    String order,
    String category,
  ) async {
    final response = await apiService.getCategoryProductsSorted(
      sortMethod,
      order,
      category,
    );
    return response.fold((l) => [], (r) => r);
  }
}
