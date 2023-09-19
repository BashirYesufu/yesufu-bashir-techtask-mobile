import 'package:tech_task/api/ingredients/ingredients_api_service.dart';
import 'package:tech_task/api/ingredients/ingredients_repository.dart';
import 'package:tech_task/models/ingredient.dart';

class IngredientsRepositoryImpl implements IngredientsRepository{

  final _service = IngredientsApiService();

  @override
  Future<List<Ingredient>> fetchIngredients() {
    return _service.fetchIngredients();
  }

}