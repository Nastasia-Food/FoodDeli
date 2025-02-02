import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widgets/loader.dart';
import '../controllers/home_controller.dart';
import '../widget/active_order_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: SizedBox(
                  height: 35.h,
                  child: Image.asset(
                    Images.logo,
                    fit: BoxFit.contain,
                  ),
                ),
                centerTitle: false,
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              body: RefreshIndicator(
                color: AppColor.primaryColor,
                onRefresh: () async {
                  homeController.getOrderList();
                  homeController.getOrderCount();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        homeController.orderCountLoader
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[300]!,
                                      child: Container(
                                        height: 132.h,
                                        width: 156.w,
                                        decoration: BoxDecoration(
                                            color: AppColor.cardGreen,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[300]!,
                                      child: Container(
                                        height: 132.h,
                                        width: 156.w,
                                        decoration: BoxDecoration(
                                            color: AppColor.cardGreen,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 132.h,
                                      width: 156.w,
                                      decoration: BoxDecoration(
                                          color: AppColor.cardGreen,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              Images.iconOrderComplete,
                                              width: 32.w,
                                              height: 32.h,
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              homeController
                                                  .countData.totalDelivered
                                                  .toString(),
                                              style: fontBold,
                                            ),
                                            Text(
                                              "COMPLETE_DELIVERY".tr,
                                              style: fontRegularPro,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 132.h,
                                      width: 156.w,
                                      decoration: BoxDecoration(
                                          color: AppColor.cardsky,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              Images.iconReturnDelivery,
                                              width: 32.w,
                                              height: 32.h,
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              homeController
                                                  .countData.totalReturned
                                                  .toString(),
                                              style: fontBold,
                                            ),
                                            Text(
                                              "RETURN_DELIVERY".tr,
                                              style: fontRegularPro,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 24.h,
                        ),
                        const ActiveOrder()
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
}
