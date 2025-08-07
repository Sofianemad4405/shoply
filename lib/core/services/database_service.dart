import 'package:shopify/core/models/product_model.dart';
import 'package:shopify/features/auth/domain/models/user_entity.dart';
import 'package:shopify/features/checkout/data/models/delivery_address_model.dart';

abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<void> deleteData({required String path, required String documentId});

  Future<List<Product>> getData({required String path, String? documentId});

  Future<Delivery> getDeliveryAddresses({
    required String path,
    required String documentId,
  });

  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  });

  Future<void> updateUserData({
    required String path,
    required String documentId,
    required Map<String, dynamic> data,
  });
  Future<UserEntity> getUserData({required String userId});
}
