import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/constant.dart';
import '../../auth/views/auth_view.dart';
import '../../dashboard/views/dashboard_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final box = GetStorage();
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        if (box.read('isLogedIn') != null && box.read('isLogedIn') != false) {
          Get.offAll(const DashboardView());
        } else {
          Get.offAll(const AuthView());
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        Images.slpashLogo,
        height: 160.h,
        fit: BoxFit.contain,
      )),
    );
  }
}
