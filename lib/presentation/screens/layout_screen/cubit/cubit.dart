import 'package:fire_todo/presentation/screens/layout_screen/cubit/states.dart';
import 'package:fire_todo/presentation/screens/settings/settings.dart';
 import 'package:fire_todo/presentation/screens/tasks_Screen/tasks_Screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutinitialState());

  // To use object in eny screen
  static LayoutCubit get(context) => BlocProvider.of(context);

  // To manage Navbar Screens
  int currentIndex = 0;
  List screens = [
     TasksScreen(),
    const SettingsScreen(),
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavState());
  }
}
