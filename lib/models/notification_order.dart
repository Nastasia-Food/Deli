// To parse this JSON data, do

import 'dart:convert';

NotificationOrder notificationOrderFromJson(String str) =>
    NotificationOrder.fromJson(json.decode(str));

String notificationOrderToJson(NotificationOrder data) =>
    json.encode(data.toJson());

class NotificationOrder {
  NotificationOrder({
    this.status,
    this.data,
  });

  int? status;
  List<Order>? data;

  factory NotificationOrder.fromJson(Map<String, dynamic> json) =>
      NotificationOrder(
        status: json["status"],
        data: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Order {
  Order(
      {this.id,
      this.userId,
      this.orderCode,
      this.total,
      this.subTotal,
      this.deliveryCharge,
      this.status,
      this.statusName,
      this.paymentStatus,
      this.paidAmount,
      this.address,
      this.mobile,
      this.lat,
      this.long,
      this.misc,
      this.paymentMethod,
      this.createdAt,
      this.updatedAt,
      this.invoiceId,
      this.shopId,
      this.deliveryBoyId,
      this.productReceived,
      this.timeFormat,
      this.date,
      this.payment_method_name});

  int? id;
  int? userId;
  String? orderCode;
  String? total;
  String? subTotal;
  String? deliveryCharge;
  int? status;
  String? statusName;
  int? paymentStatus;
  String? paidAmount;
  String? address;
  String? mobile;
  String? lat;
  String? long;
  String? misc;
  int? paymentMethod;
  String? createdAt;
  String? updatedAt;
  String? invoiceId;
  dynamic shopId;
  dynamic deliveryBoyId;
  int? productReceived;
  String? timeFormat;
  String? date;
  String? payment_method_name;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        orderCode: json["order_code"].toString(),
        total: json["total"],
        subTotal: json["sub_total"],
        deliveryCharge: json["delivery_charge"],
        status: json["status"],
        statusName: json["status_name"],
        paymentStatus: json["payment_status"],
        paidAmount: json["paid_amount"],
        address: json["address"],
        mobile: json["mobile"],
        lat: json["lat"],
        long: json["long"],
        misc: json["misc"],
        paymentMethod: json["payment_method"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        invoiceId: json["invoice_id"],
        shopId: json["shop_id"],
        deliveryBoyId: json["delivery_boy_id"],
        productReceived: json["product_received"],
        timeFormat: json["time_format"],
        date: json["date"],
        payment_method_name: json["payment_method_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_code": orderCode,
        "total": total,
        "sub_total": subTotal,
        "delivery_charge": deliveryCharge,
        "status": status,
        "status_name": statusName,
        "payment_status": paymentStatus,
        "paid_amount": paidAmount,
        "address": address,
        "mobile": mobile,
        "lat": lat,
        "long": long,
        "misc": misc,
        "payment_method": paymentMethod,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "invoice_id": invoiceId,
        "shop_id": shopId,
        "delivery_boy_id": deliveryBoyId,
        "product_received": productReceived,
        "time_format": timeFormat,
        "date": date,
        "payment_method_name": payment_method_name,
      };
}
