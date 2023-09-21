import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:tech_task/route_handler.dart';
import 'package:tech_task/utilities/providers/app_providers.dart';
import 'package:tech_task/utilities/shared_pref.dart';
import 'package:tech_task/utilities/theme_manager.dart';

import 'config/app_config.dart';

void main() {
  AppConfig.setEnvironment(Environment.SANDBOX);
  runApp(
    RequestsInspector(
      enabled: true,
      showInspectorOn: ShowInspectorOn.LongPress,
      child: ProviderScope(
        child: MyApp(test: false),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  const MyApp({required this.test, Key? key}) : super(key: key);
  final bool test;

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  String currentTheme = AppTheme.rawValue(AppTheme.SYSTEM);

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          final themePro = ref.watch(AppProviders.themeProvider);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fridge',
            theme: themePro.theme == AppTheme.LIGHT || themePro.theme == AppTheme.SYSTEM
                ? ThemeManager.sharedInstance.lightTheme
                : ThemeManager.sharedInstance.darkTheme,
            darkTheme: themePro.theme == AppTheme.DARK || themePro.theme == AppTheme.SYSTEM
                ? ThemeManager.sharedInstance.darkTheme
                : null,
            initialRoute: widget.test ? RouteHandler.home : RouteHandler.splash,
            routes: RouteHandler.generateRoutes(),
            onGenerateRoute: RouteHandler.generatedRoute,
          );
        }
    );
  }

  void getCurrentTheme()async{
    String theme = await SharedPref.getUserTheme();
    setState(() {
      currentTheme = theme;
    });
  }

}
