import 'package:ders_app/services/auth_service.dart';
import 'package:ders_app/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

abstract class ApiConstants {
  static const baseUrl = "http://10.0.2.2:8080";
  static const login = "/authenticate";
  static const register = "/register";
  static const refreshToken = "/refreshToken";
  static const getOgrenci = "/api/v1/ogrenci/get/";
  static const postCalismaSuresi = "/api/v1/add-calisma-suresi/";
  static const getCalismaSureleri = "/api/v1/calisma-sureleri/";
  static const getCalismaSureleriWithTime =
      "/api/v1/calisma-sureleri-with-time/";
}

class ApiService extends GetxService {
  late StorageService _storageService;
  late Dio _dio;

  final List<String> noAuthRequests = [
    "/authenticate",
    "/register",
    "/refreshToken",
  ];

  Future<ApiService> init() async {
    _storageService = Get.find<StorageService>();
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 20),
        contentType: "application/json",
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final shouldSkipAuth = noAuthRequests.any(
            (element) => options.path.contains(element),
          );

          if (!shouldSkipAuth) {
            final token = _storageService.getValue<String>(StorageKeys.token);
            if (token != null) {
              options.headers["Authorization"] = "Bearer $token";
            }
          }

          return handler.next(options);

          // final token = _storageService.getValue<String>(StorageKeys.token);
          // if (token != null) {
          //   options.headers["Authorization"] = "Bearer $token";
          // }
          // return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response!.statusCode == 401) {
            final _authService = Get.find<AuthService>();
            final isRefreshed = await _authService.refreshToken();

            if (isRefreshed) {
              final newToken = _storageService.getValue<String>(
                StorageKeys.token,
              );
              error.requestOptions.headers["Authorization"] =
                  "Bearer $newToken";

              final clonedRequest = await _dio.fetch(error.requestOptions);
              return handler.resolve(clonedRequest);
            } else {
              final _authService = Get.find<AuthService>();
              await _authService.clearTokenAndRefreshToken();

              Get.offAllNamed("/login");

              return handler.reject(error);
            }
          }

          return handler.next(error);
          // if (error.response!.statusCode == 401) {
          //   await _storageService.remove(StorageKeys.token);
          // }
          // return handler.next(error);
        },
      ),
    );
    return this;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("Dio get error $e");
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("Dio post hatası $e");
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("Dio put hatası $e");
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("Dio silme hatası $e");
      rethrow;
    }
  }
}
