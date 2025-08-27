import 'package:ders_app/models/maintenance.dart';
import 'package:ders_app/models/register_request.dart';
import 'package:ders_app/models/tokens.dart';
import 'package:ders_app/models/user.dart';
import 'package:ders_app/models/login_request.dart';
import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:ders_app/services/api_service.dart';
import 'package:ders_app/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService extends GetxService {
  late final StorageService _storageService;
  late final ApiService _apiService;

  final errorMessage = "".obs;
  Rx<int> userId = Rx<int>(-1);
  Rx<User?> currentUser = Rx<User?>(null);

  Future<AuthService> init() async {
    _storageService = Get.find<StorageService>();
    _apiService = Get.find<ApiService>();
    return this;
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = _storageService.getValue<String>(
        StorageKeys.refreshToken,
      );

      final response = await _apiService.post(
        ApiConstants.refreshToken,
        data: {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200) {
        String token = response.data["accessToken"];
        String refreshToken = response.data["refreshToken"];

        await clearTokenAndRefreshToken();

        await _storageService.setValue<String>(StorageKeys.token, token);
        await _storageService.setValue(StorageKeys.refreshToken, refreshToken);
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Refresh token sırasında bir hata oluştu $e");
    }
  }

  Future<bool> login(LoginRequest data) async {
    try {
      final response = await _apiService.post(
        ApiConstants.login,
        data: data.toJson(),
      );
      if (response.statusCode == 200) {
        String token = response.data["accessToken"];
        String refreshToken = response.data["refreshToken"];

        await clearTokenAndRefreshToken();

        await _storageService.setValue(StorageKeys.token, token);
        await _storageService.setValue(StorageKeys.refreshToken, refreshToken);

        int idFromToken = _getIdFromToken();
        userId.value = idFromToken;
        errorMessage.value = "";
        return true;
      }
      return false;
    } on DioException catch (e) {
      errorMessage.value = e.response!.data["exception"];
      return false;
    } catch (e) {
      throw Exception("Giriş yapılırken bilinmeyen bir sorun oluştu $e");
    }
  }

  Future<bool> register(RegisterRequest request) async {
    try {
      final response = await _apiService.post(
        ApiConstants.register,
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        errorMessage.value = "";
        return true;
      }
      return false;
    } on DioException catch (e) {
      errorMessage.value = e.response!.data["exception"];
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<User?> getProfile() async {
    try {
      int userId = _getIdFromToken();
      final response = await _apiService.get(
        ApiConstants.getOgrenci + userId.toString(),
      );
      if (response.statusCode == 200) {
        currentUser.value = User.fromJson(response.data);
        return currentUser.value;
      }
      currentUser.value = null;
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await clearUserDetails();
      Get.find<ApiService>().inApp = false;
      Get.toNamed(AppRoutes.LOGIN);
    } catch (_) {}
  }

  int _getIdFromToken() {
    try {
      final token = _storageService.getValue<String>(StorageKeys.token);
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token!);
      int userId = decodedToken["id"];
      return userId;
    } catch (e) {
      throw Exception("Tokenı çözümlerken hata çıktı $e");
    }
  }

  Future<void> clearTokenAndRefreshToken() async {
    await _storageService.remove(StorageKeys.token);
    await _storageService.remove(StorageKeys.refreshToken);
  }

  Future<void> checkToken() async {
    String? token = _storageService.getValue(StorageKeys.token);
    String? refreshToken = _storageService.getValue(StorageKeys.refreshToken);

    if (token == null || refreshToken == null) {
      await clearUserDetails();
      Get.offAllNamed(AppRoutes.LOGIN);
      return;
    }

    try {
      userId.value = _getIdFromToken();
      final response = await _apiService.get(
        ApiConstants.getOgrenci + userId.toString(),
      );

      if (response.statusCode == 200) {
        Get.offAllNamed(AppRoutes.HOME);
        Get.find<ApiService>().inApp = true;
        return;
      }
      await clearUserDetails();
    } on DioException catch (_) {
      await tryRefreshToken(refreshToken);
    } catch (_) {}
  }

  Future<void> clearUserDetails() async {
    await clearTokenAndRefreshToken();
    errorMessage.value = "";
    userId.value = -1;
    currentUser.value = null;
  }

  Future<void> tryRefreshToken(String refreshToken) async {
    try {
      final response = await _apiService.post(
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
        Get.toNamed(AppRoutes.HOME);
      }
    } on DioException catch (_) {
      await clearUserDetails();
      Get.offAllNamed(AppRoutes.LOGIN);
    } catch (e) {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  Future<Maintenance?> isMaintenance() async {
    try {
      final response = await _apiService.get(ApiConstants.isMaintenance);

      if (response.statusCode == 200) {
        Maintenance maintenance = Maintenance.fromJson(response.data);
        return maintenance;
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
