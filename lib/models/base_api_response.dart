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
    data = json?.data;
    message = data!=null ? "Success" : "An error occurred while processing this request";
    success = data!=null || json?.statusCode == 200;
  }

  @override
  List<Object?> get props => [message, data, success];
}