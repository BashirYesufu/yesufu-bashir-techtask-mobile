import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/api/api_urls.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_task/api/network_manager.dart';
import 'package:tech_task/config/app_config.dart';
import '../mocks.dart';


void main() {
  late Dio client;
  late NetworkManager networkManager;

  setUp(() {
    AppConfig.setEnvironment(Environment.TEST);
    client = MockDioClient();
    networkManager = MockNetworkManger();
  });

  group('Fetch List Of Recipes', () {

    test('Return null value for recipes', () async {
      when(() => client.get(ApiURLs.recipes(['Ham'])))
          .thenAnswer(
            (_) => Future.value(
            Response(requestOptions: RequestOptions(path: ApiURLs.recipes(['Ham'])),
                data: null
            )
        ),
      );

      expect(
          await networkManager.makeRequest(RequestType.GET, ApiURLs.recipes(['Ham'])),
          null
      );
    });


  });

}