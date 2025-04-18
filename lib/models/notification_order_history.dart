// To parse this JSON data, do
//

import 'dart:convert';

NotificationOrderHistory notificationOrderHistoryFromJson(String str) =>
    NotificationOrderHistory.fromJson(json.decode(str));
String notificationOrderHistoryToJson(NotificationOrderHistory data) =>
    json.encode(data.toJson());

class NotificationOrderHistory {
  NotificationOrderHistory({
    this.status,
    this.data,
  });

  int? status;
  List<OrderHistoryData>? data;

  factory NotificationOrderHistory.fromJson(Map<String, dynamic> json) =>
      NotificationOrderHistory(
        status: json["status"],
        data: List<OrderHistoryData>.from(
            json["data"].map((x) => OrderHistoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OrderHistoryData {
  OrderHistoryData(
      {this.id,
      this.userId,
      this.orderCode,
      this.total,
      this.subTotal,
      this.deliveryCharge,
      this.status,
      this.statusName,
      this.paymentStatus,
      this.paymentMethodName,
      this.paidAmount,
      this.address,
      this.mobile,
      this.lat,
      this.long,
      this.misc,
      this.paymentMethod,
      this.invoiceId,
      this.deliveryBoyId,
      this.shopId,
      this.productReceived,
      this.createdAt,
      this.updatedAt,
      this.customer,
      this.restaurant,
      this.timeFormat});

  int? id;
  int? userId;
  String? orderCode;
  String? total;
  String? subTotal;
  String? deliveryCharge;
  int? status;
  String? statusName;
  int? paymentStatus;
  String? paymentMethodName;
  String? paidAmount;
  String? address;
  String? mobile;
  String? lat;
  String? long;
  String? misc;
  int? paymentMethod;
  String? invoiceId;
  int? deliveryBoyId;
  dynamic shopId;
  int? productReceived;
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  Restaurant? restaurant;
  String? timeFormat;

  factory OrderHistoryData.fromJson(Map<String, dynamic> json) =>
      OrderHistoryData(
        id: json["id"],
        userId: json["user_id"],
        orderCode: json["order_code"],
        total: json["total"],
        subTotal: json["sub_total"],
        deliveryCharge: json["delivery_charge"],
        status: json["status"],
        statusName: json["status_name"],
        paymentStatus: json["payment_status"],
        paymentMethodName: json["payment_method_name"],
        paidAmount: json["paid_amount"],
        address: json["address"],
        mobile: json["mobile"],
        timeFormat: json["time_format"],
        lat: json["lat"],
        long: json["long"],
        misc: json["misc"],
        paymentMethod: json["payment_method"],
        invoiceId: json["invoice_id"],
        deliveryBoyId: json["delivery_boy_id"],
        shopId: json["shop_id"],
        productReceived: json["product_received"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        customer: Customer.fromJson(json["customer"]),
        restaurant: Restaurant.fromJson(json["restaurant"]),
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
        "payment_method_name": paymentMethodName,
        "paid_amount": paidAmount,
        "address": address,
        "mobile": mobile,
        "time_format": timeFormat,
        "lat": lat,
        "long": long,
        "misc": misc,
        "payment_method": paymentMethod,
        "invoice_id": invoiceId,
        "delivery_boy_id": deliveryBoyId,
        "shop_id": shopId,
        "product_received": productReceived,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "customer": customer!.toJson(),
        "restaurant": restaurant!.toJson(),
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.username,
    this.balance,
    this.status,
    this.applied,
    this.image,
  });

  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  String? address;
  String? username;
  String? balance;
  int? status;
  int? applied;
  dynamic image;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        username: json["username"],
        balance: json["balance"],
        status: json["status"],
        applied: json["applied"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "address": address,
        "username": username,
        "balance": balance,
        "status": status,
        "applied": applied,
        "image": image,
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.userId,
    this.description,
    this.deliveryCharge,
    this.lat,
    this.long,
    this.openingTime,
    this.closingTime,
    this.address,
    this.status,
    this.currentStatus,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.cuisines,
  });

  int? id;
  String? name;
  int? userId;
  String? description;
  String? deliveryCharge;
  String? lat;
  String? long;
  String? openingTime;
  String? closingTime;
  String? address;
  String? status;
  String? currentStatus;
  String? createdAt;
  String? updatedAt;
  String? image;
  List<dynamic>? cuisines;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"],
        description: json["description"],
        deliveryCharge: json["delivery_charge"].toString(),
        lat: json["lat"],
        long: json["long"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        address: json["address"],
        status: json["status"],
        currentStatus: json["current_status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        image: json["image"],
        cuisines: List<dynamic>.from(json["cuisines"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "description": description,
        "delivery_charge": deliveryCharge,
        "lat": lat,
        "long": long,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "address": address,
        "status": status,
        "current_status": currentStatus,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "image": image,
        "cuisines": List<dynamic>.from(cuisines!.map((x) => x)),
      };
}
