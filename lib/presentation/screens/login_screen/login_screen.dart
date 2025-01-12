import 'package:fire_todo/core/utiles/utiles.dart';
import 'package:fire_todo/firebase_utils.dart';
import 'package:fire_todo/presentation/screens/layout_screen/layout_screen.dart';
import 'package:fire_todo/presentation/screens/register_screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utiles/confirm_utils.dart';
import '../../../models/my_user.dart';
import '../../../providers/auth_provider.dart';
import '../../widgets/custom_filed.dart';
import '../../widgets/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKay = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        controller: email,
                        validator:(value) => ConfirmUtils.validateEmail(value!),
                      ),
                      20.ph,
                      CustomFiled(
                        label: "Password",
                        obscureText: true,
                        controller: password,
                        validator: (value) => ConfirmUtils.validatePassword(value!),
                      ),
                      100.ph,
                      InkWell(
                        onTap: () {
                          login();
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
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
    );
    ;
  }

  void login() async {
    if (formKay.currentState!.validate()) {
      DialogUtils.showLoading(context);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.value.text, password: password.value.text);

        var user = await FirebaseUtils.readUser(credential.user?.uid ?? "");
        if (user == null) {
          return;
        }
        var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
        authProvider.updateUser(
            MyUser(id: user.id, email: user.email, name: user.name));
        DialogUtils.hide(context);
        DialogUtils.showMessage(
          context,
          "Login Successfully",
          posActionName: "OK",
          posAction: () {
            Navigator.of(context).pushReplacementNamed(LayoutScreen.routeName);
          },
        );
        print(credential.user?.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hide(context);
          DialogUtils.showMessage(context, "No user found for that email.",
              posActionName: "OK");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.hide(context);
          DialogUtils.showMessage(
              context, 'Wrong password provided for that user.',
              posActionName: "OK");
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        DialogUtils.hide(context);
        DialogUtils.showMessage(context, "Error ${e.toString()}",
            posActionName: "OK");
        print("Error ${e.toString()} ---------------------------");
      }
    }
  }
}
