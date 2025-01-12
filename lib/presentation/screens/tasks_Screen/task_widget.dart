import 'package:fire_todo/core/themes/colors.dart';
import 'package:fire_todo/core/utiles/utiles.dart';
import 'package:fire_todo/firebase_utils.dart';
import 'package:fire_todo/models/task_model.dart';
import 'package:fire_todo/presentation/screens/edit_task/edit_task.dart';
import 'package:fire_todo/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/getData_provider.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({super.key, required this.task});

  TaskModel task;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var provider2 = Provider.of<GetDataProvider>(context);

    return Slidable(
      startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                var authProvider=Provider.of<MyAuthProvider>(context,listen: false);

                FirebaseUtils.deleteTask(task,authProvider.currentUser?.id??"").timeout(
                  Duration(milliseconds: 500),
                  onTimeout: () {
                    print("deleteeeeed");
                    provider2.getTasks(authProvider.currentUser?.id??"");
                  },
                );
              },
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              icon: Icons.delete,
            ),
          ]),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            EditTask.routeName,
            arguments: task,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: provider.appTheme == ThemeMode.light
                ? AppColors.white
                : AppColors.black,
          ),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 5,
                color:
                    task.isDone == true ? AppColors.green : AppColors.primary,
              ),
              10.pw,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: task.isDone == true
                            ? AppColors.green
                            : AppColors.primary),
                  ),
                  Text(
                    task.description ?? "",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: provider.appTheme != ThemeMode.light
                              ? AppColors.white
                              : AppColors.black,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              task.isDone == true
                  ? Text(
                      "Done!",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.green,
                          ),
                    )
                  : InkWell(
                      onTap: () {
                        TaskModel editedTask = TaskModel(
                          title: task.title,
                          isDone: true,
                          id: task.id,
                          description: task.description,
                          dateTime: task.dateTime,
                        );
                        var authProvider=Provider.of<MyAuthProvider>(context,listen: false);

                        FirebaseUtils.editTask(editedTask,authProvider.currentUser?.id??"").timeout(
                          Duration(milliseconds: 500),
                          onTimeout: () {
                            print("updateeeed");

                            provider2.getTasks(authProvider.currentUser?.id??"");
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.primary,
                        ),
                        child: const Icon(
                          Icons.done,
                          color: AppColors.white,
                          size: 35,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
