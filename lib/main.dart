import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:tech_task/routes.dart';
import 'package:tech_task/utilities/providers/app_providers.dart';
import 'package:tech_task/utilities/shared_pref.dart';
import 'package:tech_task/utilities/theme_manager.dart';

void main() => runApp(
      RequestsInspector(
        enabled: false,
        showInspectorOn: ShowInspectorOn.LongPress,
        child: ProviderScope(
          child: MyApp(),
        ),
      ),
    );

class MyApp extends StatefulWidget {

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
            title: 'Fridge',
            theme: themePro.theme == AppTheme.LIGHT || themePro.theme == AppTheme.SYSTEM
                ? ThemeManager.sharedInstance.lightTheme
                : ThemeManager.sharedInstance.darkTheme,
            darkTheme: themePro.theme == AppTheme.DARK || themePro.theme == AppTheme.SYSTEM
                ? ThemeManager.sharedInstance.darkTheme
                : null,
            initialRoute: Routes.splash,
            routes: Routes.generateRoutes(),
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
