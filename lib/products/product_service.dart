import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshop/products/models/product_model.dart';

class ProductService {
  User? user = FirebaseAuth.instance.currentUser!;

  CollectionReference<ProductModel> products = FirebaseFirestore.instance
      .collection('products')
      .withConverter<ProductModel>(
        fromFirestore: ((snapshot, _) =>
            ProductModel.fromJson(snapshot.data()!)),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Stream<List<ProductModel>> listProducts() {
    var stream = products.snapshots();
    return stream.map(
      (qShot) => qShot.docs
          .map(
            (doc) => doc.data(),
          )
          .toList(),
    );
  }

  addProduct({required productModel}) async {
    return await products.add(productModel);
  }
}
