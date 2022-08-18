import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/app/utils/app_router.dart';
import 'package:myshop/auth/auth_service.dart';
import 'package:myshop/auth/screens/login_screen.dart';
import 'package:myshop/products/product_service.dart';
import 'package:myshop/products/screens/add_product_screen.dart';
import 'package:path/path.dart';

import '../models/product_model.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  User? user = FirebaseAuth.instance.currentUser;

  late Stream<List<ProductModel>> productStream;
  late ProductService _productService;

  @override
  void initState() {
    _productService = ProductService();
    productStream = _productService.listProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("product list"),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService().logOut();

                Navigator.push(
                    context, AppRouter.buildRoute(const LoginScreen()));
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<List<ProductModel>>(
            stream: productStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductModel>> snapshot) {
              log(snapshot.connectionState.toString());
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child:  Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Expanded(child: Center(child: Text('${snapshot.error}')));
              } else if (snapshot.hasData) {
                List<ProductModel> products = snapshot.data!;
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4,
                        mainAxisExtent: MediaQuery.of(context).size.width * .8),
                    itemBuilder: (context, index) {
                      var product = products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.width * .5,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: product.imgUrls.isNotEmpty
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    product.imgUrls.first),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    product.pname,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(
                                    product.prix.toStringAsFixed(0) + " FCFA",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              }
              return Container(
                child: const Text("None"),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (user != null) {
            Navigator.of(context)
                .push(AppRouter.buildRoute(const AddProductScreen()));
          } else {
            Navigator.of(context)
                .push(AppRouter.buildRoute(const LoginScreen()));
          }
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
