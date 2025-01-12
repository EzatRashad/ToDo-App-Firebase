import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_todo/models/my_user.dart';
import 'package:fire_todo/models/task_model.dart';

class FirebaseUtils {
  static CollectionReference<TaskModel> getTaksCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection("tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, options) => task.toJson(),
        );
  }

  static Future<void> addTask(TaskModel task, String uId) {
    DocumentReference<TaskModel> ref = getTaksCollection(uId).doc();
    task.id = ref.id;
    return ref.set(task);
  }

  static Future<void> deleteTask(TaskModel task, String uId) {
    return getTaksCollection(uId).doc(task.id).delete();
  }

  static Future<void> editTask(TaskModel task, String uId) {
    return getTaksCollection(uId).doc(task.id).update(task.toJson());
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<void> addUser(MyUser user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUser(String uId) async {
    var quarySnapShot = await getUserCollection().doc(uId).get();
    return quarySnapShot.data();
  }
}
