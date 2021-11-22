import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vchat/core/service/abstracts/core_database_service.dart';
import '../../utility/app_config.dart';
import '../../core/utility/shared_preference_helper.dart';
import '../../service/concretes/database_adapter.dart';

class ChatListController extends GetxController {
  Stream<QuerySnapshot<Object?>>? _chatRooms;
  late final CoreDatabaseService _databaseService;

  Stream<QuerySnapshot<Object?>>? get chatRooms => _chatRooms;

  @override
  onInit() async {
    _databaseService = DatabaseAdapter();
    await _getChatRooms();
    super.onInit();
  }

  Future<void> _getChatRooms() async {
    AppConfig.currentUserName =
        await SharedPreferenceHelper.getUserNameSharedPreference() ?? '';
    try {
      _databaseService
          .getUserChats(AppConfig.currentUserName)
          .then((snapshots) {
        _chatRooms = snapshots;
        debugPrint('Name: ${AppConfig.currentUserName.toUpperCase()}');
        update();
      });
    } catch (e) {
      Get.snackbar('Could get data!', 'Please check your internet connection.');
    }
  }
}
