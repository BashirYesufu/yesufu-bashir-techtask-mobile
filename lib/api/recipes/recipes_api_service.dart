import 'dart:async';
import 'package:tech_task/api/api_urls.dart';
import '../../models/recipe.dart';
import '../network_manager.dart';

class RecipesApiService {

  NetworkManager _networkManager = NetworkManager();

  Future<List<Recipe>> fetchRecipes(List<String> ingredients) async {
    var completer = Completer<List<Recipe>>();
    try {
      final response = await _networkManager.makeRequest(
        RequestType.GET,
        ApiURLs.recipes(ingredients),
      );
      if (response.success) {
        var result = List<Recipe>.from(response.data.map((x) => Recipe.fromJson(x)));
        completer.complete(result);
      }
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }


}