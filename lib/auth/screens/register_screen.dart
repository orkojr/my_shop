import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/app/loaders/app_loader.dart';
import 'package:myshop/app/utils/app_router.dart';
import 'package:myshop/app/widgets/app_button.dart';
import 'package:myshop/app/widgets/app_input.dart';
import 'package:myshop/auth/auth_service.dart';
import 'package:myshop/products/screens/product_list.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final LoaderController _loaderController = AppLoader.bounce();
  late AuthService _authService;
  String? error;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authService = AuthService();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppInput(
                  controller: _emailController,
                  label: "Email",
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                AppInput(
                  controller: _passwordController,
                  label: "password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                AppButton(
                  title: "register",
                  onPressed: () async {
                    try {
                      _loaderController.open(context);
                      await _authService.registerWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      _loaderController.close();
                      Navigator.of(context).pushAndRemoveUntil(
                          AppRouter.buildRoute(const ProductList()),
                          (route) => false);
                    } catch (e) {
                      print(e);
                      if (e is FirebaseAuthException) {
                        error = e.message;
                      } else {
                        error = e.toString();
                      }
                      setState(() {
                        _loaderController.close();
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
