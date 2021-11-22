import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vchat/component/chat_rooms_tile.dart';
import 'package:vchat/constant/app_asset.dart';
import 'package:vchat/constant/app_color.dart';
import 'package:vchat/constant/app_hero_tag.dart';
import 'package:vchat/constant/app_string.dart';
import 'package:vchat/core/view/welcome/welcome_view.dart';
import 'package:vchat/utility/app_config.dart';
import 'package:vchat/controller/home/chat_list_controller.dart';
import 'package:vchat/view/search/search_view.dart';

part './extension/home_extension.dart';

class HomeView extends StatelessWidget {
  static const String id = '/home';

  final ChatListController _chatListController = Get.find();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: SafeArea(child: _buildChatRoomsList()),
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          child:
              const Icon(Icons.search, color: AppColor.primaryIconColorLight),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: <Color>[
              AppColor.primaryColor,
              AppColor.primaryColorDark,
            ]),
          ),
        ),
        onPressed: () => Get.toNamed(SearchView.id),
      ),
    );
  }
}
