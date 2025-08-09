import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/core/services/api_service.dart';

abstract class HomeDataSource {
  Future<List<Product>> getAllProducts();
  Future<List<dynamic>> getAllCategories();
  Future<Product> getSingleProduct(int id);
}

class HomeDataSourceImlp implements HomeDataSource {
  ApiService apiService;

  HomeDataSourceImlp({required this.apiService});
  @override
  Future<List<dynamic>> getAllCategories() {
    return apiService.getAllCategories().then(
      (value) => value.fold((l) => [], (r) => r),
    );
  }

  @override
  Future<List<Product>> getAllProducts() {
    return apiService.getAllProducts().then(
      (value) => value.fold((l) => throw l, (r) => r),
    );
  }

  @override
  Future<Product> getSingleProduct(int id) {
    return apiService
        .getSingleProduct(id)
        .then((value) => value.fold((l) => throw l, (r) => r));
  }
}
