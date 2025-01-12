import 'package:fire_todo/core/themes/colors.dart';
import 'package:fire_todo/presentation/screens/layout_screen/bottomNavigationBar_widget.dart';
import 'package:fire_todo/presentation/screens/layout_screen/cubit/cubit.dart';
import 'package:fire_todo/presentation/screens/layout_screen/cubit/states.dart';
import 'package:fire_todo/presentation/screens/layout_screen/task_bottom_sheet.dart';
import 'package:fire_todo/presentation/screens/login_screen/login_screen.dart';
import 'package:fire_todo/providers/getData_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  static const String routeName = "layout_screen";

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<MyAuthProvider>(context);
    var getDataProvider = Provider.of<GetDataProvider>(context);
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "ToDo List",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    getDataProvider.tasks = [];
                    authProvider.currentUser=null;
                    Navigator.pushReplacementNamed(context,LoginScreen.routeName);
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: NavBarWidget(
              cubit: cubit,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              elevation: 0,
              shape: const StadiumBorder(
                side: BorderSide(width: 4, color: AppColors.white),
              ),
              onPressed: () {
                showAddTaskBottomSheet(context);
              },
              child: const Icon(
                Icons.add,
                size: 30,
                color: AppColors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

void showAddTaskBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    barrierColor: Colors.black38,
    isScrollControlled: true,
    // only work on showModalBottomSheet function
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const SizedBox(height: 450, child: TaskBottomSheet())),
  );
}
