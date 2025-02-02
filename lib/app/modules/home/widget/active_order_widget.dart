// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../controllers/home_controller.dart';
import '../controllers/location_controller.dart';
import 'empty_order_widget.dart';
import 'location_permission_alert.dart';
import 'order_status_widget.dart';

class ActiveOrder extends StatefulWidget {
  const ActiveOrder({
    super.key,
  });

  @override
  State<ActiveOrder> createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ACTIVE_ORDERS".tr,
            style: fontMedium,
          ),
          homeController.activeOrderList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: homeController.activeOrderList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(children: [
                        InkWell(
                          child: Container(
                            height: 156.h,
                            width: 328.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.itembg.withOpacity(0.8),
                                  offset: const Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 15.0,
                                  spreadRadius: 0.5,
                                ), //BoxShadow
                                //BoxShadow
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "ORDER_ID".tr,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Rubik"),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          homeController.activeOrderList[index]
                                              .orderSerialNo
                                              .toString(),
                                          style: fontRegularBold,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        if (homeController
                                                .activeOrderList[index]
                                                .status ==
                                            1)
                                          orderStatus(
                                              homeController
                                                  .activeOrderList[index]
                                                  .statusName,
                                              AppColor.pending,
                                              AppColor.pendingText),
                                        if (homeController
                                                .activeOrderList[index]
                                                .status ==
                                            4)
                                          orderStatus(
                                              homeController
                                                  .activeOrderList[index]
                                                  .statusName,
                                              AppColor.preparing,
                                              AppColor.preparingText),
                                        if (homeController
                                                .activeOrderList[index]
                                                .status ==
                                            7)
                                          orderStatus(
                                              homeController
                                                  .activeOrderList[index]
                                                  .statusName,
                                              AppColor.preparing,
                                              AppColor.preparingText),
                                        if (homeController
                                                .activeOrderList[index]
                                                .status ==
                                            10)
                                          orderStatus(
                                              homeController
                                                  .activeOrderList[index]
                                                  .statusName,
                                              AppColor.ontheway,
                                              AppColor.darkBlue),
                                        if (homeController
                                                .activeOrderList[index]
                                                .status ==
                                            13)
                                          orderStatus(
                                              homeController
                                                  .activeOrderList[index]
                                                  .statusName,
                                              AppColor.preparing,
                                              AppColor.preparingText),
                                        if (homeController
                                                .activeOrderList[index]
                                                .status ==
                                            14)
                                          orderStatus(
                                              homeController
                                                  .activeOrderList[index]
                                                  .statusName,
                                              AppColor.canceled,
                                              AppColor.error),
                                        if (homeController
                                                .activeOrderList[index]
                                                .status ==
                                            19)
                                          orderStatus(
                                              homeController
                                                  .activeOrderList[index]
                                                  .statusName,
                                              AppColor.canceled,
                                              AppColor.error),
                                        if (homeController
                                                .activeOrderList[index]
                                                .status ==
                                            22)
                                          orderStatus(
                                              homeController
                                                  .activeOrderList[index]
                                                  .statusName,
                                              AppColor.canceled,
                                              AppColor.error),
                                      ],
                                    ),
                                    Text(
                                      homeController.activeOrderList[index]
                                          .orderDatetime!,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          Images.iconLocation,
                                          width: 18.w,
                                          height: 18.h,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        SizedBox(
                                          width: 270,
                                          child: Text(
                                            homeController
                                                .activeOrderList[index]
                                                .orderAddress!
                                                .address!,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              homeController.getOrderDetails(
                                                  homeController
                                                      .activeOrderList[index]
                                                      .id!);
                                            },
                                            child: Container(
                                              height: 36.h,
                                              width: 140.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: AppColor.itembg,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "SEE_DETAILS".tr,
                                                  style: fontRegularBold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.find<LocationController>()
                                                  .getCurrentLocation();
                                              _checkPermission(() async {
                                                if (await MapLauncher
                                                        .isMapAvailable(
                                                            MapType.google) !=
                                                    null) {
                                                  MapLauncher.showDirections(
                                                      mapType: MapType.google,
                                                      destination: Coords(
                                                          double.parse(
                                                              homeController
                                                                  .activeOrderList[
                                                                      index]
                                                                  .orderAddress!
                                                                  .latitude
                                                                  .toString()),
                                                          double.parse(
                                                              homeController
                                                                  .activeOrderList[
                                                                      index]
                                                                  .orderAddress!
                                                                  .longitude
                                                                  .toString())));
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 36.h,
                                              width: 140.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: AppColor.primaryColor),
                                              child: Center(
                                                child: Text(
                                                  "GET_DIRECTION".tr,
                                                  style: fontRegularBoldWhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ),
                      ]),
                    );
                  },
                )
              : const EmptyActiveOrder()
        ],
      ),
    );
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      customSnackbar("ERROR".tr, "LOCATION_SERVICE_DENIED".tr, AppColor.error);
    } else if (permission == LocationPermission.deniedForever) {
      permissionAlert(context).show();
    } else {
      onTap();
    }
  }
}
