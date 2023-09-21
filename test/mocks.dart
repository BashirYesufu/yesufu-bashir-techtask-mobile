import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_task/api/ingredients/ingredients_repository.dart';
import 'package:tech_task/api/network_manager.dart';
import 'package:tech_task/api/recipes/recipes_repository.dart';

class MockIngredientsRepository extends Mock implements IngredientsRepository {}
class MockRecipesRepository extends Mock implements RecipesRepository {}

class MockNetworkManger extends Mock implements NetworkManager {}
class MockDioClient extends Mock implements Dio {}
