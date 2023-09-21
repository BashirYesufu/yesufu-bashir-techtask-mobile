import 'dart:async';
import 'package:tech_task/api/api_urls.dart';
import 'package:tech_task/models/ingredient.dart';
import '../network_manager.dart';

class IngredientsApiService {

  NetworkManager _networkManager = NetworkManager();

  Future<List<Ingredient>> fetchIngredients() async {
    var completer = Completer<List<Ingredient>>();
    try {
      final response = await _networkManager.makeRequest(
        RequestType.GET,
        ApiURLs.ingredients,
      );
      if (response?.success == true) {
        var result = List<Ingredient>.from(response?.data.map((x) => Ingredient.fromJson(x)));
        completer.complete(result);
      }
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }


}