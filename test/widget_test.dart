// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_task/config/app_config.dart';
import 'package:tech_task/main.dart';
import 'package:tech_task/models/ingredient.dart';
import 'package:tech_task/models/recipe.dart';
import 'package:tech_task/screens/home_screen.dart';
import 'package:tech_task/screens/ingredients_screen.dart';
import 'package:tech_task/utilities/widget_keys.dart';
import 'mocks.dart';

void main() {
  AppConfig.setEnvironment(Environment.TEST);
  final List<Ingredient> exampleIngredientSuccessResponse = [
    Ingredient(
      title: 'Ingredient',
      useBy: DateTime.now(),
    )
  ];
  final List<Recipe> exampleRecipeSuccessResponse = [
    Recipe(
      title: 'Recipe',
      ingredients: ['Ham', 'Bread'],
    )
  ];

  testWidgets('End-to-end test', (WidgetTester tester) async {
    final ingredientRepository = MockIngredientsRepository();
    final recipeRepository = MockRecipesRepository();
    when(() => ingredientRepository.fetchIngredients()).thenAnswer(
          (_) =>
          Future.value(exampleIngredientSuccessResponse),
    );

    when(() => recipeRepository.fetchRecipes(any())).thenAnswer(
          (_) =>
          Future.value(exampleRecipeSuccessResponse),
    );

    await tester.pumpWidget(ProviderScope(
      child: MyApp(test: true),
    ));

    // Splash loaded
    await tester.pumpAndSettle(Duration(milliseconds: 1500));
    expect(find.byType(HomeScreen), findsOneWidget);

    // tap 'Get Ingredients' button
    await tester.tap(
      find.descendant(
        of: find.byType(HomeScreen),
        matching: find.byKey(WidgetKeys.homeGetIngredientsBtn),
      ),
    );

    // expects to see IngredientsScreen and Ingredients List loaded
    await tester.pumpAndSettle(Duration(milliseconds: 5000));
    expect(find.byType(IngredientsScreen), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(IngredientsScreen),
        matching: find.byKey(WidgetKeys.dateIngredientsList),
      ),
      findsOneWidget,
    );

  });



}
