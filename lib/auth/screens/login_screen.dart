import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myshop/app/loaders/app_loader.dart';
import 'package:myshop/app/utils/app_colors.dart';
import 'package:myshop/app/utils/validators.dart';
import 'package:myshop/app/widgets/app_button.dart';
import 'package:myshop/app/widgets/app_input.dart';
import 'package:myshop/auth/auth_service.dart';
import 'package:myshop/auth/screens/register_screen.dart';
import 'package:myshop/products/screens/home.dart';
import 'package:myshop/products/screens/product_list.dart';

import '../../app/utils/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthService _authService;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String? error;
  final LoaderController _loaderController = AppLoader.bounce();

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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        elevation: 0,
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
                  placeholder: "Entrez votre addresse Email",
                ),
                const SizedBox(
                  height: 10,
                ),
                AppInput(
                  controller: _passwordController,
                  label: "Password",
                  obscureText: true,
                  placeholder: "Votre mot de passe",
                ),
                const SizedBox(height: 20),
                AppButton(
                  title: "Login",
                  onPressed: () async {
                    setState(() {
                      error = null;
                    });
                    try {
                      _loaderController.open(context);
                      await _authService.loginWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      _loaderController.close();
                      Navigator.of(context).pushAndRemoveUntil(
                          AppRouter.buildRoute(const Home()), (route) => false);
                    } catch (e) {
                      print(e);
                      if (e is FirebaseAuthException) {
                        error = e.toString();
                      }
                      setState(() {
                        _loaderController.close();
                      });
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RichText(
                    text: TextSpan(
                        text: "Vous n'avez pas de compte ? ",
                        style:
                            const TextStyle(color: AppColors.primaryGrayText),
                        children: [
                          TextSpan(
                            text: "Creer",
                            style: const TextStyle(color: AppColors.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(AppRouter.buildRoute(
                                    const RegisterScreen()));
                              },
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
