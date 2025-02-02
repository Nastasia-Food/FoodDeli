// To parse this JSON data, do
//
//     final countModel = countModelFromJson(jsonString);

import 'dart:convert';

CountModel countModelFromJson(String str) =>
    CountModel.fromJson(json.decode(str));

String countModelToJson(CountModel data) => json.encode(data.toJson());

class CountModel {
  CountModel({
    this.data,
  });

  CountData? data;

  factory CountModel.fromJson(Map<String, dynamic> json) => CountModel(
        data: json["data"] == null ? null : CountData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class CountData {
  CountData({
    this.totalDelivered,
    this.totalReturned,
  });

  int? totalDelivered;
  int? totalReturned;

  factory CountData.fromJson(Map<String, dynamic> json) => CountData(
        totalDelivered: json["total_delivered"],
        totalReturned: json["total_returned"],
      );

  Map<String, dynamic> toJson() => {
        "total_delivered": totalDelivered,
        "total_returned": totalReturned,
      };
}
