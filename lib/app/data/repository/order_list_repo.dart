import 'dart:convert';
import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/order_model.dart';

class OrderRepo {
  static Server server = Server();
  static OrderListModel orderListModel = OrderListModel();

  static Future<OrderListModel?> getOrderList() async {
    try {
      await server
          .getRequest(
        endPoint: APIList.orderList,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          orderListModel = OrderListModel.fromJson(jsonResponse);
          return orderListModel;
        }
      });
      return orderListModel;
    } catch (e) {
      return null;
    }
  }

  static Future<OrderListModel?> getOrderDetails(id) async {
    try {
      await server
          .getRequest(
        endPoint: APIList.orderDetails! + id.toString(),
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          orderListModel = OrderListModel.fromJson(jsonResponse);
          return orderListModel;
        }
      });
      return orderListModel;
    } catch (e) {
      return null;
    }
  }
}
