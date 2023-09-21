import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/api/api_urls.dart';
import 'package:tech_task/api/ingredients/ingredients_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_task/api/network_manager.dart';
import 'package:tech_task/config/app_config.dart';
import 'package:tech_task/models/base_api_response.dart';
import '../mocks.dart';


void main() {
  late Dio client;
  late IngredientsRepositoryImpl repository;
  late NetworkManager networkManager;

  setUp(() {
    BaseUrl.setEnvironment(Environment.TEST);
    client = MockDioClient();
    networkManager = MockNetworkManger();
    repository = IngredientsRepositoryImpl();
  });

  group('Fetch List Of Ingredients', () {

    test('Return null value for ingredients', () async {
      when(() => client.get(ApiURLs.ingredients))
          .thenAnswer(
            (_) => Future.value(
              Response(requestOptions: RequestOptions(path: ApiURLs.ingredients),
                  data: null
              )
        ),
      );

      expect(
        await networkManager.makeRequest(RequestType.GET, ApiURLs.ingredients),
        null
      );
    });


  });

}