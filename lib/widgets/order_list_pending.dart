import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/controllers/notification_order_controller.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:food_ex_delivery_app/views/order/notification/no_order_notification_page.dart';
import 'package:food_ex_delivery_app/views/order/order_details.dart';
import 'package:get/get.dart';

class PendingOrder extends StatefulWidget {
  const PendingOrder({Key? key}) : super(key: key);

  @override
  _PendingState createState() => _PendingState();
}

class _PendingState extends State<PendingOrder> {
  String acceptDialogue = "ARE_YOU_SURE_YOU_WANT_TO_ACCEPT_THE_ORDER".tr;
  String cancelDialogue = "ARE_YOU_SURE_YOU_WANT_TO_CANCEL_THE_ORDER".tr;
  String DialogueAccept = "ORDER_ACCEPT?".tr;
  String DialogueCancel = "ORDER_CANCEL?".tr;

  final order_Controller = Get.put(OrderListController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      order_Controller.onInit();
    });
    return GetBuilder<OrderListController>(
      init: OrderListController(),
      builder: (orders) => Expanded(
        child: orders.orderList.isEmpty
            ? NoOrderNotification()
            : ListView.builder(
                itemCount: orders.orderList.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                      width: SizeConfig.screenWidth,
                      //height: SizeConfig.screenHeight!/3.5,
                      child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.access_time),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(orders.orderList[index].timeFormat
                                            .toString()),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(right: 5, left: 5),
                                            height: 30,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                //  elevation: 0.0,
                                                backgroundColor:
                                                    Colors.green, // background
                                                // foreground
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // <-- Radius
                                                ),
                                              ),
                                              onPressed: () async {
                                                setState(() {
                                                  showAlertDialog(
                                                      context,
                                                      DialogueAccept,
                                                      acceptDialogue,
                                                      '5',
                                                      orders.orderList[index].id
                                                          .toString());
                                                  // Get.to(()=>Order_details());
                                                });
                                              },
                                              child: Text(
                                                'ACCEPT'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                //  elevation: 0.0,
                                                backgroundColor:
                                                    Colors.red, // background
                                                foregroundColor:
                                                    Colors.white, // foreground
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // <-- Radius
                                                ),
                                              ),
                                              onPressed: () async {
                                                setState(() {
                                                  showAlertDialog(
                                                      context,
                                                      DialogueCancel,
                                                      cancelDialogue,
                                                      '10',
                                                      orders.orderList[index].id
                                                          .toString());
                                                });
                                              },
                                              child: Text(
                                                'REJECT'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1),
                                  child: Divider(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 5, right: 5),
                                  child: Row(
                                    children: [
                                      //order id
                                      Text(
                                        "ORDER_NO#".tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          //    color: Colors.deepOrange
                                        ),
                                      ),
                                      Text(
                                        orders.orderList[index].orderCode!
                                            .toString(),
                                        style: TextStyle(
                                          color: ThemeColors.scaffoldBgColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSize.xMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    children: [],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "TIME".tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16
                                            // color: Colors.grey
                                            ),
                                      ),
                                      Text(
                                        orders.orderList[index].createdAt
                                            .toString(),
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          //fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontFamily: 'AirbnbCerealBold',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "PAYMENT_MODE".tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,

                                          fontSize: 16,
                                          // color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        orders.orderList[index]
                                            .payment_method_name
                                            .toString(),
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          // fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontFamily: 'AirbnbCerealBold',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                          elevation: 1,
                          // shadowColor: Colors.blueGrey,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(
                              width: 0.05,
                            ),
                          )));
                }),
      ),
    );
  }

  //show alertDialogue

  showAlertDialog(
      BuildContext context, dialogueAccept, String alertMessage, status, id) {
    //  int? oId = int.parse(id);

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        order_Controller.changeStatus(status, id);
        order_Controller.onInit();
        Navigator.of(context).pop();
        Get.to(() => OrderDetailsById(
              orderId: int.parse(id),
            ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(dialogueAccept),
      content: Text(alertMessage),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
