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

    test('Throws wrong status code', () async {
      when(() => client.get(ApiURLs.ingredients))
          .thenAnswer(
            (_) => Future.value(
              Response(requestOptions: RequestOptions(path: ApiURLs.ingredients),
                  data:BaseApiResponse('Network timed out, please check your network connection and try again', [], false, 404)
              )
        ),
      );

      // verify(client.get(ApiURLs.ingredients) as Function());
      // verifyNoMoreInteractions(networkManager);

      expect(
        await repository.fetchIngredients(),
          BaseApiResponse('Network timed out, please check your network connection and try again', [], false, 404)
      );
    });

    // test('Wrong response data type throws error', () async {
    //   when(() => client.get(Uri.parse(repository.ingredientsEndpoint)))
    //       .thenAnswer(
    //         (_) => Future.value(
    //       http.Response(json.encode('Wrong body type'), 200),
    //     ),
    //   );
    //
    //   expect(
    //     await repository.getIngredients(),
    //     BaseResponse<List<IngredientModel>>.withError(
    //         repository.invalidResponseError),
    //   );
    // });
    //
    // test('Succeeds when response has right status code and data type',
    //         () async {
    //       final response = [
    //         {
    //           'title': 'Ingredient1',
    //           'use-by': '2000-01-02',
    //         }
    //       ];
    //       when(() => client.get(Uri.parse(repository.ingredientsEndpoint)))
    //           .thenAnswer(
    //             (_) => Future.value(
    //           http.Response(json.encode(response), 200),
    //         ),
    //       );
    //
    //       expect(
    //         await repository.getIngredients(),
    //         BaseResponse<List<IngredientModel>>.withData(
    //           response.map(IngredientModel.fromJson).toList(),
    //         ),
    //       );
    //     });
  });

}