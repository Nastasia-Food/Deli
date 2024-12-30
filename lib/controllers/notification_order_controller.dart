import 'dart:convert';
import 'package:food_ex_delivery_app/models/notification_order.dart';
import 'package:food_ex_delivery_app/models/notification_order_history.dart';
import 'package:food_ex_delivery_app/services/api-list.dart';
import 'package:food_ex_delivery_app/services/server.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController {
  Server server = Server();
  List<Order> orderList = <Order>[];
  List<OrderHistoryData> orderHistoryList = <OrderHistoryData>[];
  int? len, orderListLen;
  bool loader = true;
  @override
  void onInit() {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    getAllOrders();
    getAllOrdersHistory();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllOrders() async {
    orderList.clear();
    server.getRequest(endPoint: APIList.notificationOrder).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        var orderListData = NotificationOrder.fromJson(jsonResponse);
        orderList = <Order>[];
        print(orderListData);
        orderList.addAll(orderListData.data!);
        orderListLen = orderList.length;
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

  getAllOrdersHistory() async {
    orderHistoryList.clear();
    server
        .getRequest(endPoint: APIList.notificationOrderHistory)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var orderHistoryListData =
            NotificationOrderHistory.fromJson(jsonResponse);

        orderHistoryList = <OrderHistoryData>[];
        print(orderHistoryListData);
        orderHistoryList.addAll(orderHistoryListData.data!);
        len = orderHistoryList.length;
        print(len);

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
      'status': int.parse(status),
    };
    String jsonStr = jsonEncode(jsonMap);
    server
        .putRequest(
            endPoint: APIList.notificationOrderUpdateById! + id + '/update',
            body: jsonStr)
        .then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response != null && response.statusCode == 200) {
        onInit();
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
