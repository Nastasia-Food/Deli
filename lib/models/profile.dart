class Profile {
  Profile({
    this.data,
  });

  Profile.fromJson(dynamic json) {
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
  ProfileData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class ProfileData {
  ProfileData({
    this.status,
    this.data,
  });

  ProfileData.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.email,
    this.username,
    this.phone,
    this.address,
    this.name,
    this.status,
    this.applied,
    this.totalOrders,
    this.image,
    this.myRole,
    this.balance,
    this.depositAmount,
    this.limitAmount,
    this.myStatus,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    address = json['address'] == null ? "" : json['address'];
    name = json['name'];
    status = json['status'];
    applied = json['applied'];
    totalOrders = json['totalOrders'];
    image = json['image'];
    myRole = json['myrole'];
    balance = json['balance'];
    depositAmount = json['deposit_amount'];
    limitAmount = json['limit_amount'];
    myStatus = json['mystatus'];
  }
  int? id;
  String? email;
  String? username;
  String? phone;
  dynamic address;
  String? name;
  int? status;
  int? applied;
  int? totalOrders;
  String? image;
  String? myRole;
  String? balance;
  String? depositAmount;
  String? limitAmount;
  String? myStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['username'] = username;
    map['phone'] = phone;
    map['address'] = address;
    map['name'] = name;
    map['status'] = status;
    map['applied'] = applied;
    map['totalOrders'] = totalOrders;
    map['image'] = image;
    map['myrole'] = myRole;
    map['balance'] = balance;
    map['deposit_amount'] = depositAmount;
    map['limit_amount'] = limitAmount;
    map['mystatus'] = myStatus;
    return map;
  }
}
