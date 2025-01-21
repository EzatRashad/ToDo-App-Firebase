import 'package:fire_todo/firebase_utils.dart';
import 'package:fire_todo/models/my_user.dart';
import 'package:fire_todo/presentation/screens/login_screen/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class LoginViewModel extends ChangeNotifier {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  late LoginNavigator loginNavigator;
  void login(context) async {
    loginNavigator.showLoading();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text);

      var user = await FirebaseUtils.readUser(credential.user?.uid ?? "");
      if (user == null) {
        return;
      }
      var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
      authProvider
          .updateUser(MyUser(id: user.id, email: user.email, name: user.name));
      loginNavigator.hideLoading();
      loginNavigator.showMessage("Login Successfully");
  
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        loginNavigator.hideLoading();
        loginNavigator.showMessage("No user found for that email or Wrong password.");
    
      }
    } catch (e) {
      loginNavigator.hideLoading();
      loginNavigator.showMessage("Error ${e.toString()}");
    
      print("Error ${e.toString()} ---------------------------");
    }
  }
}
