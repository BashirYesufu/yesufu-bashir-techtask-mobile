import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class BaseApiResponse<T> extends Equatable {

  late final String message;
  late final T data;
  late final bool success;

  BaseApiResponse(
      this.message,
      this.data,
      this.success
  );

  BaseApiResponse.fromJson(Response<dynamic>? json) {
    message = json?.data?['message'] ?? "An error occurred while processing this request";
    data = json?.data;
    success = data!=null || json?.statusCode == 200;
  }

  @override
  List<Object?> get props => [message, data, success];
}