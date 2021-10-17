import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vchat/utility/app_config.dart';
import 'package:vchat/core/utility/shared_preference_helper.dart';
import 'package:vchat/service/database_service.dart';

class ChatListController extends GetxController {
  Stream<QuerySnapshot<Object?>>? _chatRooms;

  Stream<QuerySnapshot<Object?>>? get chatRooms => _chatRooms;

  @override
  onInit() async {
    super.onInit();
    await _getChatRooms();
  }

  Future<void> _getChatRooms() async {
    AppConfig.currentUserName =
        await SharedPreferenceHelper.getUserNameSharedPreference() ?? "";
    try {
      DatabaseService()
          .getUserChats(AppConfig.currentUserName)
          .then((snapshots) {
        _chatRooms = snapshots;
        debugPrint("Name: ${AppConfig.currentUserName.toUpperCase()}");
        update();
      });
    } catch (e) {
      Get.snackbar("Could get data!", "Please check your internet connection.");
    }
  }
}
