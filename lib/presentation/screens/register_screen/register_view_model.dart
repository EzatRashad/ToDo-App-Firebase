import 'package:fire_todo/presentation/screens/register_screen/register_Navigator.dart';
import 'package:fire_todo/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utils.dart';
import '../../../models/my_user.dart'; 

class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator registerNavigator;

  /// hold data - handle logic
  void register(context,String email, String password,String name) async {
    registerNavigator.showLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      MyUser user = MyUser(
        id: credential.user?.uid,
        name: name,
        email: email,
      );

      await FirebaseUtils.addUser(user);

      var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
      authProvider.updateUser(user);
      registerNavigator.hideLoading();
      registerNavigator.showMessage("Register Successfully");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        registerNavigator.hideLoading();
        registerNavigator.showMessage("The password provided is too weak.");

      } else if (e.code == 'email-already-in-use') {
        registerNavigator.hideLoading( );
                registerNavigator.showMessage("The account already exists for that email.");
      }
    } catch (e) {
      registerNavigator.hideLoading( );
              registerNavigator.showMessage("Error ${e.toString()}");

      print("Error ${e.toString()} ---------------------------");
    }
  }
}
