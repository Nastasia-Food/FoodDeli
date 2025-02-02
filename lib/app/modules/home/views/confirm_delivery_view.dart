import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/home_controller.dart';

class ConfirmDeliveryView extends GetView<HomeController> {
  const ConfirmDeliveryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.iconConfirmed,
              height: 180.h,
              width: 200.w,
            ),
            SizedBox(
              height: 32.h,
            ),
            Text(
              "ORDER_SUCCESSFULLY_DELIVERED".tr,
              style: fontMedium,
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ORDER_ID'.tr,
                  style: fontMediumPro,
                ),
                Text(
                  controller.orderDetailsData.orderSerialNo.toString(),
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.fontSizeLarge.sp,
                      color: AppColor.activeTxtColor),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              controller.orderDetailsData.orderDatetime.toString(),
              style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Colors.grey,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 24.h,
            ),
            ElevatedButton(
              onPressed: () {
                Get.off(const DashboardView());
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColor.primaryColor,
                minimumSize: Size(328.w, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
              ),
              child: Text(
                "BACK_TO_HOME".tr,
                style: fontMedium,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
