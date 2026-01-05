import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;
import 'package:get/get.dart' hide FormData;
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/routes/routes.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  late Dio _dio;

  ApiService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: "http://10.0.2.2:8000",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    );

    _dio = Dio(options);

    // Interceptor to inject token automatically
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String path = options.path;
          if (path.contains(CAPIEndPoint.login) ||
              path.contains("/api/auth/login")) {
            return handler.next(options);
          }
          String? token = await _secureStorage.read(key: "access_token");

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          final msg = _handleDioError(e);
          final status = e.response?.statusCode;
          final path = e.requestOptions.path; //

          if (path.contains(CAPIEndPoint.login) ||
              path.contains("/auth/login")) {
            return handler.next(e); // normal error handling for login
          }

          //  If server returns 401 → token expired or invalid
          if (status == 401) {
            debugPrint("Request Error: $e");

            await _secureStorage.delete(key: "access_token");
            Get.offAllNamed(CRoutes.signin);
            return; // Stop here
          }

          return handler.next(e);
        },
      ),
    );
  }

  Dio get client => _dio;

  Future<void> saveToken(String token, String refresh) async {
    await _secureStorage.write(key: "access_token", value: token);
    await _secureStorage.write(key: "refresh", value: refresh);
  }

  Future<void> removeToken() async {
    await _secureStorage.delete(key: "access_token");
  }

  Future<String?> getToken() => _secureStorage.read(key: "access_token");
  Future<String?> getRefreshToken() => _secureStorage.read(key: "refresh");

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: _detectContentType(data),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<dynamic> put(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: _detectContentType(data),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<dynamic> patch(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        options: _detectContentType(data),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<dynamic> delete(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        options: _detectContentType(data),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Options _detectContentType(dynamic data) {
    if (data is FormData) {
      return Options(method: "POST");
    }
    return Options(headers: {"Content-Type": "application/json"});
  }

  String? _extractBackendMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map) {
      if (data["message"] is String) return data["message"];
      if (data["detail"] is String) return data["detail"];

      // Extract first error from { field: [errors...] }
      for (var value in data.values) {
        if (value is List && value.isNotEmpty && value.first is String) {
          return value.first;
        }
        if (value is String) return value;
      }
    }

    // If backend returns a list of strings ["error 1", "error 2"]
    if (data is List) {
      if (data.isNotEmpty) {
        final first = data.first;
        if (first is String) return first;
        if (first is Map) return _extractBackendMessage(first);
      }
    }

    return null;
  }

  String _handleDioError(DioException error) {
    // Handle timeout errors
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return "Connection timeout. Please try again.";
    }

    // No internet
    else if (error.type == DioExceptionType.connectionError) {
      return "No Internet connection.";
    }

    // Handle backend response
    else if (error.response != null) {
      final status = error.response!.statusCode;
      final data = error.response!.data;

      // Try to extract backend message if available
      final backendMessage = _extractBackendMessage(data);

      // If backend has a message, show it instead of default errors
      if (backendMessage != null && backendMessage.isNotEmpty) {
        return backendMessage;
      }

      // Default messages per status code
      switch (status) {
        case 401:
          return "Unauthorized – please login again.";
        case 403:
          return "You don't have permission.";
        case 404:
          return "Resource not found.";
        case 500:
          return "Server error. Try later.";
      }

      // final fallback with status code
      return "Something went wrong ($status)";
    }

    debugPrint("Dio Error: $error");
    return "Unexpected error occurred.";
  }
}
