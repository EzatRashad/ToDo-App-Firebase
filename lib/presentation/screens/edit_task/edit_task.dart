import 'dart:ffi';

import 'package:fire_todo/core/themes/colors.dart';
import 'package:fire_todo/core/utiles/utiles.dart';
import 'package:fire_todo/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fire_todo/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utils.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/getData_provider.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  static const String routeName = "task_details";

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var formKay = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var provider2 = Provider.of<GetDataProvider>(context);
    var authProvider=Provider.of<MyAuthProvider>(context,listen: false);


    var task = ModalRoute.of(context)?.settings.arguments as TaskModel;

    title.text = task.title ?? "";
    description.text = task.description ?? "";
    selectedDate = task.dateTime!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ToDo List",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          decoration: BoxDecoration(
            color: provider.appTheme == ThemeMode.light
                ? AppColors.white
                : AppColors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: ListView(
            children: [
              10.ph,
              Text(
                AppLocalizations.of(context)!.editTask,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              Form(
                key: formKay,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    40.ph,
                    TextFormField(
                      controller: title,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? "Please enter task title"
                            : null;
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.title,
                        hintStyle: Theme.of(context).textTheme.titleSmall,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.gray,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                    25.ph,
                    Container(
                      constraints:
                          const BoxConstraints(maxHeight: 120, minHeight: 30),
                      child: TextFormField(
                        controller: description,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        maxLines: null,
                        validator: (value) {
                          return (value == null || value.isEmpty)
                              ? "Please enter task description"
                              : null;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.description,
                          hintStyle: Theme.of(context).textTheme.titleSmall,
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.gray,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primary,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                      ),
                    ),
                    25.ph,
                    InkWell(
                      onTap: () {
                        showDatePickerFun();

                      },
                      child: Row(
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.selectDate}: ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy - hh:mm a')
                                .format(selectedDate),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: AppColors.gray),
                          ),
                        ],
                      ),
                    ),
                    30.ph,
                  ],
                ),
              ),
              70.ph,
              ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                  ),
                  onPressed: () {
                    if (formKay.currentState!.validate() == true) {
                      TaskModel editedTask = TaskModel(
                          title: title.value.text,
                          id: task.id,
                          description: description.value.text,
                          dateTime: selectedDate);
                      FirebaseUtils.editTask(editedTask,authProvider.currentUser?.id??"").timeout(
                        Duration(milliseconds: 500),
                        onTimeout: () {
                          print("updateeeed");
                          provider2.getTasks(authProvider.currentUser?.id??"");
                        },
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: Theme.of(context).textTheme.titleLarge,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void showDatePickerFun() async {
    var selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    setState(() {
      selectedDate = selected ?? DateTime.now();
      print(selectedDate.toString());
    });
  }
}
