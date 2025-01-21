import 'package:fire_todo/core/utiles/utiles.dart';
import 'package:fire_todo/presentation/screens/layout_screen/layout_screen.dart';
import 'package:fire_todo/presentation/screens/login_screen/login_screen.dart';
import 'package:fire_todo/presentation/screens/register_screen/register_view_model.dart';
import 'package:fire_todo/presentation/widgets/custom_filed.dart';
import 'package:fire_todo/presentation/widgets/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utiles/confirm_utils.dart';
import 'register_Navigator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  var formKay = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();
  RegisterViewModel viewModel = RegisterViewModel();

  @override
  void initState() {
    viewModel.registerNavigator = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
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
                          label: "Name",
                          controller: name,
                          validator: (value) =>
                              ConfirmUtils.validateName(value!),
                        ),
                        20.ph,
                        CustomFiled(
                          label: "Email",
                          controller: email,
                          validator: (value) =>
                              ConfirmUtils.validateEmail(value!),
                        ),
                        20.ph,
                        CustomFiled(
                          label: "Password",
                          controller: password,
                          obscureText: true,
                          validator: (value) =>
                              ConfirmUtils.validatePassword(value!),
                        ),
                        20.ph,
                        CustomFiled(
                          label: "Confirm Password",
                          controller: confirmPassword,
                          obscureText: true,
                          validator: (value) =>
                              ConfirmUtils.validateConfirmPassword(
                                  password.value.text, value!),
                        ),
                        100.ph,
                        InkWell(
                          onTap: () {
                            register();
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
                              "Register",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          },
                          child: Text(
                            "Have an account",
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

  void register() async {
    if (formKay.currentState!.validate()) {
      viewModel.register(context,email.text, password.text,name.text);
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
      title: "Register Successfully",
      posActionName: "OK",
        posAction: () {
       Navigator.of(context).pushReplacementNamed(LayoutScreen.routeName);

      },
    );
  }
}
