// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widgets/loader.dart';
import '../controllers/profile_controller.dart';

class ChangePasswordView extends GetView<ProfileController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: SvgPicture.asset(Images.back),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHANGE_PASSWORD'.tr,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Obx(() {
                    return Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'OLD_PASSWORD'.tr,
                              style: fontProfileLite,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.r),
                              child: TextFormField(
                                controller: controller.oldPasswordController,
                                obscureText: controller.passwordVisible.value,
                                validator: (value) => value!.isEmpty
                                    ? 'PLEASE_TYPE_OLD_PASSWORD'.tr
                                    : null,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.passwordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColor.gray,
                                    ),
                                    onPressed: () {
                                      controller.passwordVisible.value =
                                          !controller.passwordVisible.value;
                                    },
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                      width: 1.w,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                      width: 1.w,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  fillColor: Colors.red,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r)),
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor,
                                        width: 1.w),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.r),
                                    ),
                                    borderSide: BorderSide(
                                        width: 1.w,
                                        color: AppColor.dividerColor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              'NEW_PASSWORD'.tr,
                              style: fontProfileLite,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.0.r),
                              child: TextFormField(
                                obscureText:
                                    controller.newPasswordVisible.value,
                                controller: controller.newPasswordController,
                                validator: (value) => value!.isEmpty
                                    ? 'PLEASE_TYPE_NEW_PASSWORD'.tr
                                    : null,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.newPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColor.gray,
                                    ),
                                    onPressed: () {
                                      controller.newPasswordVisible.value =
                                          !controller.newPasswordVisible.value;
                                    },
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                      width: 1.w,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                      width: 1.w,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  fillColor: Colors.red,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r)),
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor,
                                        width: 1.w),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.r),
                                    ),
                                    borderSide: BorderSide(
                                        width: 1.w,
                                        color: AppColor.dividerColor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              'RETYPE_NEW_PASSWORD'.tr,
                              style: fontProfileLite,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.r),
                              child: TextFormField(
                                obscureText:
                                    controller.retypePasswordVisible.value,
                                controller: controller.retypePasswordController,
                                validator: (value) => value!.isEmpty
                                    ? 'PLEASE_RETYPE_PASSWORD'.tr
                                    : null,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.retypePasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColor.gray,
                                    ),
                                    onPressed: () {
                                      controller.retypePasswordVisible.value =
                                          !controller
                                              .retypePasswordVisible.value;
                                    },
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                      width: 1.w,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                      width: 1.w,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  fillColor: Colors.red,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r)),
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor,
                                        width: 1.w),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.r),
                                    ),
                                    borderSide: BorderSide(
                                        width: 1.w,
                                        color: AppColor.dividerColor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 22.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    validateAndSave(context);
                                    (context as Element).markNeedsBuild();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(328.w, 52.h),
                                    backgroundColor: AppColor.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.r),
                                    ),
                                  ),
                                  child: Text(
                                    "CHANGE_PASSWORD".tr,
                                    style: fontMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ));
                  }),
                ],
              ),
            ),
          ),
        ),
        controller.updateProfileLodear
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
    );
  }

  void validateAndSave(context) {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      controller.updateUserPassword();
      validate = true;
    } else {
      validate = false;
    }
  }
}
