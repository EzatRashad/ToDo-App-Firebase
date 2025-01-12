import 'package:fire_todo/models/my_user.dart';
import 'package:flutter/widgets.dart';

class MyAuthProvider extends ChangeNotifier {
   MyUser? currentUser;

  void updateUser(MyUser user) {
    currentUser = user;
    notifyListeners();
  }
}
