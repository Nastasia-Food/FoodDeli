// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) =>
    OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  OrderListModel({
    this.data,
  });

  List<OrderListData>? data;

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        data: json["data"] == null
            ? []
            : List<OrderListData>.from(
                json["data"]!.map((x) => OrderListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OrderListData {
  OrderListData({
    this.id,
    this.orderSerialNo,
    this.orderType,
    this.orderDatetime,
    this.orderDate,
    this.orderTime,
    this.deliveryDate,
    this.deliveryTime,
    this.paymentMethod,
    this.paymentStatus,
    this.isAdvanceOrder,
    this.status,
    this.statusName,
    this.reason,
    this.orderAddress,
  });

  int? id;
  String? orderSerialNo;
  int? orderType;
  String? orderDatetime;
  String? orderDate;
  String? orderTime;
  String? deliveryDate;
  String? deliveryTime;
  int? paymentMethod;
  int? paymentStatus;
  int? isAdvanceOrder;
  int? status;
  String? statusName;
  dynamic reason;
  OrderAddress? orderAddress;

  factory OrderListData.fromJson(Map<String, dynamic> json) => OrderListData(
        id: json["id"],
        orderSerialNo: json["order_serial_no"],
        orderType: json["order_type"],
        orderDatetime: json["order_datetime"],
        orderDate: json["order_date"],
        orderTime: json["order_time"],
        deliveryDate: json["delivery_date"],
        deliveryTime: json["delivery_time"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        isAdvanceOrder: json["is_advance_order"],
        status: json["status"],
        statusName: json["status_name"],
        reason: json["reason"],
        orderAddress: json["order_address"] == null
            ? null
            : OrderAddress.fromJson(json["order_address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_serial_no": orderSerialNo,
        "order_type": orderType,
        "order_datetime": orderDatetime,
        "order_date": orderDate,
        "order_time": orderTime,
        "delivery_date": deliveryDate,
        "delivery_time": deliveryTime,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "is_advance_order": isAdvanceOrder,
        "status": status,
        "status_name": statusName,
        "reason": reason,
        "order_address": orderAddress?.toJson(),
      };
}

class OrderAddress {
  OrderAddress({
    this.id,
    this.userId,
    this.label,
    this.address,
    this.apartment,
    this.latitude,
    this.longitude,
  });

  int? id;
  int? userId;
  String? label;
  String? address;
  dynamic apartment;
  String? latitude;
  String? longitude;

  factory OrderAddress.fromJson(Map<String, dynamic> json) => OrderAddress(
        id: json["id"],
        userId: json["user_id"],
        label: json["label"],
        address: json["address"],
        apartment: json["apartment"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "label": label,
        "address": address,
        "apartment": apartment,
        "latitude": latitude,
        "longitude": longitude,
      };
}
