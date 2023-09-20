import 'package:tech_task/models/recipe.dart';

abstract class RecipesRepository {
  Future<List<Recipe>> fetchRecipes(List<String> ingredients);
}