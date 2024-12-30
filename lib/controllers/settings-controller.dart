import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/models/settings_model.dart';
import 'package:food_ex_delivery_app/services/api-list.dart';
import 'package:get/get.dart';
import 'package:food_ex_delivery_app/services/server.dart';
import 'package:food_ex_delivery_app/services/user-service.dart';

class SettingsController extends GetxController {
  Server server = Server();
  UserService userService = UserService();

  String? bearerToken;
  bool isUser = false;
  String? userId,
      stripeKey,
      stripeSecret,
      googleMapApiKey,
      currencyCode,
      currencyName,
      siteName,
      siteEmail,
      siteLogo;

  initController() async {
    siteSettings();
  }

  @override
  void onInit() {
    initController();
    super.onInit();
  }

  siteSettings() async {
    server.getRequestSettings(APIList.settings).then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var settingData = SettingData.fromJson(jsonResponse['data']);
        stripeKey = settingData.stripeKey;
        stripeSecret = settingData.stripeSecret;
        googleMapApiKey = settingData.googleMapApiKey;
        currencyCode = settingData.currencyCode;
        currencyName = settingData.currencyName;
        siteName = settingData.siteName;
        siteEmail = settingData.siteEmail;
        siteLogo = settingData.siteLogo;

        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        return Container(child: Center(child: CircularProgressIndicator()));
      }
    });
  }
}
