import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_response.freezed.dart';

@Freezed(genericArgumentFactories: true)
class NetworkResponse<T> with _$NetworkResponse<T> {
  const factory NetworkResponse.success(T data) = _data;
  const factory NetworkResponse.error(String error) = _error;
}