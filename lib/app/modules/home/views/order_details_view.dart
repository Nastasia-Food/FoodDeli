// ignore_for_file: sort_child_properties_last, must_be_immutable, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking_delivery_boy/app/modules/home/controllers/location_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/loader.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/home_controller.dart';
import '../widget/confirm_delivery_popup.dart';
import '../widget/location_permission_alert.dart';
import '../widget/order_status_widget.dart';
import '../widget/paymet_collect_popup.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({super.key});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  bool isOrderRejected = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: -5,
              title: Text(
                'ORDER_DETAILS'.tr,
                style: TextStyle(
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              ),
              centerTitle: false,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: SvgPicture.asset(Images.back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: Stack(
              children: [
                RefreshIndicator(
                  color: AppColor.primaryColor,
                  onRefresh: () async {
                    homeController
                        .getOrderDetails(homeController.orderDetailsData.id!);
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              headerSection(),
                              homeController.orderDetailsData.status != 13
                                  ? estimatedTime()
                                  : const SizedBox(),
                              customerInformationSection(),
                              paymentInfo(),
                              addressSection(),
                              orderSummary(),
                              SizedBox(
                                height: 120.h,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                homeController.orderDetailsData.status == 13 ||
                        homeController.orderDetailsData.status == 22
                    ? const SizedBox.expand()
                    : Positioned(
                        bottom: 0.h,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.itembg.withOpacity(1),
                                offset: const Offset(
                                  6.0,
                                  0.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 3,
                              ), //BoxShadow
                              //BoxShadow
                            ],
                          ),
                          child: SizedBox(
                            width: Get.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.h, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.find<LocationController>()
                                          .getCurrentLocation();
                                      _checkPermission(() async {
                                        if (await MapLauncher.isMapAvailable(
                                                MapType.google) !=
                                            null) {
                                          MapLauncher.showDirections(
                                              mapType: MapType.google,
                                              destination: Coords(
                                                  double.parse(homeController
                                                      .orderDetailsData
                                                      .orderAddress!
                                                      .latitude!),
                                                  double.parse(homeController
                                                      .orderDetailsData
                                                      .orderAddress!
                                                      .longitude!)));
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: AppColor.primaryColor,
                                      minimumSize: Size(Get.width, 48.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(26.r),
                                      ),
                                    ),
                                    child: Text(
                                      "GET_DIRECTION".tr,
                                      style: fontMedium,
                                    ),
                                  ),
                                  homeController.orderDetailsData.status == 10
                                      ? Padding(
                                          padding: EdgeInsets.only(top: 8.h),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (homeController
                                                      .orderDetailsData
                                                      .paymentStatus ==
                                                  10) {
                                                collectPaymentPopUp(
                                                        context, homeController)
                                                    .show();
                                              }
                                              if (homeController
                                                      .orderDetailsData
                                                      .paymentStatus ==
                                                  5) {
                                                confirmDeliveryPopUp(
                                                        context, homeController)
                                                    .show();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.green,
                                              minimumSize:
                                                  Size(Get.width, 48.h),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(26.r),
                                              ),
                                            ),
                                            child: Text(
                                              "CONFIRM_DELIVERY".tr,
                                              style: fontMedium,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          homeController.orderConfirmLoader
              ? Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white60,
                    child: const Center(
                      child: LoaderCircle(),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
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

Widget orderSummary() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.itembg,
            offset: const Offset(
              0.0,
              0.0,
            ),
            blurRadius: 5.0.r,
            spreadRadius: 1.0.r,
          ),
          //BoxShadow
          //BoxShadow
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "ORDER_DETAILS".tr,
              style: fontMedium,
            ),
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: homeController.orderDetailsData.orderItems!.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 65.h,
                      child: Row(children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.w, right: 8.w),
                              child: SizedBox(
                                width: 70.w,
                                height: 70.h,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                  child: CachedNetworkImage(
                                    imageUrl: homeController.orderDetailsData
                                        .orderItems![index].itemImage!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      child: Container(
                                          height: 130,
                                          width: 200,
                                          color: Colors.grey),
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[400]!,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 22.h,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(20.r), //or 15.0
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
                                  color: AppColor.fontColor,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      homeController.orderDetailsData
                                          .orderItems![index].quantity!
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                          height: 70.h,
                          width: 200.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeController.orderDetailsData
                                    .orderItems![index].itemName!,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              homeController.orderDetailsData.orderItems![index]
                                          .itemVariations !=
                                      null
                                  ? SizedBox(
                                      width: 240.w,
                                      height: 20.h,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: homeController
                                            .orderDetailsData
                                            .orderItems![index]
                                            .itemVariations!
                                            .length,
                                        itemBuilder: (BuildContext context, i) {
                                          return Text(
                                            index ==
                                                    homeController
                                                            .orderDetailsData
                                                            .orderItems![index]
                                                            .itemVariations!
                                                            .length -
                                                        1
                                                ? "${homeController.orderDetailsData.orderItems![index].itemVariations![i].variationName} : ${homeController.orderDetailsData.orderItems![index].itemVariations![i].name}."
                                                : "${homeController.orderDetailsData.orderItems![index].itemVariations![i].variationName} : ${homeController.orderDetailsData.orderItems![index].itemVariations![i].name}, ",
                                            style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.gray),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          );
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                homeController
                                    .orderDetailsData.orderItems![index].price!
                                    .toString(),
                                style: fontMediumPro,
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: orderDetailsVariationSection(index),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: orderItemInstructionSection(index),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 12.w, right: 12.w, top: 16.h, bottom: 12.h),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColor.itembg)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Row(
                      children: [
                        Text(
                          'SUBTOTAL'.tr,
                          style: fontRegularLite,
                        ),
                        const Spacer(),
                        Text(
                          homeController.orderDetailsData.subtotalCurrencyPrice
                              .toString(),
                          style: fontRegularLite,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Row(
                      children: [
                        Text(
                          'DISCOUNT'.tr,
                          style: fontRegularLite,
                        ),
                        const Spacer(),
                        Text(
                          homeController.orderDetailsData.discountCurrencyPrice
                              .toString(),
                          style: fontRegularLite,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Row(
                      children: [
                        Text(
                          'DELIVERY_CHARGE'.tr,
                          style: fontRegularLite,
                        ),
                        const Spacer(),
                        Text(
                          homeController
                              .orderDetailsData.deliveryChargeCurrencyPrice
                              .toString(),
                          style: fontRegularBoldGreen,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                    maxLines: 1,
                    style: TextStyle(
                        color: AppColor.gray.withOpacity(0.2),
                        overflow: TextOverflow.fade),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Row(
                      children: [
                        Text(
                          'TOTAL'.tr,
                          style: fontRegularBold,
                        ),
                        const Spacer(),
                        Text(
                          homeController.orderDetailsData.totalCurrencyPrice
                              .toString(),
                          style: fontRegularBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget estimatedTime() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "YOUR_ESTIMATE_DELIVERY_TIME".tr,
              style: fontRegular,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${homeController.orderDetailsData.preparationTime}min",
              style: fontBold,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget headerSection() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'ORDER_ID'.tr,
              style: fontMedium,
            ),
            Text(
              homeController.orderDetailsData.orderSerialNo.toString(),
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.fontSizeLarge.sp,
                  color: AppColor.activeTxtColor),
            ),
            SizedBox(
              width: 10.h,
            ),
            if (homeController.orderDetailsData.status == 1)
              orderStatus(homeController.orderDetailsData.statusName,
                  AppColor.pending, AppColor.pendingText),
            if (homeController.orderDetailsData.status == 4)
              orderStatus(homeController.orderDetailsData.statusName,
                  AppColor.preparing, AppColor.preparingText),
            if (homeController.orderDetailsData.status == 7)
              orderStatus(homeController.orderDetailsData.statusName,
                  AppColor.preparing, AppColor.preparingText),
            if (homeController.orderDetailsData.status == 10)
              orderStatus(homeController.orderDetailsData.statusName,
                  AppColor.preparing, AppColor.preparingText),
            if (homeController.orderDetailsData.status == 13)
              orderStatus(homeController.orderDetailsData.statusName,
                  AppColor.preparing, AppColor.preparingText),
            if (homeController.orderDetailsData.status == 14)
              orderStatus(homeController.orderDetailsData.statusName,
                  AppColor.canceled, AppColor.error),
            if (homeController.orderDetailsData.status == 19)
              orderStatus(homeController.orderDetailsData.statusName,
                  AppColor.canceled, AppColor.error),
            if (homeController.orderDetailsData.status == 22)
              orderStatus(homeController.orderDetailsData.statusName,
                  AppColor.canceled, AppColor.error),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          homeController.orderDetailsData.orderDatetime.toString(),
          style: TextStyle(
              color: Colors.grey, fontSize: 13.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 32.h,
        ),
      ],
    ),
  );
}

Widget customerInformationSection() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50.r)),
                    child: CachedNetworkImage(
                      imageUrl: homeController.orderDetailsData.user!.image!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            // colorFilter: ColorFilter.mode(
                            //     Colors.red, BlendMode.colorBurn),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        child: Container(
                            height: 86.h, width: 154.w, color: Colors.grey),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[400]!,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CUSTOMER".tr,
                      style: fontRegular,
                    ),
                    Text(
                      homeController.orderDetailsData.user!.name.toString(),
                      style: fontMedium,
                    )
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final call = Uri.parse(
                  'tel:${Get.find<SplashController>().countryInfoData.callingCode! + homeController.orderDetailsData.user!.phone.toString()}');
              if (await canLaunchUrl(call)) {
                launchUrl(call);
              } else {
                throw 'Could not launch $call';
              }
            },
            child: Container(
              width: 45.w,
              height: 45.r,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.r)),
                color: AppColor.viewAllbg,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                Images.iconCall,
                height: 25.h,
                width: 25.w,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget paymentInfo() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PAYMENT_INFO'.tr,
            style: fontMedium,
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Text(
                'METHOD'.tr + " : ",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              if (homeController.orderDetailsData.orderType == 5 &&
                  homeController.orderDetailsData.transaction == null)
                Text(
                  "CASH_ON_DELIVERY".tr,
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (homeController.orderDetailsData.orderType == 10 &&
                  homeController.orderDetailsData.transaction == null)
                Text(
                  "PICK_PAY".tr,
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (homeController.orderDetailsData.transaction != null)
                Text(
                  homeController.orderDetailsData.transaction!.paymentMethod
                      .toString(),
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Text(
                'STATUS'.tr + " : ",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              if (homeController.orderDetailsData.paymentStatus == 5)
                Text(
                  'PAID'.tr,
                  style: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.success),
                ),
              if (homeController.orderDetailsData.paymentStatus == 10)
                Text(
                  'UNPAID'.tr,
                  style: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.error),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget addressSection() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DELIVERY_ADDRESS'.tr,
            style: fontMedium,
          ),
          SizedBox(
            height: 6.h,
          ),
          Row(
            children: [
              SvgPicture.asset(
                Images.iconLocation,
                height: 15.h,
                width: 15.w,
                color: AppColor.primaryColor,
              ),
              SizedBox(
                width: 10.w,
              ),
              Flexible(
                child: Text(
                  homeController.orderDetailsData.orderAddress!.apartment
                          .toString() +
                      "," +
                      " " +
                      homeController.orderDetailsData.orderAddress!.address
                          .toString(),
                  style: fontRegular,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget orderDetailsVariationSection(int i) {
  final homeController = Get.find<HomeController>();
  return Padding(
    padding: EdgeInsets.only(
      top: 8.h,
    ),
    child: Column(
      children: [
        homeController.orderDetailsData.orderItems![i].itemExtras != null &&
                homeController
                    .orderDetailsData.orderItems![i].itemExtras!.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(bottom: 4.h, right: 8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EXTRAS".tr + " : ",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 240.w,
                      height: 20.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: homeController
                            .orderDetailsData.orderItems![i].itemExtras!.length,
                        itemBuilder: (BuildContext context, index) {
                          return Text(
                            index ==
                                    homeController.orderDetailsData
                                            .orderItems![i].itemExtras!.length -
                                        1
                                ? "${homeController.orderDetailsData.orderItems![i].itemExtras![index].name}."
                                : "${homeController.orderDetailsData.orderItems![i].itemExtras![index].name},",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.gray),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}

Widget orderItemInstructionSection(int i) {
  final homeController = Get.find<HomeController>();
  return Column(
    children: [
      homeController.orderDetailsData.orderItems![i].instruction != null &&
              homeController
                  .orderDetailsData.orderItems![i].instruction!.isNotEmpty
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "INSTRUCTION".tr + ' : ',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: Get.width - 140,
                  child: Text(
                      homeController.orderDetailsData.orderItems![i].instruction
                          .toString(),
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.gray)),
                )
              ],
            )
          : const SizedBox.shrink(),
    ],
  );
}
