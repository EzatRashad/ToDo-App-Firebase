import 'package:fire_todo/core/themes/colors.dart';
import 'package:fire_todo/presentation/screens/layout_screen/cubit/cubit.dart';
import 'package:fire_todo/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key, required this.cubit});
  final LayoutCubit cubit;
  @override
  Widget build(BuildContext context) {
        var provider = Provider.of<AppConfigProvider>(context);

    return BottomAppBar(
      padding: const EdgeInsets.all(0),
      
      
      color: provider.appTheme == ThemeMode.light
                        ? AppColors.white
                        : AppColors.black,
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        currentIndex: cubit.currentIndex,
        selectedFontSize: 16,
        onTap: (index) {
          cubit.changeIndex(index);
        },
        
        items:  [
          BottomNavigationBarItem(
            
            icon: const Icon(
              Icons.list,
             ),
            label: AppLocalizations.of(context)!.tasksList,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
            
            ),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
    );
  }
}
