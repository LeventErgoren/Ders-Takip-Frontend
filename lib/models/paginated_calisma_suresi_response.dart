import 'package:ders_app/models/calisma_suresi.dart';

class PaginatedCalismaSuresiResponse {
  final List<CalismaSuresi> content;
  final int pageNumber;
  final int pageSize;
  final int totalElement;

  PaginatedCalismaSuresiResponse({
    required this.content,
    required this.pageNumber,
    required this.pageSize,
    required this.totalElement,
  });

  factory PaginatedCalismaSuresiResponse.fromJson(Map<String, dynamic> json) =>
      PaginatedCalismaSuresiResponse(
        content: List<CalismaSuresi>.from(
          json["content"].map((x) => CalismaSuresi.fromJson(x)),
        ),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        totalElement: json["totalElement"],
      );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "totalElement": totalElement,
  };
}
