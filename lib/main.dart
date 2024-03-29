import 'package:amal/service/constant/colors.dart';
import 'package:amal/service/constant/finals.dart';
import 'package:amal/service/constant/strings.dart';
import 'package:amal/service/preferences/theme_pref.dart';
import 'package:amal/service/theme/cubit/theme_cubit.dart';
import 'package:amal/service/theme/cubit/theme_state.dart';
import 'package:amal/service/theme/theme.dart';
import 'package:amal/view/src/intro/splash.dart';
import 'package:amal/view/widgets/extensions.dart';
import 'package:amal/view/widgets/inherited_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await themeCubit.loadTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MyInheritedContext(
      context: context,
      child: MultiBlocProvider(
          providers: [BlocProvider(create: (context) => themeCubit)],
          child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppString.appName,
              themeMode: state.themeMode,
              theme: AppTheme.ligthTheme,
              darkTheme: AppTheme.darkTheme,
              navigatorKey: AppFinals.globalStateKey,
              home: const SplashScreen(),
            );
          })),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          DateTime.now().dateWithMonth(),
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: AppColors.primaryBlue),
        ),
      ),
    );
  }
}
