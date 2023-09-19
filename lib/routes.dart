import 'package:flutter/widgets.dart';
import 'package:tech_task/screens/ingredients_screen.dart';
import 'package:tech_task/screens/home_screen.dart';
import 'package:tech_task/screens/recipes_screen.dart';
import 'package:tech_task/screens/splash_screen.dart';

class Routes {
  static const splash = "/splash";
  static const recipes = "/recipes";
  static const ingredients = "/ingredients";
  static const home = "/home";


  static Map<String, WidgetBuilder> generateRoutes() => {
    splash: (context) => SplashScreen(),
    recipes: (context) => RecipesScreen(),
    ingredients: (context) => IngredientsScreen(),
    home: (context) => HomeScreen(),
  };
}
