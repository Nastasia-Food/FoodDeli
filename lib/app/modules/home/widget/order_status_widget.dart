import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container orderStatus(status, bgColor, textColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      color: bgColor,
    ),
    alignment: Alignment.center,
    child: Text(
      status.toString(),
      style: TextStyle(
          fontFamily: "Rubik",
          fontSize: 10.sp,
          color: textColor,
          fontWeight: FontWeight.w400),
    ),
  );
}
