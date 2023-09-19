import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:rxdart/rxdart.dart';
import '../config/app_config.dart';
import '../models/base_api_response.dart';

class NetworkManager{
  static BaseOptions options = BaseOptions(
      baseUrl:BaseUrl.BASE_URL,
      connectTimeout: Duration(milliseconds: 60000),
      receiveTimeout: Duration(milliseconds: 100000),
  );
  Dio client = Dio(options)..interceptors.add(RequestsInspectorInterceptor());

  Future<BaseApiResponse> networkRequestManager(RequestType vrxRequestType, String requestUrl, {dynamic body, queryParameters,
   BehaviorSubject<int>? progressStream, File? backFile}) async{

    late BaseApiResponse apiResponse;
    var baseUrl =  BaseUrl.BASE_URL;
    String url = '$baseUrl$requestUrl';

    try{
      switch(vrxRequestType){
        case RequestType.GET:
          var response = await client
              .get(url,queryParameters: queryParameters,);
          //  debugPrint("get: ${response.data.toString()}");
          apiResponse = BaseApiResponse.fromJson(response);
          break;
        case RequestType.POST:
          var response = await client
              .post(url,data: body,queryParameters: queryParameters, onSendProgress:(int count, int total){
            if(progressStream!=null){
              double percentage  = (count/total) * 100 ;
              progressStream.sink.add(percentage.toInt());
            }
          });
          if(response.statusCode==204){
            apiResponse = BaseApiResponse("Success",{"status": "Success"},true);
          }else{
            apiResponse = BaseApiResponse.fromJson(response);
          }
          break;
        case RequestType.MULTI_PART_POST:
        // client.interceptors.add(InterceptorsWrapper(
        //     onRequest: (Options options) async {
        //       options.headers["Content-Type"] = "multipart/form-data";
        //       return options;
        //     }
        // ));
          var response = await client
              .post(url,data: body,queryParameters: queryParameters,);
          debugPrint("post: ${response.data.toString()}");
          apiResponse = BaseApiResponse.fromJson(response);
          break;
        case RequestType.PUT:
          var response = await client
              .put(url,data: body,queryParameters: queryParameters);
          debugPrint("put: ${response.data.toString()}");
          apiResponse = BaseApiResponse.fromJson(response);
          break;
        case RequestType.PATCH:
          var response = await client
              .patch(url,data: body,queryParameters: queryParameters);
          debugPrint("put: ${response.data.toString()}");
          apiResponse = BaseApiResponse.fromJson(response);
          break;
        case RequestType.DELETE:
          var response = await client
              .delete(url,data: body,queryParameters: queryParameters);
          debugPrint("delete: ${response.data.toString()}");
          apiResponse = BaseApiResponse.fromJson(response);
          break;
        default:
          var response = await client
              .post(url,data: body,queryParameters: queryParameters);
          debugPrint("post: ${response.data.toString()}");
          apiResponse = BaseApiResponse.fromJson(response);
          break;
      }
      return apiResponse;

    }on TimeoutException catch(n) {
      debugPrint("Network Timeout Error response: $n");
      throw ("Network timed out, please check your network connection and try again");
    }  on DioException catch(e){
      debugPrint("Internal Error response: ${e.error}");

      if (DioExceptionType.receiveTimeout == e.type || DioExceptionType.connectionTimeout == e.type) {
        debugPrint("Network Timeout Error response: $e");
        throw ("Network timed out, please check your network connection and try again");
      } else if (DioExceptionType.unknown == e.type) {
        if (e.message?.contains('SocketException') == true) {
          debugPrint("No Network Error response: $e");
          throw ("No internet connection, please check your network connection and try again");
        }else if (e.message?.contains('XMLHttpRequest') ==  true) {
          debugPrint("No Network Error response: $e");
          throw ("No internet connection, please check your network connection and try again");
        }else{
          debugPrint("No Network Error response: $e");
          throw ("No internet connection, please check your network connection and try again");
        }
      }
      if(e.response==null){
        if(e.error.toString().contains("XMLHttpRequest")){
          throw ("Internet connection error, please check your network connection and try again");
        }
        throw ("Unable to process this request at this time");
      }

      print(e.response?.statusCode);
      if (e.response?.statusCode == 401) {
        apiResponse = BaseApiResponse.fromJson(e.response);
        throw(apiResponse.message);
      }else if (e.response?.statusCode == 404) {
        throw ("Resource not found, please try again later");
      }else if (e.response?.statusCode?.isBetween(399,499)==true) {
        apiResponse = BaseApiResponse.fromJson(e.response);
        debugPrint("Server ${e.response?.statusCode} response: ${apiResponse.message}");
        throw (apiResponse.message);
      } else if (e.response?.statusCode?.isBetween(500,599)==true)  {
        debugPrint("Server 500 response: $apiResponse");
        throw ("We are unable to process request at this time, please try again later \n[${e.response?.statusCode}]");
      } else {
        apiResponse = BaseApiResponse.fromJson(e.response);
        debugPrint("Network Unknown response: ${e.response}");
        throw (apiResponse.message);
      }
    }
    catch(e){
      debugPrint("Internal error response $e");
      throw ("An internal error occurred while processing this request");
    }

  }

}

extension Range on num {
  bool isBetween(num from, num to) {
    return from < this && this < to;
  }
}

enum RequestType {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
  MULTI_PART_POST,
}