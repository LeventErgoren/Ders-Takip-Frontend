class Maintenance {
  final dynamic startDate;
  final dynamic finishDate;
  final dynamic scheduledTime;
  final dynamic reason;
  final bool maintenance;

  Maintenance({
    required this.startDate,
    required this.finishDate,
    required this.scheduledTime,
    required this.reason,
    required this.maintenance,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) => Maintenance(
    startDate: json["startDate"],
    finishDate: json["finishDate"],
    scheduledTime: json["scheduledTime"],
    reason: json["reason"],
    maintenance: json["maintenance"],
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate,
    "finishDate": finishDate,
    "scheduledTime": scheduledTime,
    "reason": reason,
    "maintenance": maintenance,
  };
}
