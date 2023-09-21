import 'package:flutter/material.dart';
import 'package:tech_task/screens/ingredients_screen.dart';
import 'package:tech_task/screens/home_screen.dart';
import 'package:tech_task/screens/recipes_screen.dart';
import 'package:tech_task/screens/settings_screen.dart';
import 'package:tech_task/screens/splash_screen.dart';

class RouteHandler {
  static const splash = "/splash";
  static const recipes = "/recipes";
  static const ingredients = "/ingredients";
  static const settings = "/settings";
  static const home = "/home";


  static Map<String, WidgetBuilder> generateRoutes() => {
    splash: (context) => SplashScreen(),
    home: (context) => HomeScreen(),
    settings: (context) => SettingsScreen(),
  };

  static Route<dynamic>? generatedRoute(RouteSettings route) {
    switch (route.name) {

      case recipes:
        final args = route.arguments as List<String>;
        return MaterialPageRoute(builder: (context) {
          return RecipesScreen(ingredients: args);
        });

      case ingredients:
        final args = route.arguments as DateTime;
        return MaterialPageRoute(builder: (context) {
          return IngredientsScreen(date: args);
        });

      default:
        return null;
    }
  }


}
