// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../controllers/home_controller.dart';

Alert confirmDeliveryPopUp(context, HomeController homeController) {
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
    desc: "CONFIRM_DELIVERY_ALERT".tr,
    image: Image.asset(
      Images.iconConfirmed,
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
          "YES_CONFIRM".tr,
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
