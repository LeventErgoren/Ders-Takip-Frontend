import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/models/calisma_suresi.dart';
import 'package:ders_app/models/paginated_calisma_suresi_requestdart';
import 'package:ders_app/models/paginated_calisma_suresi_response.dart';
import 'package:ders_app/repositories/calisma_suresi_repository.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:get/get.dart';

class TimeController extends BaseController {
  final paginatedList = Rx<List<CalismaSuresi>?>(null);
  final sort = "desc".obs;
  final currentPage = 0.obs;
  final maxPage = 0.obs;
  final pageSize = 10.obs;
  late int userId;
  late CalismaSuresiRepository _repository;
  Map<int, List<CalismaSuresi>> cachedData = {};

  @override
  void onInit() async {
    super.onInit();

    userId = Get.find<AuthService>().userId.value;
    _repository = Get.find<CalismaSuresiRepository>();

    await getPaginatedList();
  }

  Future<void> getPaginatedList() async {
    if (cachedData.containsKey(currentPage.value)) {
      paginatedList.value = cachedData[currentPage.value];
    } else {
      setLoading(true);

      PaginatedCalismaSuresiRequest request = PaginatedCalismaSuresiRequest(
        id: userId,
        page: currentPage.value,
        sort: sort.value,
      );

      PaginatedCalismaSuresiResponse? response = await _repository
          .getPaginatedCalismaSureleri(request);

      if (response != null) {
        currentPage.value = response.pageNumber;
        maxPage.value = response.totalElement;
        pageSize.value = response.pageSize;
        paginatedList.value = response.content;

        cachedData[currentPage.value] = response.content;

        cachedData = Map.fromEntries(
          cachedData.entries.where(
            (e) => (e.key - currentPage.value).abs() < 4,
          ),
        );
      } else {
        paginatedList.value = null;
      }

      setLoading(false);
    }
  }

  void makeAsc(_) {
    sort.value = 'asc';
    currentPage.value = 0;
    cachedData.clear();
    getPaginatedList();
  }

  void makeDesc(bool value) {
    sort.value = 'desc';
    currentPage.value = 0;
    cachedData.clear();
    getPaginatedList();
  }
}
