import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widgets/loader.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/widget/empty_order_widget.dart';
import '../../home/widget/order_status_widget.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (homeController) => SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "ORDER_HISTORY".tr,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
                centerTitle: false,
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              body: RefreshIndicator(
                color: AppColor.primaryColor,
                onRefresh: () async {
                  Get.find<HomeController>().getOrderList();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  primary: false,
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderHistorySection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            homeController.orderDetailsLoader
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
      ),
    );
  }

  Widget orderHistorySection() {
    return GetBuilder<HomeController>(
        builder: (homeController) => homeController.previousOrderList.isNotEmpty
            ? ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: homeController.previousOrderList.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Row(children: [
                      InkWell(
                        onTap: () {
                          homeController.getOrderDetails(
                              homeController.previousOrderList[index].id!);
                        },
                        child: Container(
                          width: 328.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.itembg.withOpacity(0.8),
                                offset: const Offset(
                                  0.0,
                                  0.0,
                                ),
                                blurRadius: 15.r,
                                spreadRadius: 0.r,
                              ), //BoxShadow
                              //BoxShadow
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Row(children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "ORDER_ID".tr,
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        homeController.previousOrderList[index]
                                            .orderSerialNo!,
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: AppColor.darkBlue),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      if (homeController
                                              .previousOrderList[index]
                                              .status ==
                                          1)
                                        orderStatus(
                                            homeController
                                                .previousOrderList[index]
                                                .statusName,
                                            AppColor.pending,
                                            AppColor.pendingText),
                                      if (homeController
                                              .previousOrderList[index]
                                              .status ==
                                          4)
                                        orderStatus(
                                            homeController
                                                .previousOrderList[index]
                                                .statusName,
                                            AppColor.preparing,
                                            AppColor.preparingText),
                                      if (homeController
                                              .previousOrderList[index]
                                              .status ==
                                          7)
                                        orderStatus(
                                            homeController
                                                .previousOrderList[index]
                                                .statusName,
                                            AppColor.preparing,
                                            AppColor.preparingText),
                                      if (homeController
                                              .previousOrderList[index]
                                              .status ==
                                          10)
                                        orderStatus(
                                            homeController
                                                .previousOrderList[index]
                                                .statusName,
                                            AppColor.preparing,
                                            AppColor.preparingText),
                                      if (homeController
                                              .previousOrderList[index]
                                              .status ==
                                          13)
                                        orderStatus(
                                            homeController
                                                .previousOrderList[index]
                                                .statusName,
                                            AppColor.preparing,
                                            AppColor.preparingText),
                                      if (homeController
                                              .previousOrderList[index]
                                              .status ==
                                          14)
                                        orderStatus(
                                            homeController
                                                .previousOrderList[index]
                                                .statusName,
                                            AppColor.canceled,
                                            AppColor.error),
                                      if (homeController
                                              .previousOrderList[index]
                                              .status ==
                                          19)
                                        orderStatus(
                                            homeController
                                                .previousOrderList[index]
                                                .statusName,
                                            AppColor.canceled,
                                            AppColor.error),
                                      if (homeController
                                              .previousOrderList[index]
                                              .status ==
                                          22)
                                        orderStatus(
                                            homeController
                                                .previousOrderList[index]
                                                .statusName,
                                            AppColor.canceled,
                                            AppColor.error),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    homeController.previousOrderList[index]
                                        .orderDatetime!,
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        Images.iconLocation,
                                        width: 18.w,
                                        height: 18.h,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      SizedBox(
                                        width: 270.w,
                                        child: Text(
                                          homeController
                                              .previousOrderList[index]
                                              .orderAddress!
                                              .address!,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      homeController.getOrderDetails(
                                          homeController
                                              .previousOrderList[index].id!);
                                    },
                                    child: SizedBox(
                                      width: 290.w,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "SEE_ORDER_DETAILS".tr,
                                              style: fontRegularBoldwithColor,
                                            ),
                                            SvgPicture.asset(
                                              Images.iconArrowRight,
                                              width: 12.w,
                                              height: 12.h,
                                              fit: BoxFit.contain,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ),
                      ),
                    ]),
                  );
                },
              )
            : const EmptyOrder());
  }
}
