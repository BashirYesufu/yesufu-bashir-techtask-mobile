import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class BaseApiResponse<T> extends Equatable {

  late final String message;
  late final T data;
  late final bool success;
  late final int? statusCode;

  BaseApiResponse(
      this.message,
      this.data,
      this.success,
      this.statusCode,
  );

  BaseApiResponse.fromJson(Response<dynamic>? json) {
    data = json?.data;
    message = data!=null ? "Success" : "An error occurred while processing this request";
    statusCode = json?.statusCode;
    success = data!=null || statusCode == 200;
  }

  @override
  List<Object?> get props => [message, data, success];
}