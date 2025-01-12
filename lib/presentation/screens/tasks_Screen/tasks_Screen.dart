import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:fire_todo/core/themes/colors.dart';
import 'package:fire_todo/core/utiles/utiles.dart';
import 'package:fire_todo/presentation/screens/tasks_Screen/task_widget.dart';
import 'package:fire_todo/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/getData_provider.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var getDataProvider = Provider.of<GetDataProvider>(context);
    var authProvider = Provider.of<MyAuthProvider>(context, listen: false);

    if (getDataProvider.tasks.isEmpty) {
      getDataProvider.getTasks(authProvider.currentUser?.id ?? "");
    }
    return Scaffold(
      body: Column(
        children: [
          Align(
            child: CalendarTimeline(
              initialDate: getDataProvider.selectedDate,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateSelected: (date) {
                getDataProvider.changeSelectDate(
                    date, authProvider.currentUser?.id ?? "");
              },
              leftMargin: 20,
              monthColor: provider.appTheme != ThemeMode.light
                  ? AppColors.white
                  : AppColors.black,
              dayColor: provider.appTheme != ThemeMode.light
                  ? AppColors.white
                  : AppColors.black,
              activeDayColor: AppColors.white,
              activeBackgroundDayColor: AppColors.primary,
              dotColor: AppColors.white,
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
            ),
          ),
          20.ph,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskWidget(
                      task: getDataProvider.tasks[index],
                    );
                  },
                  separatorBuilder: (context, index) => 10.ph,
                  itemCount: getDataProvider.tasks.length),
            ),
          )
        ],
      ),
    );
  }
}
