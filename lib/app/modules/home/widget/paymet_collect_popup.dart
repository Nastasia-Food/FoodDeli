// ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../controllers/home_controller.dart';

Alert collectPaymentPopUp(context, HomeController homeController) {
  return Alert(
    closeIcon: const Text(''),
    style: AlertStyle(
      animationType: AnimationType.grow,
      descStyle: fontMedium,
      descTextAlign: TextAlign.center,
      animationDuration: const Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0.r),
      ),
      alertAlignment: Alignment.center,
    ),
    context: context,
    desc: "DO_YOU_COLLECT_PAYMENT".tr,
    content: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "AMOUNT".tr + " : ",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              fontSize: 22.sp,
            ),
          ),
          Text(
            homeController.orderDetailsData.totalCurrencyPrice.toString(),
            style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                fontSize: 22.sp,
                color: AppColor.delivaryActive),
          ),
        ],
      ),
    ),
    image: Image.asset(
      Images.iconPaymentConfirmed,
      height: 100.h,
      width: 100.w,
    ),
    buttons: [
      DialogButton(
        child: Text(
          "NO_CANCEL".tr,
          style: fontRegularBold,
        ),
        color: AppColor.itembg,
        onPressed: () => Navigator.pop(context),
        radius: BorderRadius.circular(24.0.r),
      ),
      DialogButton(
        child: Text(
          "YES_COLLECT".tr,
          style: fontRegularBoldWhite,
        ),
        color: AppColor.primaryColor,
        onPressed: () {
          homeController
              .confirmOrderDelivery(homeController.orderDetailsData.id!);
        },
        radius: BorderRadius.circular(24.0.r),
      ),
    ],
  );
}
