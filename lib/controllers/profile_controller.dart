import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/models/profile.dart';
import 'package:food_ex_delivery_app/services/api-list.dart';
import 'package:food_ex_delivery_app/services/server.dart';
import 'package:food_ex_delivery_app/services/user-service.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'global-controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile_Controller extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordCurrentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  String? userID;

  bool profileLoader = true;
  bool commonLoader = false;
  bool loader = false;
  int? totalOrders;
  String? name, email, username, phone, address, image, credit, deposit;

  @override
  void onInit() {
    Get.put(GlobalController()).initController();
    userID = Get.find<GlobalController>().userId;
    getUserProfile(userId: userID!);
    super.onInit();
  }

  getUserProfile({String? userId}) {
    server.getRequest(endPoint: APIList.profile).then((response) {
      if (response != null && response.statusCode == 200) {
        profileLoader = false;
        final jsonResponse = json.decode(response.body);
        var profileData = Profile.fromJson(jsonResponse);
        name = profileData.data!.data!.name;
        email = profileData.data!.data!.email;
        address = profileData.data!.data!.address;
        phone = profileData.data!.data!.phone;
        username = profileData.data!.data!.username;
        image = profileData.data!.data!.image;
        credit = profileData.data!.data!.balance;
        totalOrders = profileData.data!.data!.totalOrders!;
        deposit = profileData.data!.data!.depositAmount!;
        update();
      } else {
        return Container(child: Center(child: CircularProgressIndicator()));
      }
    });
  }

  updateUserProfile(
      {BuildContext? context, required String filepath, type}) async {
    print('email');
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Map<String, String> body = {
      'name': nameController.text,
      'address': addressController.text,
      'email': emailController.text,
      'phone': phoneController.text,
    };

    server
        .multipartRequest(
            endPoint: APIList.profileUpdate,
            body: body,
            filepath: filepath,
            type: type)
        .then((response) {
      print(response);
      if (response != null && response.statusCode == 200) {
        emailController.clear();
        nameController.clear();
        addressController.clear();
        phoneController.clear();
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Fluttertoast.showToast(
            msg: "Profile Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ThemeColors.baseThemeColor,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.back();
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }

  updateUserPassword({BuildContext? context}) async {
    Map body = {
      'password_current': passwordCurrentController.text,
      'password': passwordController.text,
      'password_confirmation': passwordConfirmController.text,
    };
    String jsonBody = json.encode(body);
    print(jsonBody);
    server
        .putRequest(endPoint: APIList.changePassword, body: jsonBody)
        .then((response) {
      final jsonResponse = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        Get.back();
        Get.rawSnackbar(message: 'Successfully Updated Password');
        passwordCurrentController.clear();
        passwordController.clear();
        passwordConfirmController.clear();
      } else if (response != null && response.statusCode == 422) {
        if (jsonResponse['message']['password_current'] != null) {
          Get.rawSnackbar(
              message: jsonResponse['message']['password_current'].toString());
        } else if (jsonResponse['message']['password'] != null) {
          Get.rawSnackbar(
              message: jsonResponse['message']['password'].toString());
        } else if (jsonResponse['message']['password_confirmation'] != null) {
          Get.rawSnackbar(
              message:
                  jsonResponse['message']['password_confirmation'].toString());
        }
      } else {
        Get.rawSnackbar(message: 'Pl ease enter valid input');
      }
    });
  }
}
