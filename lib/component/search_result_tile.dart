import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../constant/app_asset.dart';
import '../constant/app_color.dart';
import '../constant/app_hero_tag.dart';
import '../controller/search/search_controller.dart';

class SearchResultTile extends StatelessWidget {
  final String userName;
  final String userEmail;

  final SearchController _searchController = Get.find();

  SearchResultTile({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(
            tag: AppHeroTag.profileImage + userName,
            child: Image.asset(
              AppAsset.anonymLogo,
              width: 12.w,
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    color: AppColor.primaryTextColorDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  userEmail,
                  style: const TextStyle(
                    color: AppColor.primaryTextColorDark,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _searchController.sendMessage(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: <Color>[
                    AppColor.primaryColor,
                    AppColor.primaryColorDark,
                  ]),
                  borderRadius: BorderRadius.circular(4)),
              child: const Text(
                'Message',
                style: TextStyle(
                    color: AppColor.primaryTextColorLight, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
