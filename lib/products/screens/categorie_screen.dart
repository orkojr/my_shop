import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/utils/app_router.dart';
import '../../auth/auth_service.dart';
import '../../auth/screens/login_screen.dart';

class CategorieScreen extends StatefulWidget {
  const CategorieScreen({Key? key}) : super(key: key);

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "Chaussures",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.local_fire_department,
                    size: 25,
                  ),
                ),
              ),
              Divider(
                height: .5,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "Vetements",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.accessibility_sharp,
                    size: 25,
                  ),
                ),
              ),
              Divider(
                height: .5,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "Immobilier",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.account_balance_sharp,
                    size: 25,
                  ),
                ),
              ),
              Divider(
                height: .5,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "Electroniques et Ordinateurs",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.laptop_windows_rounded,
                    size: 25,
                  ),
                ),
              ),
              Divider(
                height: .5,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "Telephones mobiles",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.apple_outlined,
                    size: 25,
                  ),
                ),
              ),
              Divider(
                height: .5,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "Voitures",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.airport_shuttle_rounded,
                    size: 25,
                  ),
                ),
              ),
              Divider(
                height: .5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
