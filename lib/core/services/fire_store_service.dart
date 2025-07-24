import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopify/core/services/database_service.dart';
import 'package:shopify/core/models/product_model.dart';

class FireStoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      log("Adding Data ... ");
      await firestore.collection(path).doc(documentId).set(data);
      log("Data Added");
    } else {
      log("Adding Data ... ");
      await firestore.collection(path).add(data);
      log("Data Added");
    }
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  }) async {
    log("Checking If Data Exists ... ");
    var data = await firestore.collection(path).doc(documentId).get();
    log("Data Exists");
    return data.exists;
  }

  @override
  Future<void> deleteData({
    required String path,
    required String documentId,
  }) async {
    log("Deleting Data ... ");
    try {
      await firestore.collection(path).doc(documentId).delete();
    } on Exception catch (e) {
      log("Error while deleting data $e");
      throw (e.toString());
    }
    log("Data Deleted");
  }

  @override
  Future<List<Product>> getData({
    required String path,
    String? documentId,
  }) async {
    var snapshot = await firestore.collection(path).get();
    return snapshot.docs.map((e) => Product.fromJson(e.data())).toList();
  }

  Future<void> clearData({required String path}) async {
    log("Clearing all data from $path ...");
    final collection = firestore.collection(path);
    final docs = await collection.get();

    for (var doc in docs.docs) {
      await doc.reference.delete();
    }

    log("All data cleared from $path");
  }

  Future<void> updateData({
    required String path,
    required String documentId,
    required String field,
    required dynamic value,
  }) async {
    log("Updating Data ... ");
    try {
      await firestore.collection(path).doc(documentId).update({field: value});
    } on Exception catch (e) {
      log("Error while updating data $e");
      throw (e.toString());
    }
    log("Data Updated");
  }
}
