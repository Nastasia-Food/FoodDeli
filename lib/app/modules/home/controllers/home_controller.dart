// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/api-list.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/branch_model.dart';
import '../../../data/model/response/count_model.dart';
import '../../../data/model/response/order_details.dart';
import '../../../data/model/response/order_model.dart';
import '../../../data/repository/branch_repo.dart';
import '../../../data/repository/order_list_repo.dart';
import '../../home/views/order_details_view.dart';
import '../views/confirm_delivery_view.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  static Server server = Server();
  List<BranchData> branchDataList = <BranchData>[];
  List<OrderListData> orderListData = <OrderListData>[];
  List<OrderListData> activeOrderList = <OrderListData>[];
  List<OrderListData> previousOrderList = <OrderListData>[];
  OrderDetailsData orderDetailsData = OrderDetailsData();
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();

  CountModel countModel = CountModel();
  CountData countData = CountData();

  bool loader = false;
  bool orderDetailsLoader = false;
  bool orderConfirmLoader = false;
  bool orderCountLoader = false;
  int? orderId;

  @override
  void onInit() {
    getBranchList();
    getOrderList();
    getOrderCount();
    super.onInit();
  }

  getBranchList() async {
    var branchData = await BranchRepo.getBranch();
    if (branchData.data!.isNotEmpty) {
      branchDataList = branchData.data!;
      update();
    }
  }

  void getOrderList() async {
    loader = true;
    update();
    if (box.read('isLogedIn') != null && box.read('isLogedIn') != false) {
      var myOrderData = await OrderRepo.getOrderList();
      if (myOrderData != null) {
        orderListData = myOrderData.data!;
        activeOrderList = orderListData
            .where((element) => element.status != 13 && element.status != 22)
            .toList();
        update();
        previousOrderList = orderListData
            .where((element) => element.status == 13 || element.status == 22)
            .toList();
        update();
        loader = false;
        update();
      } else {
        loader = false;
        update();
      }
    } else {
      loader = false;
      update();
    }
  }

  Future<OrderDetailsModel?> getOrderDetails(int id) async {
    orderDetailsLoader = true;
    update();
    try {
      await server
          .getRequest(
        endPoint: APIList.orderDetails! + id.toString(),
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          orderDetailsModel = OrderDetailsModel.fromJson(jsonResponse);
          orderDetailsData = orderDetailsModel.data!;
          update();
          orderDetailsLoader = false;
          update();
          Get.to(() => const OrderDetailsView());
          return orderDetailsModel;
        } else {
          orderDetailsLoader = false;
          update();
        }
      });
      return orderDetailsModel;
    } catch (e) {
      orderDetailsLoader = false;
      update();
    }
  }

  confirmOrderDelivery(int id) async {
    Get.back();
    orderConfirmLoader = true;
    update();
    Map body = {'status': 13};
    String jsonBody = json.encode(body);
    try {
      await server
          .postRequestWithToken(
              endPoint: APIList.changeOrderStatus! + id.toString(),
              body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          orderDetailsLoader = false;
          update();
          getOrderList();
          update();
          Get.offAll(() => const ConfirmDeliveryView());
        } else {
          orderDetailsLoader = false;
          update();
        }
      });
    } catch (e) {
      orderDetailsLoader = false;
      update();
    }
    orderConfirmLoader = false;
    update();
  }

  Future<CountModel?> getOrderCount() async {
    orderCountLoader = true;
    update();
    try {
      await server.getRequest(endPoint: APIList.orderCount!).then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          countModel = CountModel.fromJson(jsonResponse);
          countData = countModel.data!;
          orderCountLoader = false;
          update();
          return countModel;
        } else {
          orderCountLoader = false;
          update();
        }
      });
      return countModel;
    } catch (e) {
      orderCountLoader = false;
      update();
    }
  }
}
