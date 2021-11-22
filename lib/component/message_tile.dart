import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../constant/app_color.dart';
import '../controller/chat/player_controller.dart';
import '../utility/time_formatter.dart';

class MessageTile extends StatelessWidget {
  final PlayerController _playerController = Get.find();

  final int id;
  final String chatRoomId;
  final int duration;
  final String sendBy;
  final int time;
  final bool sendByCurrentUser;
  final double messageTileWidth;

  MessageTile(
      {Key? key,
      required this.id,
      required this.chatRoomId,
      required this.duration,
      required this.sendBy,
      required this.time,
      required this.sendByCurrentUser,
      required this.messageTileWidth})
      : super(key: key) {
    _playerController.updateCurrentPosition(id, duration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 1.h,
        bottom: 1.h,
      ),
      child: Stack(
        alignment:
            sendByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          Container(
            height: 4.h,
            width: messageTileWidth,
            margin: sendByCurrentUser
                ? const EdgeInsets.only(left: 30)
                : const EdgeInsets.only(right: 30),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                gradient: sendByCurrentUser
                    ? LinearGradient(colors: [
                        AppColor.primaryColor.withOpacity(0.7),
                        AppColor.primaryColorDark.withOpacity(0.7)
                      ])
                    : LinearGradient(colors: [
                        AppColor.primaryColorDark.withOpacity(0.7),
                        AppColor.primaryColor.withOpacity(0.7)
                      ])),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            //Changes the order of the children.
            textDirection:
                sendByCurrentUser ? TextDirection.rtl : TextDirection.ltr,
            children: [
              _buildPlayButton(),
              Container(
                color: AppColor.primaryIconColorLight,
                height: 0.2.h,
                //10.w for play button.
                //12.w for duration label.
                //02.w for space on end.
                //24.w => Total.
                width: messageTileWidth - 24.w,
              ),
              _buildDurationLabel(),
            ],
          ),
        ],
      ),
    );
  }

  InkWell _buildPlayButton() {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      highlightColor: Colors.transparent,
      onTap: () => _playerController.onPressedPlayButton(
          id, chatRoomId, duration, sendBy, time),
      child: Container(
        height: 4.h,
        width: 10.w,
        decoration: BoxDecoration(
          borderRadius: sendByCurrentUser
              ? const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))
              : const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
          color: AppColor.primaryIconColorLight,
        ),
        child: Obx(
          () => _playerController.isRecordPlaying &&
                  _playerController.currentId == id
              ? Icon(
                  Icons.pause_rounded,
                  size: 6.w,
                  color: AppColor.primaryColorDark,
                )
              : Icon(
                  Icons.play_arrow_rounded,
                  size: 6.w,
                  color: AppColor.primaryColorDark,
                ),
        ),
      ),
    );
  }

  Container _buildDurationLabel() {
    return Container(
      height: 2.5.h,
      width: 12.w,
      decoration: BoxDecoration(
        borderRadius: sendByCurrentUser
            ? const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(8))
            : const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(30)),
        color: AppColor.primaryIconColorLight,
      ),
      child: Center(
        child: Obx(
          () => Text(
            TimeFormatter.format(
                duration: Duration(
                    seconds: _playerController.currentPosition[id] ?? 0)),
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: AppColor.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
