import 'package:ders_app/models/calisma_suresi.dart';
import 'package:ders_app/modules/time/time_controller.dart';
import 'package:ders_app/modules/time/widgets/build_card.dart';
import 'package:ders_app/modules/time/widgets/build_pagination.dart';
import 'package:ders_app/modules/time/widgets/build_sort_chips.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TimePage extends GetView<TimeController> {
  const TimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Çalışma Sürelerim'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          BuildSortChips(),
          Expanded(
            child: Obx(() {
              final list = controller.paginatedList.value;
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (list == null || list.isEmpty) {
                return const Center(child: Text('Henüz kayıt yok.'));
              }

              return AnimationLimiter(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final CalismaSuresi item = list[index];
                    final formattedDate = DateFormat(
                      'dd MMMM yyyy',
                      'tr_TR',
                    ).format(item.creationDate);

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 300),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: buildCard(context, formattedDate, item.dakika),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          BuildPagination(),
        ],
      ),
    );
  }
}
