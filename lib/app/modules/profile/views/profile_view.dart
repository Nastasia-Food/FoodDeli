// ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking_delivery_boy/app/modules/profile/views/pages_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widgets/loader.dart';
import '../../auth/views/auth_view.dart';
import '../../home/controllers/home_controller.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/profile_controller.dart';
import '../widget/change_language_view.dart';
import '../widget/change_password_view.dart';
import '../widget/edit_profile_view.dart';

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    Get.find<ProfileController>().getPageData();
    if (box.read('isLogedIn') == true) {
      Get.find<ProfileController>().getProfileData();
    }
    super.initState();
  }

  String? imagePath;
  final box = GetStorage();
  ImageSource source = ImageSource.camera;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) => Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "MY_PROFILE".tr,
                            style: const TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 140.h,
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                SizedBox(
                                  width: 100.r,
                                  height: 100.r,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.r)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          profileController.profileData.image!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            // colorFilter: ColorFilter.mode(
                                            //     Colors.red, BlendMode.colorBurn),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        child: Container(
                                            height: 86.h,
                                            width: 154.w,
                                            color: Colors.grey),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[400]!,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 105.w,
                                  height: 105.h,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                      Images.dotCircle,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  width: 100,
                                  bottom: 0,
                                  child: InkWell(
                                    onTap: () {
                                      profileController.getImageFromGallary();
                                    },
                                    child: SizedBox(
                                      width: 44.w,
                                      height: 44.h,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: SizedBox(
                                          width: 40.w,
                                          height: 40.h,
                                          child: CircleAvatar(
                                            backgroundColor: AppColor.darkGray,
                                            child: Image.asset(
                                              Images.iconEdit,
                                              fit: BoxFit.cover,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            profileController.profileData.name.toString(),
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16.sp,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          if (profileController.profileData.email != null)
                            Text(
                              profileController.profileData.email.toString(),
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14.sp,
                                color: AppColor.gray,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Get.find<SplashController>()
                                        .countryInfoData
                                        .callingCode! +
                                    profileController.profileData.phone
                                        .toString(),
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 14.sp,
                                  color: AppColor.gray,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0, bottom: 20.h, top: 10.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(300.r),
                                  child: SvgPicture.asset(
                                    Images.iconBranch,
                                    width: 35.w,
                                    height: 35.h,
                                    fit: BoxFit.contain,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "BRANCH".tr,
                                      style: fontRegular,
                                    ),
                                    box.read('branchId') == 0
                                        ? Text(
                                            "ALL_BRANCH".tr,
                                            style: fontMedium,
                                          )
                                        : SizedBox(
                                            height: 20.h,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount:
                                                  Get.find<HomeController>()
                                                      .branchDataList
                                                      .length,
                                              itemBuilder: (context, index) {
                                                var data =
                                                    Get.find<HomeController>()
                                                        .branchDataList[index];
                                                return data.id ==
                                                        box.read('branchId')
                                                    ? Text(
                                                        data.name.toString(),
                                                        style: fontMedium,
                                                      )
                                                    : SizedBox();
                                              },
                                            ),
                                          )
                                  ],
                                )
                              ],
                            ),
                          ),
                          profileItem(EditProfileView(), Images.iconEditProfile,
                              "EDIT_PROFILE".tr),
                          profileItem(ChangePasswordView(),
                              Images.iconChangePass, "CHANGE_PASSWORD".tr),
                          profileItem(ChangeLanguageView(),
                              Images.iconChangeLang, "CHANGE_LANGUAGE".tr),
                          SizedBox(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    profileController.pageDataList.length,
                                itemBuilder: (BuildContext context, index) {
                                  return profileItem(
                                      PagesScreen(
                                          tittle: profileController
                                              .pageDataList[index].title,
                                          description: profileController
                                              .pageDataList[index].description),
                                      Images.termsCondition,
                                      profileController
                                          .pageDataList[index].title);
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0, bottom: 20.h, top: 10.h),
                            child: InkWell(
                              onTap: () {
                                box.write('isLogedIn', false);
                                (context as Element).markNeedsBuild();
                                Get.offAll(const AuthView());
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        Images.iconLogout,
                                        height: 16.h,
                                        width: 16.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 16.h,
                                      ),
                                      Text(
                                        "LOG_OUT".tr,
                                        style: fontProfile,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ),
          profileController.loader
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
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  InkWell profileItem(route, icon, textValue) {
    return InkWell(
      onTap: () => Get.to(route),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 16.h,
                width: 16.w,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 16.h,
              ),
              Text(
                "$textValue",
                style: fontProfile,
              ),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          const Divider(
            thickness: 1,
            endIndent: 10,
            color: AppColor.dividerColor,
          ),
        ],
      ),
    );
  }
}
