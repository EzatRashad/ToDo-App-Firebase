import 'package:fire_todo/core/themes/colors.dart';
import 'package:fire_todo/core/utiles/utiles.dart';
import 'package:fire_todo/presentation/screens/settings/lang_bottom_sheet.dart';
import 'package:fire_todo/presentation/screens/settings/theme_bottom_sheet.dart';
import 'package:fire_todo/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.ph,
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: provider.appTheme == ThemeMode.light
                      ? AppColors.black
                      : AppColors.white,
                ),
          ),
          10.ph,
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: provider.appTheme == ThemeMode.light
                      ? AppColors.white
                      : AppColors.black,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appTheme == ThemeMode.light
                        ? AppLocalizations.of(context)!.light
                        : AppLocalizations.of(context)!.dark,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.w400),
                  ),
                  const Icon(Icons.arrow_drop_down_circle_rounded,
                      color: AppColors.primary)
                ],
              ),
            ),
          ),
          25.ph,
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: provider.appTheme == ThemeMode.light
                      ? AppColors.black
                      : AppColors.white,
                ),
          ),
          10.ph,
          InkWell(
            onTap: () {
              showLangBottomSheet();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: provider.appTheme == ThemeMode.light
                      ? AppColors.white
                      : AppColors.black,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.applang == "en"
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.w400),
                  ),
                  const Icon(Icons.arrow_drop_down_circle_rounded,
                      color: AppColors.primary)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ThemeBottomSheet(),
    );
  }

  void showLangBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LangBottomSheet(),
    );
  }
}
