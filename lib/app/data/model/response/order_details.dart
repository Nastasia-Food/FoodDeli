// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderListModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderListModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    this.data,
  });

  OrderDetailsData? data;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        data: json["data"] == null
            ? null
            : OrderDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class OrderDetailsData {
  OrderDetailsData({
    this.id,
    this.orderSerialNo,
    this.token,
    this.subtotalCurrencyPrice,
    this.discountCurrencyPrice,
    this.deliveryChargeCurrencyPrice,
    this.totalCurrencyPrice,
    this.orderType,
    this.orderDatetime,
    this.orderDate,
    this.orderTime,
    this.deliveryDate,
    this.deliveryTime,
    this.paymentMethod,
    this.paymentStatus,
    this.isAdvanceOrder,
    this.preparationTime,
    this.status,
    this.statusName,
    this.reason,
    this.user,
    this.orderAddress,
    this.branch,
    this.deliveryBoy,
    this.coupon,
    this.transaction,
    this.orderItems,
  });

  int? id;
  String? orderSerialNo;
  dynamic token;
  String? subtotalCurrencyPrice;
  String? discountCurrencyPrice;
  String? deliveryChargeCurrencyPrice;
  String? totalCurrencyPrice;
  int? orderType;
  String? orderDatetime;
  String? orderDate;
  String? orderTime;
  String? deliveryDate;
  String? deliveryTime;
  int? paymentMethod;
  int? paymentStatus;
  int? isAdvanceOrder;
  int? preparationTime;
  int? status;
  String? statusName;
  dynamic reason;
  Customer? user;
  OrderAddress? orderAddress;
  Branch? branch;
  DeliveryBoy? deliveryBoy;
  dynamic coupon;
  Transaction? transaction;
  List<OrderItem>? orderItems;

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) =>
      OrderDetailsData(
        id: json["id"],
        orderSerialNo: json["order_serial_no"],
        token: json["token"],
        subtotalCurrencyPrice: json["subtotal_currency_price"],
        discountCurrencyPrice: json["discount_currency_price"],
        deliveryChargeCurrencyPrice: json["delivery_charge_currency_price"],
        totalCurrencyPrice: json["total_currency_price"],
        orderType: json["order_type"],
        orderDatetime: json["order_datetime"],
        orderDate: json["order_date"],
        orderTime: json["order_time"],
        deliveryDate: json["delivery_date"],
        deliveryTime: json["delivery_time"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        isAdvanceOrder: json["is_advance_order"],
        preparationTime: json["preparation_time"],
        status: json["status"],
        statusName: json["status_name"],
        reason: json["reason"],
        user: json["user"] == null ? null : Customer.fromJson(json["user"]),
        orderAddress: json["order_address"] == null
            ? null
            : OrderAddress.fromJson(json["order_address"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        deliveryBoy: json["delivery_boy"] == null
            ? null
            : DeliveryBoy.fromJson(json["delivery_boy"]),
        coupon: json["coupon"],
        transaction: json["transaction"] == null
            ? null
            : Transaction.fromJson(json["transaction"]),
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_serial_no": orderSerialNo,
        "token": token,
        "subtotal_currency_price": subtotalCurrencyPrice,
        "discount_currency_price": discountCurrencyPrice,
        "delivery_charge_currency_price": deliveryChargeCurrencyPrice,
        "total_currency_price": totalCurrencyPrice,
        "order_type": orderType,
        "order_datetime": orderDatetime,
        "order_date": orderDate,
        "order_time": orderTime,
        "delivery_date": deliveryDate,
        "delivery_time": deliveryTime,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "is_advance_order": isAdvanceOrder,
        "preparation_time": preparationTime,
        "status": status,
        "status_name": statusName,
        "reason": reason,
        "user": user?.toJson(),
        "order_address": orderAddress?.toJson(),
        "branch": branch?.toJson(),
        "delivery_boy": deliveryBoy?.toJson(),
        "coupon": coupon,
        "transaction": transaction?.toJson(),
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}

class Branch {
  Branch({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.zipCode,
    this.address,
    this.status,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  String? latitude;
  String? longitude;
  String? city;
  String? state;
  String? zipCode;
  String? address;
  int? status;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
        address: json["address"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "address": address,
        "status": status,
      };
}

class DeliveryBoy {
  DeliveryBoy({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.username,
    this.balance,
    this.image,
    this.roleId,
    this.countryCode,
    this.order,
    this.createDate,
    this.updateDate,
  });

  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? username;
  String? balance;
  String? image;
  int? roleId;
  String? countryCode;
  int? order;
  String? createDate;
  String? updateDate;

  factory DeliveryBoy.fromJson(Map<String, dynamic> json) => DeliveryBoy(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        username: json["username"],
        balance: json["balance"],
        image: json["image"],
        roleId: json["role_id"],
        countryCode: json["country_code"],
        order: json["order"],
        createDate: json["create_date"],
        updateDate: json["update_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "username": username,
        "balance": balance,
        "image": image,
        "role_id": roleId,
        "country_code": countryCode,
        "order": order,
        "create_date": createDate,
        "update_date": updateDate,
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.username,
    this.balance,
    this.image,
    this.roleId,
    this.countryCode,
    this.order,
    this.createDate,
    this.updateDate,
  });

  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? username;
  String? balance;
  String? image;
  int? roleId;
  String? countryCode;
  int? order;
  String? createDate;
  String? updateDate;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        username: json["username"],
        balance: json["balance"],
        image: json["image"],
        roleId: json["role_id"],
        countryCode: json["country_code"],
        order: json["order"],
        createDate: json["create_date"],
        updateDate: json["update_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "username": username,
        "balance": balance,
        "image": image,
        "role_id": roleId,
        "country_code": countryCode,
        "order": order,
        "create_date": createDate,
        "update_date": updateDate,
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
  String? apartment;
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

class OrderItem {
  OrderItem({
    this.id,
    this.orderId,
    this.branchId,
    this.itemId,
    this.itemName,
    this.itemImage,
    this.quantity,
    this.discount,
    this.price,
    this.itemVariations,
    this.itemExtras,
    this.itemVariationCurrencyTotal,
    this.itemExtraCurrencyTotal,
    this.totalConvertPrice,
    this.totalCurrencyPrice,
    this.instruction,
  });

  int? id;
  int? orderId;
  int? branchId;
  int? itemId;
  String? itemName;
  String? itemImage;
  int? quantity;
  String? discount;
  String? price;
  List<ItemVariation>? itemVariations;
  List<ItemExtra>? itemExtras;
  String? itemVariationCurrencyTotal;
  String? itemExtraCurrencyTotal;
  double? totalConvertPrice;
  String? totalCurrencyPrice;
  String? instruction;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        branchId: json["branch_id"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemImage: json["item_image"],
        quantity: json["quantity"],
        discount: json["discount"],
        price: json["price"],
        itemVariations: json["item_variations"] == null
            ? []
            : List<ItemVariation>.from(
                json["item_variations"]!.map((x) => ItemVariation.fromJson(x))),
        itemExtras: json["item_extras"] == null
            ? []
            : List<ItemExtra>.from(
                json["item_extras"]!.map((x) => ItemExtra.fromJson(x))),
        itemVariationCurrencyTotal: json["item_variation_currency_total"],
        itemExtraCurrencyTotal: json["item_extra_currency_total"],
        totalConvertPrice: json["total_convert_price"]?.toDouble(),
        totalCurrencyPrice: json["total_currency_price"],
        instruction: json["instruction"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "branch_id": branchId,
        "item_id": itemId,
        "item_name": itemName,
        "item_image": itemImage,
        "quantity": quantity,
        "discount": discount,
        "price": price,
        "item_variations": itemVariations == null
            ? []
            : List<dynamic>.from(itemVariations!.map((x) => x.toJson())),
        "item_extras": itemExtras == null
            ? []
            : List<dynamic>.from(itemExtras!.map((x) => x)),
        "item_variation_currency_total": itemVariationCurrencyTotal,
        "item_extra_currency_total": itemExtraCurrencyTotal,
        "total_convert_price": totalConvertPrice,
        "total_currency_price": totalCurrencyPrice,
        "instruction": instruction,
      };
}

class ItemExtra {
  ItemExtra({
    this.id,
    this.itemId,
    this.name,
  });

  int? id;
  int? itemId;
  String? name;

  factory ItemExtra.fromJson(Map<String, dynamic> json) => ItemExtra(
        id: json["id"],
        itemId: json["item_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "name": name,
      };
}

class ItemVariation {
  ItemVariation({
    this.id,
    this.itemId,
    this.itemAttributeId,
    this.variationName,
    this.name,
  });

  int? id;
  dynamic itemId;
  dynamic itemAttributeId;
  String? variationName;
  String? name;

  factory ItemVariation.fromJson(Map<String, dynamic> json) => ItemVariation(
        id: json["id"],
        itemId: json["item_id"],
        itemAttributeId: json["item_attribute_id"],
        variationName: json["variation_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "item_attribute_id": itemAttributeId,
        "variation_name": variationName,
        "name": name,
      };
}

class Transaction {
  int? id;
  int? orderId;
  String? orderSerialNo;
  String? transactionNo;
  String? amount;
  String? paymentMethod;
  String? type;
  String? sign;
  String? date;

  Transaction({
    this.id,
    this.orderId,
    this.orderSerialNo,
    this.transactionNo,
    this.amount,
    this.paymentMethod,
    this.type,
    this.sign,
    this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        orderId: json["order_id"],
        orderSerialNo: json["order_serial_no"],
        transactionNo: json["transaction_no"],
        amount: json["amount"],
        paymentMethod: json["payment_method"],
        type: json["type"],
        sign: json["sign"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "order_serial_no": orderSerialNo,
        "transaction_no": transactionNo,
        "amount": amount,
        "payment_method": paymentMethod,
        "type": type,
        "sign": sign,
        "date": date,
      };
}
