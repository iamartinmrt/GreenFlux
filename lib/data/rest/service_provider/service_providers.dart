import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/constants/constants.dart';
import 'package:green_flux/core/handlers/env_handler.dart';
import 'package:green_flux/core/logger/gf_logger.dart';
import 'package:green_flux/data/rest/services/service_stations.dart';

final baseUrlProvider =
    Provider<String>((ref) => EnvHandler.instance.envProperties.baseUrl);

final serviceDioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio(BaseOptions(
    connectTimeout:
        const Duration(milliseconds: Constants.dioDefaultConnectTimeOut),
    receiveTimeout:
        const Duration(milliseconds: Constants.dioDefaultReceiveTimeOut),
  ));

  /// Monitor every usage of this Dio and log every action
  dio.interceptors.add(QueuedInterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers["Authorization"] = "ApiKey ${EnvHandler.instance.envProperties.apiKey}";
      /// If any API has an extra data containing a custom timeout, then change
      /// the timeout to what was past on that API
      if (options.extra.containsKey(Constants.customTimeOut)) {
        options.receiveTimeout =
            Duration(milliseconds: options.extra[Constants.customTimeOut]);
      }
      _logRequest(options.baseUrl, options.path, options.headers.toString(),
          options.data.toString());
      return handler.next(options);
    },
    onResponse: (response, handler) {
      _logResponse(
          response.requestOptions.baseUrl,
          response.requestOptions.path,
          response.headers.toString(),
          response.data.toString());
      return handler.next(response);
    },
    onError: (error, handler) {
      _logError(error.requestOptions.baseUrl, error.requestOptions.path,
          error.error.toString());
      return handler.next(error);
    },
  ));

  return dio;
});

void _logRequest(String url, String path, String header, String body) {
  final String printText =
      "*** API Request ***\nURL ====> $url$path\nHeader => $header\nBody ===> $body";
  GfLogger.logInfo(printText);
}

void _logResponse(String url, String path, String header, String body) {
  final String printText =
      "*** API Response ***\nURL ====> $url$path\nHeader => $header\nBody ===> $body";
  GfLogger.logInfo(printText);
}

void _logError(String url, String path, String error) {
  final String printText =
      "*** API Error ***\nURL ====> $url$path\nError ===> $error";
  GfLogger.logError(printText);
}

final serviceStationsProvider = Provider((ref) {
  return StationsService(
    ref.watch(serviceDioProvider),
    baseUrl: ref.read(baseUrlProvider),
  );
});
