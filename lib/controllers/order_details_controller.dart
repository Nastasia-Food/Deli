import 'dart:convert';

import 'package:food_ex_delivery_app/models/order_details.dart';
import 'package:food_ex_delivery_app/services/api-list.dart';
import 'package:food_ex_delivery_app/services/server.dart';
import 'package:get/get.dart';

import 'notification_order_controller.dart';

class OrderDetailsController extends GetxController {
  Server server = Server();
  var orderId;
  bool loader = true;
  OrderDetailsByIdData? orderDetailsByIdData;
  int? statusCode;
  String? statusName;
  String? createdTime;
  String? orderCode;
  String? total;

  OrderDetailsController(this.orderId);

  @override
  void onInit() {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    getAllOrderDetailsById(orderId);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllOrderDetailsById(var id) async {
    server.getRequestWithParam(orderId: id).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        var idWiseOrderDetailsData = OrderDetails.fromJson(jsonResponse);
        print(jsonResponse);
        orderDetailsByIdData = idWiseOrderDetailsData.data!.data!;
        statusCode = orderDetailsByIdData!.status!;
        orderCode = orderDetailsByIdData!.orderCode!;
        total = orderDetailsByIdData!.total!;
        createdTime = orderDetailsByIdData!.updatedAt!;
        statusName = orderDetailsByIdData!.statusName!;
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  changeStatus(status, id) async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });

    var jsonMap = {
      'product_receive_status': int.parse(status),
    };
    String jsonStr = jsonEncode(jsonMap);
    server
        .putRequest(
            endPoint:
                APIList.notificationOrderUpdate! + id.toString() + '/update',
            body: jsonStr)
        .then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response != null && response.statusCode == 200) {
        onInit();
        Get.find<OrderListController>().onInit;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        Get.rawSnackbar(message: 'Please enter valid input');
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  orderStatus(status, id) async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });

    var jsonMap = {
      'status': int.parse(status),
    };
    String jsonStr = jsonEncode(jsonMap);
    server
        .putRequest(
            endPoint:
                APIList.notificationOrderStatus! + id.toString() + '/update',
            body: jsonStr)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        onInit();
        Get.find<OrderListController>().onInit;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        Get.rawSnackbar(message: 'Please enter valid input');
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }
}
