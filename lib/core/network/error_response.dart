import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_flux/core/constants/constants.dart';

part 'error_response.freezed.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    @Default(Constants.defaultErrorMessage) String message,
  }) = _errorResponse;

  factory ErrorResponse.fromDio(Object? obj) {
    if (obj == null) {
      return const ErrorResponse();
    }
    switch (obj.runtimeType) {
      case DioException:
        try {
          final errorMsg = (obj as DioException).response?.data ?? Constants.defaultErrorMessage;
          return ErrorResponse(message: errorMsg);
        } catch (_) {
          return const ErrorResponse();
        }
      default:
        return const ErrorResponse();
    }
  }
}
