import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopify/core/services/database_service.dart';

class FireStoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).set(data);
    }
    await firestore.collection(path).add(data);
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  }) async {
    var data = await firestore.collection(path).doc(documentId).get();
    return data.exists;
  }

  @override
  Future<void> deleteData({required String path, String? documentId}) {
    return firestore.collection(path).doc(documentId).delete();
  }

  //not finished
  @override
  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  }) async {
    if (documentId != null) {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.data();
    } else {
      return firestore
          .collection(path)
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
    }
  }
}
