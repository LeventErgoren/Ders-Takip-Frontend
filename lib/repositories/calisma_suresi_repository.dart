import 'package:ders_app/models/calisma_suresi.dart';
import 'package:ders_app/models/calisma_suresi_time.dart';
import 'package:ders_app/services/api_service.dart';
import 'package:get/get.dart';

class CalismaSuresiRepository extends GetxService {
  late final ApiService _apiService;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  Future<List<CalismaSuresi>> getCalismaSureleriWithTime(
    CalismaSuresiTime time,
    int id,
  ) async {
    final response = await _apiService.get(
      ApiConstants.getCalismaSureleriWithTime + id.toString(),
      queryParameters: {"aralik": time.name.toUpperCase()},
    );

    if (response.statusCode == 200) {
      var gelenListe = response.data as List;
      return gelenListe.map((e) => CalismaSuresi.fromJson(e)).toList();
    }
    throw Exception("Çalışma süresi time ile getirilirken bir sorun oluştu");
  }

  Future<List<CalismaSuresi>> getCalismaSureleri(int id) async {
    final response = await _apiService.get(
      ApiConstants.getCalismaSureleri + id.toString(),
    );
    if (response.statusCode == 200) {
      var gelenListe = response.data as List;
      return gelenListe.map((e) => CalismaSuresi.fromJson(e)).toList();
    }
    throw Exception("Çalışma süreleri getirilirken bir hata oluştu");
  }

  Future<CalismaSuresi> addCalismaSuresi(int id, int dakika) async {
    final response = await _apiService.post(
      ApiConstants.postCalismaSuresi + id.toString(),
      queryParameters: {"dakika": dakika.toString()},
    );

    if (response.statusCode == 200) {
      return CalismaSuresi.fromJson(response.data);
    }
    throw Exception("Çalışma süresi eklenirken bir hata oluştu");
  }
}
