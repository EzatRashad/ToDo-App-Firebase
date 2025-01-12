import 'package:fire_todo/core/utiles/utiles.dart';
import 'package:fire_todo/firebase_utils.dart';
import 'package:fire_todo/models/my_user.dart';
import 'package:fire_todo/presentation/screens/login_screen/login_screen.dart';
import 'package:fire_todo/presentation/widgets/custom_filed.dart';
import 'package:fire_todo/presentation/widgets/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utiles/confirm_utils.dart';
import '../../../providers/auth_provider.dart';
import '../layout_screen/layout_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKay = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

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
                        label: "Name",
                        controller: name,
                        validator: (value) => ConfirmUtils.validateName(value!),
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
    );
  }

  void register() async {
    if (formKay.currentState!.validate()) {
      DialogUtils.showLoading(context);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.value.text,
          password: password.value.text,
        );

        MyUser user = MyUser(
          id: credential.user?.uid,
          name: name.value.text,
          email: email.value.text,
        );

        await FirebaseUtils.addUser(user);

        var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
        authProvider.updateUser(user);
        DialogUtils.hide(context);
        DialogUtils.showMessage(
          context,
          "Register Successfully",
          posActionName: "OK",
          posAction: () {
            Navigator.of(context).pushReplacementNamed(LayoutScreen.routeName);
          },
        );

        print("Done---------------------");
        print(credential.user?.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hide(context);
          DialogUtils.showMessage(context, "The password provided is too weak.",
              posActionName: "OK");
          print('The password provided is too weak.');
          print("...............................................");
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hide(context);
          DialogUtils.showMessage(
              context, "The account already exists for that email.",
              posActionName: "OK");
          print('The account already exists for that email.');
          print("...............................................");
        }
      } catch (e) {
        DialogUtils.hide(context);
        DialogUtils.showMessage(context, "Error ${e.toString()}",
            posActionName: "OK");
        print("Error ${e.toString()} ---------------------------");
      }
      //Navigator.of(context).pushNamed(LayoutScreen.routeName);
    }
  }
}
