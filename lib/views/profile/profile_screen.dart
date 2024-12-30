import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_ex_delivery_app/controllers/global-controller.dart';
import 'package:food_ex_delivery_app/controllers/profile_controller.dart';
import 'package:food_ex_delivery_app/utils/images.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:food_ex_delivery_app/views/profile/edit_profile_page.dart';
import 'package:food_ex_delivery_app/widgets/profile_shimmer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'change_language_page.dart';
import 'edit_password_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final profileController = Get.put(Profile_Controller());
  var mainHeight, mainWidth;
  String? phone, name, address, image;

  @override
  void initState() {
    profileController.onInit();
    setState(() {
      phone = profileController.phone;
      name = profileController.name;
      address = profileController.address;
      image = profileController.image;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalController globalController = GlobalController();
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    getProfileValue();
    return GetBuilder<Profile_Controller>(
      init: Profile_Controller(),
      builder: (profile) => Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.baseThemeColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text('PROFILE'.tr),
          actions: [
            GestureDetector(
              onTap: () {
                globalController.userLogout();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10,left: 10),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: profile.profileLoader
            ? ProfileShimmer()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: CustomPaint(
                            painter: HeaderCurvedContainer(),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            CachedNetworkImage(
                              imageUrl: profile.image!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                padding: EdgeInsets.all(10.0),
                                width: mainWidth / 3,
                                height: mainWidth / 3,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 5),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageProvider,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Shimmer.fromColors(
                                child: CircleAvatar(radius: 50),
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: mainHeight / 10,
                                  width: mainWidth / 2.5,
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'CREDIT'.tr,
                                                style: TextStyle(
                                                  letterSpacing: .5,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Icon(
                                                Icons.arrow_circle_up,
                                                color:
                                                    ThemeColors.baseThemeColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${profile.credit}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: ThemeColors.baseThemeColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  height: mainHeight / 10,
                                  width: mainWidth / 2.5,
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'ORDERS'.tr,
                                                style: TextStyle(
                                                  letterSpacing: .5,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.arrow_circle_up,
                                                color:
                                                    ThemeColors.baseThemeColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${profile.totalOrders}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: ThemeColors.baseThemeColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              //margin: EdgeInsets.symmetric(vertical: 20),
                              height: mainHeight / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red.withOpacity(.0),
                                image: DecorationImage(
                                  image: AssetImage(Images.profileBackground),
                                  fit: BoxFit.cover,
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.1),
                                      BlendMode.dstATop),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                      height: 40,
                                      child: ListTile(
                                        leading: Icon(
                                          FontAwesomeIcons.userTie,
                                          color: ThemeColors.baseThemeColor,
                                          size: 26,
                                        ),
                                        title: Text(
                                          "${profile.name}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    profile.address == null
                                        ? Container()
                                        : Container(
                                            height: 40,
                                            child: ListTile(
                                              leading: Icon(
                                                FontAwesomeIcons.streetView,
                                                color:
                                                    ThemeColors.baseThemeColor,
                                                size: 20,
                                              ),
                                              title: Text(
                                                '${profile.address}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                            ),
                                          ),
                                    Container(
                                      height: 40,
                                      child: ListTile(
                                        leading: Icon(
                                          FontAwesomeIcons.phoneAlt,
                                          color: ThemeColors.baseThemeColor,
                                          size: 20,
                                        ),
                                        title: Text(
                                          "${profile.phone}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      child: ListTile(
                                        leading: Icon(
                                          FontAwesomeIcons.wallet,
                                          color: ThemeColors.baseThemeColor,
                                          size: 20,
                                        ),
                                        title: Text(
                                          "CREDIT:".tr + " ${profile.credit}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        height: 40,
                                        child: ListTile(
                                          leading: Icon(
                                            FontAwesomeIcons.userEdit,
                                            color: ThemeColors.baseThemeColor,
                                            size: 20,
                                          ),
                                          title: Text('EDIT_PROFILE'.tr,
                                              style: TextStyle(
                                                  color: ThemeColors
                                                      .baseThemeColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400)),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              color:
                                                  ThemeColors.baseThemeColor),
                                        ),
                                      ),
                                      onTap: () {
                                        Get.to(() => EditProfilePage())?.then(
                                            (_) => profileController
                                                .getUserProfile());
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        height: 40,
                                        child: ListTile(
                                          leading: Icon(
                                            FontAwesomeIcons.key,
                                            color: ThemeColors.baseThemeColor,
                                            size: 20,
                                          ),
                                          title: Text('CHANGE_PASSWORD'.tr,
                                              style: TextStyle(
                                                  color: ThemeColors
                                                      .baseThemeColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400)),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              color:
                                                  ThemeColors.baseThemeColor),
                                        ),
                                      ),
                                      onTap: () {
                                        Get.to(() => EditPasswordPage())?.then(
                                            (_) => profileController
                                                .getUserProfile());
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        height: 40,
                                        child: ListTile(
                                          leading: Icon(
                                            FontAwesomeIcons.language,
                                            color: ThemeColors.baseThemeColor,
                                            size: 20,
                                          ),
                                          title: Text('CHANGE_LANGUAGE'.tr,
                                              style: TextStyle(
                                                  color: ThemeColors
                                                      .baseThemeColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400)),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              color:
                                                  ThemeColors.baseThemeColor),
                                        ),
                                      ),
                                      onTap: () {
                                        Get.to(() => ChangeLanguagePage());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  getProfileValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  void getProfile() {}
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = ThemeColors.baseThemeColor;
    Path path = Path()
      ..relativeLineTo(0, 115)
      ..quadraticBezierTo(size.width / 2, 250, size.width, 115)
      ..relativeLineTo(0, -115)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  getProfileValue() async {}
}
