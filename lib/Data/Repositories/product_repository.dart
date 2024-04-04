import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  Future<void> addProduct({
    required String name,
    required String measurement,
    required String price,
  }) async {
    try {
      await productsCollection.doc(name).set({
        'name': name,
        'measurement': measurement,
        'price': double.parse(price),
      });
    } catch (error) {
      log("${error}");
      throw Exception('Failed to add product: $error');
    }
  }

  Future<void> deleteProduct({required String name}) async {
    try {
      await productsCollection.doc(name).delete();
    } catch (error) {
      log("${error}");
      throw Exception('Failed to add product: $error');
    }
  }
}
