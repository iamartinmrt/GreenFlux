import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_flux/core/network/error_response.dart';

part 'network_response.freezed.dart';

@Freezed(genericArgumentFactories: true)
class NetworkResponse<T> with _$NetworkResponse<T> {
  const factory NetworkResponse.success(T data) = _data;

  const factory NetworkResponse.error(ErrorResponse error) = _error;

  const factory NetworkResponse.canceled() = _canceled;
}
