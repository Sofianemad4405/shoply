import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/core/services/api_service.dart';
import 'package:shopify/features/search/data/datasources/search_data_source.dart';
import 'package:shopify/features/search/domain/repos/search_repo.dart';

class SearchRepoImplementation implements SearchRepo {
  final SearchDataSource searchDataSource;

  SearchRepoImplementation({
    required this.searchDataSource,
    required ApiServiceImpl apiService,
  });
  @override
  Future<List<ProductEntity>> searchProduct(String productName) async {
    return await searchDataSource.searchProducts(productName);
  }
}
