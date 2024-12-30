class Setting {
  Setting({
    this.status,
    this.data,
  });

  Setting.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? SettingData.fromJson(json['data']) : null;
  }
  int? status;
  SettingData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class SettingData {
  SettingData({
    this.siteName,
    this.siteEmail,
    this.sitePhoneNumber,
    this.siteDescription,
    this.stripeKey,
    this.stripeSecret,
    this.googleMapApiKey,
    this.currencyName,
    this.currencyCode,
    this.siteLogo,
    this.delivery_app_name,
    this.delivery_app_logo,
    this.support_phone,
  });

  SettingData.fromJson(dynamic json) {
    siteName = json['site_name'];
    siteEmail = json['site_email'];
    sitePhoneNumber = json['site_phone_number'];
    siteDescription = json['site_description'];
    stripeKey = json['stripe_key'];
    stripeSecret = json['stripe_secret'];
    googleMapApiKey = json['google_map_api_key'];
    currencyName = json['currency_name'];
    currencyCode = json['currency_code'];
    siteLogo = json['site_logo'];
    delivery_app_name = json['delivery_app_name'];
    delivery_app_logo = json['delivery_app_logo'];
    support_phone = json['support_phone'];
  }
  String? siteName;
  String? siteEmail;
  String? sitePhoneNumber;
  String? siteDescription;
  String? stripeKey;
  String? stripeSecret;
  String? googleMapApiKey;
  String? currencyName;
  String? currencyCode;
  String? siteLogo;
  String? delivery_app_name;
  String? delivery_app_logo;
  String? support_phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['site_name'] = siteName;
    map['site_email'] = siteEmail;
    map['site_phone_number'] = sitePhoneNumber;
    map['site_description'] = siteDescription;
    map['stripe_key'] = stripeKey;
    map['stripe_secret'] = stripeSecret;
    map['google_map_api_key'] = googleMapApiKey;
    map['currency_name'] = currencyName;
    map['currency_code'] = currencyCode;
    map['site_logo'] = siteLogo;
    map['delivery_app_name'] = delivery_app_name;
    map['delivery_app_logo'] = delivery_app_logo;
    map['support_phone'] = support_phone;
    return map;
  }
}
