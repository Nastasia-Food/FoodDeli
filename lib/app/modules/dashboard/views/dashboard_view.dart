import 'dart:async';

import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helper/device_token.dart';
import '../../../../helper/notification_helper.dart';
import '../../../../util/constant.dart';
import '../../history/views/history_view.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';

import '../../profile/views/profile_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});
  @override
  State<DashboardView> createState() => _MyDashboardViewState();
}

class _MyDashboardViewState extends State<DashboardView> {
  PageController? pageController;
  GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey();
  bool canExit = false;
  int pageIndex = 0;
  NotificationHelper notificationHelper = NotificationHelper();
  DeviceToken deviceToken = DeviceToken();
  @override
  void initState() {
    Get.find<HomeController>().getOrderList();
    Get.find<HomeController>().getOrderCount();
    Get.find<HomeController>().getOrderList();
    Get.find<HomeController>().getOrderCount();
    notificationHelper.notificationPermission();
    deviceToken.getDeviceToken();

    super.initState();
  }

  int _currentPage = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentPage != 0) {
          _setPage(0);
          return false;
        } else {
          if (canExit) {
            _setPage(0);
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('PRESS_BACK_AGAIN_TO_EXIT'.tr,
                    style: const TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColor.primaryColor,
                duration: const Duration(seconds: 2),
                margin: const EdgeInsets.all(10),
              ),
            );
            canExit = true;
            Timer(const Duration(seconds: 2), () {
              canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: const [
            HomeView(),
            HistoryView(),
            ProfileView(),
          ],
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
              Get.find<HomeController>().getOrderList();
            });
          },
        ),
        bottomNavigationBar: BottomBar(
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedIndex: _currentPage,
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() => _currentPage = index);
            // _setPage(index);
          },
          items: <BottomBarItem>[
            BottomBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: ImageIcon(
                  AssetImage(Images.iconHome),
                  size: 24,
                ),
              ),
              title: Text('HOME'.tr),
              inactiveColor: AppColor.gray,
              activeColor: AppColor.primaryColor,
              activeTitleColor: AppColor.primaryColor,
            ),
            BottomBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: ImageIcon(
                  AssetImage(Images.iconHistory),
                  size: 24,
                ),
              ),
              title: Text('HISTORY'.tr),
              inactiveColor: AppColor.gray,
              activeColor: AppColor.primaryColor,
              activeTitleColor: AppColor.primaryColor,
            ),
            BottomBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: ImageIcon(
                  AssetImage(Images.iconProfile),
                  size: 24,
                ),
              ),
              title: Text('PROFILE'.tr),
              inactiveColor: AppColor.gray,
              activeColor: AppColor.primaryColor,
              activeTitleColor: AppColor.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _setPage(int index) {
    setState(() {
      _pageController.jumpToPage(index);
      setState(() => _currentPage = index);
    });
  }
}
