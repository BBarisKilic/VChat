import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vchat/constant/app_asset.dart';
import 'package:vchat/constant/app_color.dart';
import 'package:vchat/constant/app_hero_tag.dart';
import 'package:vchat/utility/time_formatter.dart';
import 'package:vchat/view/chat/chat_view.dart';

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final String? lastMessageTime;
  final String? lastMessageDuration;

  const ChatRoomsTile(
      {Key? key,
      required this.userName,
      required this.chatRoomId,
      this.lastMessageTime,
      this.lastMessageDuration})
      : super(key: key);

  @override
  InkWell build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(ChatView.id, arguments: <String, String>{
          'userName': userName,
          'chatRoomId': chatRoomId
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLeading(),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  _buildSuffix(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Hero _buildLeading() {
    return Hero(
      tag: AppHeroTag.profileImage + userName,
      child: Image.asset(
        AppAsset.anonymLogo,
        width: 20.w,
      ),
    );
  }

  Expanded _buildTitle() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            userName,
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: AppColor.primaryTextColorDark,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 1.5.h),
          Row(
            children: [
              Icon(
                Icons.keyboard_voice,
                color: AppColor.primaryColor,
                size: 2.5.h,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                TimeFormatter.format(
                    duration: Duration(
                        seconds:
                            int.tryParse(lastMessageDuration ?? '0') ?? 0)),
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: AppColor.primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text _buildSuffix() {
    return Text(
      TimeFormatter.fromMilliSecondsToFormattedDate(
          int.tryParse(lastMessageTime ?? '0') ?? 0),
      style: const TextStyle(
          color: AppColor.primaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w700),
    );
  }
}
