import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:vchat/component/message_tile.dart';
import 'package:vchat/constant/app_asset.dart';
import 'package:vchat/constant/app_color.dart';
import 'package:vchat/utility/app_config.dart';
import 'package:vchat/constant/app_hero_tag.dart';
import 'package:vchat/controller/chat/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vchat/utility/message_tile_width_calculator.dart';

part './extension/chat_extension.dart';

class ChatView extends StatelessWidget {
  static const String id = "/chat";

  final ChatController _chatController = Get.find();

  ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.chatBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: _chatMessages(),
              ),
            ),
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 22.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: _chatController.isRecording
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                              AppColor.primaryColor,
                              AppColor.primaryColorDark,
                            ])
                      : LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                              AppColor.primaryColor.withOpacity(0.8),
                              AppColor.primaryColorDark.withOpacity(0.8),
                            ]),
                ),
                child: _chatController.isUploading
                    ? SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              child: LoadingIndicator(
                                  indicatorType:
                                      Indicator.ballClipRotateMultiple,
                                  colors: [Colors.white],
                                  strokeWidth: 4,
                                  backgroundColor: Colors.transparent,
                                  pathBackgroundColor: Colors.black),
                            ),
                            Text(
                              _chatController.currentState,
                              style: const TextStyle(
                                color: AppColor.primaryTextColorLight,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 1.h),
                          ],
                        ),
                      )
                    : _buildRecordArea(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
