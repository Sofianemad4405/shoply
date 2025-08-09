import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/core/services/api_service.dart';

abstract class SearchDataSource {
  Future<List<Product>> searchProducts(String query);
}

class SearchDataSourceImpl implements SearchDataSource {
  final ApiService apiService;

  SearchDataSourceImpl({required this.apiService});
  @override
  Future<List<Product>> searchProducts(String query) async {
    return await apiService
        .searchProducts(query)
        .then((value) => value.fold((l) => throw l, (r) => r));
  }
}
