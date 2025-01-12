import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_utils.dart';
import '../models/task_model.dart';

class GetDataProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  void getTasks(String uId) async {
    QuerySnapshot<TaskModel> querySnapshot =
        await FirebaseUtils.getTaksCollection(uId).get();
    tasks = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    tasks = tasks.where((task) {
      if (task.dateTime?.day == selectedDate.day &&
          task.dateTime?.month == selectedDate.month &&
          task.dateTime?.year == selectedDate.year) {
        return true;
      } else {
        return false;
      }
    }).toList();
    tasks.sort((TaskModel t1, TaskModel t2) {
      return t1.dateTime!.compareTo(t2.dateTime!);
    });
    notifyListeners();
  }

  void changeSelectDate(DateTime newDate,String uId) {
    selectedDate = newDate;
    getTasks(uId);
  }
}
