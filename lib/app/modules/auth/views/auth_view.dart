import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widgets/loader.dart';
import '../controllers/auth_controller.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    rememberMe = true;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) => Stack(
        children: [
          Scaffold(
            backgroundColor: AppColor.primaryBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: AppColor.primaryBackgroundColor,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Images.logo,
                        height: 32.h,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text('WELCOME_BACK'.tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 32.h, left: 16.w, right: 16.w),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EMAIL'.tr,
                                  style: (TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Rubik')),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                TextFormField(
                                  controller: authController.emailController,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)) {
                                      return "ENTER_VALID_EMAIL".tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.r)),
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
                                SizedBox(
                                  height: 16.h,
                                ),
                                Text(
                                  'PASSWORD'.tr,
                                  style: (TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Rubik')),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                TextFormField(
                                  obscureText: passwordVisible,
                                  controller: authController.passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r"^.{6,}").hasMatch(value)) {
                                      return "PASSWORD_MUST_BE_SIX".tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.r)),
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
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColor.gray,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            passwordVisible = !passwordVisible;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        rememberMe = !rememberMe;
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 16.w,
                                        height: 16.h,
                                        child: rememberMe
                                            ? SvgPicture.asset(
                                                Images.iconTickedYes,
                                                fit: BoxFit.cover,
                                              )
                                            : SvgPicture.asset(
                                                Images.iconTickedNo,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Text('REMEMBER_ME'.tr,
                                          style: fontRegular),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          if (formKey.currentState!
                                              .validate()) {
                                            authController.login(
                                                authController
                                                    .emailController.text,
                                                authController
                                                    .passwordController.text);
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: AppColor.primaryColor,
                                        minimumSize: Size(292.w, 52.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(26.r),
                                        ),
                                      ),
                                      child: Text(
                                        "LOGIN".tr,
                                        style: fontMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          authController.loader
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
}
