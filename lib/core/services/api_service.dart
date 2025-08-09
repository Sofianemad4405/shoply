import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopify/core/errors/failure.dart';
import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/core/utils/constants.dart';

abstract class ApiService {
  Future<Either<Failure, List<dynamic>>> getAllCategories();
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> getSingleProduct(int id);
  Future<Either<Failure, List<Product>>> sortProductsByPrice(
    String sortBy,
    String order,
  );
  Future<Either<Failure, List<Product>>> searchProducts(String query);
  Future<Either<Failure, List<Product>>> getCategoryProducts(String category);
  Future<Either<Failure, List<Product>>> getCategoryProductsSorted(
    String sortBy,
    String order,
    String category,
  );
  Future<Either<Failure, List<Product>>> getProductsSorted(
    String sortBy,
    String order,
  );
}
//'https://dummyjson.com/products?sortBy=title&order=asc'
//https://dummyjson.com/products/category/beauty?sortBy=title&order=asc

class ApiServiceImpl implements ApiService {
  final Dio dio;

  ApiServiceImpl({required this.dio});
  @override
  Future<Either<Failure, List<dynamic>>> getAllCategories() async {
    // 'https://dummyjson.com/products/category-list'
    try {
      final Response response = await dio.get(
        "${Constants.baseUrl}/products/category-list",
      );
      final data = response.data;
      return Right(data as List<dynamic>);
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final Response response = await dio.get("${Constants.baseUrl}/products");
      if (response.statusCode != 200) {
        return Left(
          Failure("Server returned status code ${response.statusCode}"),
        );
      }
      final data = response.data;
      if (data is Map<String, dynamic> && data['products'] is List) {
        final productsJson = data['products'] as List;
        return Right(
          productsJson.map((json) => Product.fromJson(json)).toList(),
        );
      } else {
        return Left(Failure("Unexpected response structure"));
      }
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getSingleProduct(int id) async {
    try {
      final Response response = await dio.get(
        "${Constants.baseUrl}/products/$id",
      );
      if (response.statusCode != 200) {
        return Left(Failure("Server error: ${response.statusCode}"));
      }

      final data = response.data;
      if (data is Map<String, dynamic>) {
        return Right(Product.fromJson(data));
      } else {
        return Left(Failure("Unexpected response structure"));
      }
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> sortProductsByPrice(
    String sortBy,
    String order,
  ) async {
    try {
      final Response response = await dio.get(
        "${Constants.baseUrl}/products?sortBy=$sortBy&order=$order",
      );
      if (response.statusCode != 200) {
        return Left(Failure("Server error: ${response.statusCode}"));
      }

      final data = response.data;
      if (data is Map<String, dynamic> && data['products'] is List) {
        final productsJson = data['products'] as List;
        return Right(
          productsJson.map((json) => Product.fromJson(json)).toList(),
        );
      } else {
        return Left(Failure("Unexpected response structure"));
      }
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    // 'https://dummyjson.com/products/search?q=phone'
    try {
      final Response response = await dio.get(
        "${Constants.baseUrl}/products/search?q=$query",
      );
      if (response.statusCode != 200) {
        return Left(Failure("Server error: ${response.statusCode}"));
      }

      final data = response.data;
      if (data is Map<String, dynamic> && data['products'] is List) {
        final productsJson = data['products'] as List;
        return Right(
          productsJson.map((json) => Product.fromJson(json)).toList(),
        );
      } else {
        return Left(Failure("Unexpected response structure"));
      }
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getCategoryProducts(
    String category,
  ) async {
    try {
      final Response response = await dio.get(
        "${Constants.baseUrl}/products/category/$category",
      );
      if (response.statusCode != 200) {
        return Left(Failure("Server error: ${response.statusCode}"));
      }

      final data = response.data;
      if (data is Map<String, dynamic> && data['products'] is List) {
        final productsJson = data['products'] as List;
        return Right(
          productsJson.map((json) => Product.fromJson(json)).toList(),
        );
      } else {
        return Left(Failure("Unexpected response structure"));
      }
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getCategoryProductsSorted(
    String sortBy,
    String order,
    String category,
  ) async {
    try {
      final Response response = await dio.get(
        "${Constants.baseUrl}/products/category/$category?sortBy=$sortBy&order=$order",
      );
      if (response.statusCode != 200) {
        return Left(Failure("Server error: ${response.statusCode}"));
      }

      final data = response.data;
      if (data is Map<String, dynamic> && data['products'] is List) {
        final productsJson = data['products'] as List;
        return Right(
          productsJson.map((json) => Product.fromJson(json)).toList(),
        );
      } else {
        return Left(Failure("Unexpected response structure"));
      }
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsSorted(
    String sortBy,
    String order,
  ) async {
    try {
      final Response response = await dio.get(
        "${Constants.baseUrl}/products?sortBy=$sortBy&order=$order",
      );
      if (response.statusCode != 200) {
        return Left(Failure("Server error: ${response.statusCode}"));
      }

      final data = response.data;
      if (data is Map<String, dynamic> && data['products'] is List) {
        final productsJson = data['products'] as List;
        return Right(
          productsJson.map((json) => Product.fromJson(json)).toList(),
        );
      } else {
        return Left(Failure("Unexpected response structure"));
      }
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }
}
