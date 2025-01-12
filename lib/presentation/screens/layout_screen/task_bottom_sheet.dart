import 'package:fire_todo/core/themes/colors.dart';
import 'package:fire_todo/core/utiles/utiles.dart';
import 'package:fire_todo/firebase_utils.dart';
import 'package:fire_todo/models/task_model.dart';
import 'package:fire_todo/presentation/widgets/dialog_utils.dart';
import 'package:fire_todo/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/getData_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKay = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  late GetDataProvider getDataProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    getDataProvider = Provider.of<GetDataProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
      width: double.infinity,
      decoration: BoxDecoration(
          color: provider.appTheme == ThemeMode.light
              ? AppColors.white
              : AppColors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.addNewTask,
              style: Theme.of(context).textTheme.titleMedium),
          Form(
            key: formKay,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                30.ph,
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
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
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
                        DateFormat('dd/MM/yyyy - hh:mm a').format(selectedDate),
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
          const Spacer(),
          ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
              ),
              onPressed: () {
                addTask();
              },
              child: Text(
                AppLocalizations.of(context)!.addNewTask,
                style: Theme.of(context).textTheme.titleLarge,
              ))
        ],
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
    });
  }

  void addTask() {
    if (formKay.currentState!.validate() == true) {
      TaskModel task = TaskModel(
          title: title.value.text,
          description: description.value.text,
          dateTime: selectedDate);
      DialogUtils.showLoading(context);
      var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
      FirebaseUtils.addTask(task, authProvider.currentUser?.id ?? "")
          .then((onValue) {
        DialogUtils.hide(context);
        DialogUtils.showMessage(
          context,
          "Task Added ",
          posActionName: "OK",
          posAction: () {
            Navigator.pop(context);
          },
        );
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        print("aded --------------------");
        getDataProvider.getTasks(authProvider.currentUser?.id ?? "");

        Navigator.pop(context);
      });
    }
  }
}
