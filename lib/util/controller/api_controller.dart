import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/constants/text/texts.dart';

class ApiController extends GetxService {
  late Dio _dio;
  RxnString _accessToken = RxnString();

  ApiController();

  void bindAccessToken(RxnString accessToken) {
    _accessToken = accessToken;

    // Listen for token changes
    _accessToken.listen((token) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    });
  }

  @override
  void onInit() {
    super.onInit();

    _dio = Dio(BaseOptions(
      baseUrl: CAPIEndPoint.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    // Add interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_accessToken.value != null) {
          options.headers["Authorization"] = "Bearer ${_accessToken.value}";
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Use Get.find only when absolutely
          final AuthController authController = Get.find<AuthController>();
          if (e.response?.data != null) {
            final data = e.response?.data;
            if (data is Map<String, dynamic> &&
                data.containsKey('error') &&
                data['error'] == CTexts.unauthorizedError) {
              showErrorPopup("Session Expired");
              authController.logout();
            }
          }
        }
        return handler.next(e);
      },
    ));
  }

  // Generic request
  Future<dynamic> request({
    required String endpoint,
    String method = "GET",
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    bool useToken = true,
  }) async {
    try {
      final combinedHeaders = <String, String>{};

      if (useToken && _accessToken.value != null) {
        combinedHeaders["Authorization"] = "Bearer ${_accessToken.value}";
      }

      if (headers != null) {
        combinedHeaders.addAll(headers);
      }

      Options options = Options(headers: combinedHeaders);
      Response response;

      switch (method) {
        case "POST":
          response = await _dio.post(endpoint, data: data, options: options);
          break;
        case "PUT":
          response = await _dio.put(endpoint, data: data, options: options);
          break;
        case "DELETE":
          response = await _dio.delete(endpoint, data: data, options: options);
          break;
        case "GET":
        default:
          response = await _dio.get(endpoint, data: data, options: options);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        final message = response.data?['message'] ?? 'Unknown error occurred';
        throw Exception('Error ${response.statusCode}: $message');
      }
    } catch (error) {
      String errorMessage = "Unexpected error occurred";

      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
            errorMessage = "Connection timed out. Please try again.";
            break;
          case DioExceptionType.sendTimeout:
            errorMessage = "Request timeout. Please try again.";
            break;
          case DioExceptionType.receiveTimeout:
            errorMessage = "Response timeout. Please try again.";
            break;
          case DioExceptionType.badResponse:
            final data = error.response?.data;
            if (data is Map && data.containsKey("message")) {
              errorMessage = data["message"];
            } else if (data is Map && data.containsKey("error")) {
              errorMessage = data["error"];
            } else if (data is String) {
              errorMessage = data;
            } else {
              errorMessage = "Server responded with an error.";
            }
            break;
          case DioExceptionType.cancel:
            errorMessage = "Request was cancelled.";
            break;
          case DioExceptionType.unknown:
            if (error.error is SocketException) {
              errorMessage = "No internet connection.";
            } else {
              errorMessage = "An unknown error occurred.";
            }
            break;
          default:
            errorMessage = error.message ?? "Unknown Dio error.";
        }
      } else {
        errorMessage = error.toString();
      }
      return Future.error(errorMessage);
    }
  }
}
