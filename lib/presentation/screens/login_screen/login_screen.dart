import 'package:fire_todo/core/utiles/utiles.dart';
import 'package:fire_todo/presentation/screens/login_screen/login_navigator.dart';
import 'package:fire_todo/presentation/screens/login_screen/login_view_model.dart';
import 'package:fire_todo/presentation/screens/register_screen/register_screen.dart';
import 'package:fire_todo/presentation/widgets/dialog_utils.dart';
import 'package:fire_todo/providers/auth_provider.dart';
import 'package:firebase_auth_platform_interface/src/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utiles/confirm_utils.dart';
import '../../widgets/custom_filed.dart';
import '../layout_screen/layout_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  var formKay = GlobalKey<FormState>();


  LoginViewModel loginViewModel = LoginViewModel();

  @override
  void initState() {
    loginViewModel.loginNavigator = this;
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => loginViewModel,
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKay,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomFiled(
                          label: "Email",
                          controller: loginViewModel.emailController,
                          validator: (value) =>
                              ConfirmUtils.validateEmail(value!),
                        ),
                        20.ph,
                        CustomFiled(
                          label: "Password",
                          obscureText: true,
                          controller: loginViewModel.passwordController,
                          validator: (value) =>
                              ConfirmUtils.validatePassword(value!),
                        ),
                        100.ph,
                        InkWell(
                          onTap: () {
                            login();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "Login",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
                          child: Text(
                            "Dont have an account? Regiser",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKay.currentState!.validate()) {
      loginViewModel.login(context);
    }
  }

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading() {
    DialogUtils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(
      context,
      message,
      title: "Login Successfully",
      posActionName: "OK",
      posAction: () {
       Navigator.of(context).pushReplacementNamed(LayoutScreen.routeName);

      },
    );
  }
}


