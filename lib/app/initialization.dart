import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myshop/app/utils/app_colors.dart';
import 'package:myshop/app/utils/app_router.dart';
import 'package:myshop/products/screens/home.dart';
import 'package:myshop/products/screens/product_list.dart';

class AppInitializationScreen extends StatefulWidget {
  const AppInitializationScreen({Key? key}) : super(key: key);

  @override
  State<AppInitializationScreen> createState() =>
      _AppInitializationScreenState();
}

class _AppInitializationScreenState extends State<AppInitializationScreen> {
  @override
  void initState() {
    checkSate();
    super.initState();
  }

  checkSate() {
    WidgetsBinding.instance!.addPostFrameCallback((Timestamp) {
      Navigator.of(context).pushAndRemoveUntil(
          AppRouter.buildRoute(const Home()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Myshop",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
