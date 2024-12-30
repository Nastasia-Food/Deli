import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/controllers/global-controller.dart';
import 'package:food_ex_delivery_app/controllers/notification_order_controller.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:food_ex_delivery_app/widgets/order%20status%20container.dart';
import 'package:food_ex_delivery_app/widgets/order_list_delivered.dart';
import 'package:food_ex_delivery_app/widgets/order_list_pending.dart';
import 'package:food_ex_delivery_app/widgets/shimmer/home_page_shimmer.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int status = 1;
  final order_Controller = Get.put(OrderListController());
  final settingController = Get.put(GlobalController());

  @override
  void initState() {
    order_Controller.onInit();
    if (mounted) {
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {});
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        order_Controller.onInit();
        _onRefresh();
        if (message.data.isNotEmpty) {
          showOverlayNotification((context) {
            return Card(
              semanticContainer: true,
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: SafeArea(
                child: ListTile(
                  leading: SizedBox.fromSize(
                    size: const Size(40, 40),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(
                          'assets/images/Icon.png',
                          height: 35,
                          width: 35,
                        )),
                  ),
                  title: Text(message.data['title'].toString()),
                  subtitle: Text(message.data['body'].toString()),
                  trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        OverlaySupportEntry.of(context)!.dismiss();
                      }),
                ),
              ),
            );
          });
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    }
    update();
    super.initState();
  }

  update() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var deviceToken = storage.getString('deviceToken');
    settingController.updateFCMToken(deviceToken);
  }

  Future<Null> _onRefresh() {
    setState(() {
      order_Controller.onInit();
    });
    Completer<Null> completer = new Completer<Null>();
    new Timer(new Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);

    return GetBuilder<OrderListController>(
      init: OrderListController(),
      builder: (orders) => orders.loader
          ? HomePageShimmer()
          : Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ThemeColors.baseThemeColor,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  '${settingController.siteName}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              body: RefreshIndicator(
                onRefresh: _onRefresh,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //pending container
                          InkWell(
                            onTap: (() {
                              setState(() {
                                status = 1;
                              });
                            }),
                            child: Order_status_container(
                                text_color: Colors.white,
                                status_numbers:
                                    orders.orderList.length.toString(),
                                bgColor: Colors.red,
                                statusName: "ORDER_NOTIFICATIONS".tr,
                                icon: Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                )),
                          ),

                          InkWell(
                            onTap: (() {
                              setState(() {
                                status = 2;
                              });
                            }),
                            child: Order_status_container(
                                text_color: Colors.white,
                                status_numbers:
                                    orders.orderHistoryList.length.toString(),
                                bgColor: Colors.green,
                                statusName: "ORDERED".tr,
                                icon: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Divider(
                        height: 10,
                        thickness: 0.5,
                      ),
                    ),
                    status_list_view()
                  ],
                ),
              ),
            ),
    );
  }

  status_title(String status) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        status,
        style: TextStyle(
          color: ThemeColors.scaffoldBgColor,
          fontWeight: FontWeight.w700,
          fontSize: FontSize.xLarge,
          //    color: Colors.deepOrange
        ),
      ),
    );
  }

  status_list_view() {
    switch (status) {
      case 1:
        {
          return PendingOrder();
        }
      case 2:
        {
          return Delivered();
        }
      default:
        {
          return PendingOrder();
        }
    }
  }
}
