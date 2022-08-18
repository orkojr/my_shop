import 'package:flutter/material.dart';
import 'package:myshop/app/initialization.dart';
import 'package:myshop/app/utils/app_colors.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AppInitializationScreen(),
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: AppColors.createMaterialColor(AppColors.primary),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 83, 153, 214),
        ),
      ),
    );
  }
}
