import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_todo/core/themes/theme.dart';
import 'package:fire_todo/presentation/screens/layout_screen/cubit/BlocObserver.dart';
import 'package:fire_todo/presentation/screens/layout_screen/layout_screen.dart';
import 'package:fire_todo/presentation/screens/login_screen/login_screen.dart';
import 'package:fire_todo/presentation/screens/register_screen/register_screen.dart';
import 'package:fire_todo/presentation/screens/splash_Screen/splash_screen.dart';
import 'package:fire_todo/presentation/screens/edit_task/edit_task.dart';
import 'package:fire_todo/providers/app_config_provider.dart';
import 'package:fire_todo/providers/auth_provider.dart';
import 'package:fire_todo/providers/getData_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 /* FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();*/
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppConfigProvider()),
        ChangeNotifierProvider(create: (context) => GetDataProvider()),
        ChangeNotifierProvider(create: (context) => MyAuthProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        LayoutScreen.routeName: (context) => const LayoutScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        RegisterScreen.routeName: (context) =>  RegisterScreen(),
        LoginScreen.routeName: (context) =>  LoginScreen(),
        EditTask.routeName: (context) => const EditTask(),
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appTheme,
      locale: Locale(provider.applang),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
