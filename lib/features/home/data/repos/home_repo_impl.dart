import 'package:shopify/core/models/product_entity.dart';
import 'package:shopify/features/home/data/datasources/home_data_source.dart';
import 'package:shopify/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeDataSource dataSource;

  HomeRepoImpl(this.dataSource);

  @override
  Future<List<ProductEntity>> getAllProducts() {
    return dataSource.getAllProducts();
  }

  @override
  Future<ProductEntity> getSingleProduct(int id) {
    return dataSource.getSingleProduct(id);
  }

  @override
  Future<List<String>> getCategories() async {
    final categories = await dataSource.getAllCategories();
    return categories.map((c) => c.toString()).toList();
  }
}
