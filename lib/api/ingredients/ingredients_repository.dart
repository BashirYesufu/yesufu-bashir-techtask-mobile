import '../../models/ingredient.dart';

abstract class IngredientsRepository {
  Future<List<Ingredient>> fetchIngredients();
}