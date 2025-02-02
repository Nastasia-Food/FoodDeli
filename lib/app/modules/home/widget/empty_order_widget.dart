import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';

class EmptyActiveOrder extends StatelessWidget {
  const EmptyActiveOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.iconEmptyOrder,
              width: 186.w,
              height: 180.h,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "YOU_HAVE_NO_ORDER_FOR_DELIVERY".tr,
              textAlign: TextAlign.center,
              style: fontMedium,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "WAIT_NOTE".tr,
              textAlign: TextAlign.center,
              style: fontRegularPro,
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.iconEmptyOrder,
              width: 186.w,
              height: 180.h,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "YOU_HAVE_NO_ORDER_HISTORY".tr,
              textAlign: TextAlign.center,
              style: fontMedium,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "WAIT_NOTE".tr,
              textAlign: TextAlign.center,
              style: fontRegularPro,
            ),
          ],
        ),
      ),
    );
  }
}
