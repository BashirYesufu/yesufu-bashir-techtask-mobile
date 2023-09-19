import 'package:tech_task/api/recipes/recipes_api_service.dart';
import 'package:tech_task/api/recipes/recipes_repository.dart';
import 'package:tech_task/models/recipe.dart';

class RecipesRepositoryImpl implements RecipesRepository{

  final _service = RecipesApiService();

  @override
  Future<List<Recipe>> fetchRecipes() {
    return _service.fetchRecipes();
  }

}