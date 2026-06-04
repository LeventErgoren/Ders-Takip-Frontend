import 'package:ders_app/models/tokens.dart';
import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:ders_app/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

abstract class ApiConstants {
  static const baseUrl = "http://localhost:8080";
  static const login = "/authenticate";
  static const register = "/register";
  static const refreshToken = "/refreshToken";
  static const getOgrenci = "/api/v1/ogrenci/get/";
  static const postCalismaSuresi = "/api/v1/add-calisma-suresi/";
  static const postCalismaSuresiWithTime = "/api/v1/add-calisma-suresi-time/";
  static const getCalismaSureleri = "/api/v1/calisma-sureleri/";
  static const getCalismaSureleriWithTime =
      "/api/v1/calisma-sureleri-with-time/";
  static const paginatedCalismaSuresi = "/api/v1/get-paginated-calisma-suresi";
  static const isMaintenance = "/is-maintenance";
}

class ApiService extends GetxService {
  late StorageService _storageService;
  late Dio _dio;
  bool inApp = false;

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
        },

        onError: (error, handler) async {
          if (error.response?.statusCode == 401 && inApp) {
            final success = await _tryRefreshToken();
            if (success) {
              final newToken = _storageService.getValue<String>(
                StorageKeys.token,
              );
              final options = error.requestOptions;

              options.headers["Authorization"] = "Bearer $newToken";

              try {
                final clonedResponse = await _dio.fetch(options);
                return handler.resolve(clonedResponse);
              } catch (e) {
                return handler.reject(error);
              }
            } else {
              Get.find<AuthService>().signOut();
              Get.toNamed(AppRoutes.LOGIN);

              return handler.reject(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
    return this;
  }

  Future<bool> _tryRefreshToken() async {
    try {
      String? refreshToken = _storageService.getValue<String>(
        StorageKeys.refreshToken,
      );
      final response = await post(
        ApiConstants.refreshToken,
        data: {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200) {
        Tokens tokens = Tokens.fromJson(response.data);
        await _storageService.setValue<String>(
          StorageKeys.token,
          tokens.accessToken,
        );
        await _storageService.setValue<String>(
          StorageKeys.refreshToken,
          tokens.refreshToken,
        );
        return true;
      }
      return false;
    } on DioException catch (_) {
      await _storageService.remove(StorageKeys.token);
      await _storageService.remove(StorageKeys.refreshToken);
      Get.toNamed(AppRoutes.LOGIN);
      return false;
    } catch (e) {
      await _storageService.remove(StorageKeys.token);
      await _storageService.remove(StorageKeys.refreshToken);
      Get.toNamed(AppRoutes.LOGIN);
      return false;
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    dynamic data,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        data: data,
      );
    } catch (e) {
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
      rethrow;
    }
  }
}
