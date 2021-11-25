import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../service/abstracts/database_service.dart';
import '../../utility/app_config.dart';
import '../../service/concretes/database_adapter.dart';
import '../../view/chat/chat_view.dart';

class SearchController extends GetxController {
  late final DatabaseService _coreDatabaseService;
  late final TextEditingController _searchEditingController;
  final _haveUserSearched = false.obs;
  QuerySnapshot? _searchResultSnapshot;

  DatabaseService get databaseService => _coreDatabaseService;
  TextEditingController get searchEditingController => _searchEditingController;
  bool get haveUserSearched => _haveUserSearched.value;
  QuerySnapshot? get searchResultSnapshot => _searchResultSnapshot;

  @override
  onInit() async {
    _coreDatabaseService = DatabaseAdapter();
    _searchEditingController = TextEditingController();
    super.onInit();
  }

  Future<void> initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      EasyLoading.show();
      await Future.delayed(const Duration(milliseconds: 1500));
      _coreDatabaseService
          .searchByName(searchEditingController.text)
          .then((snapshot) {
        _searchResultSnapshot = snapshot;
        EasyLoading.dismiss();
        update();
        _haveUserSearched.value = true;
      });
    }
  }

  String getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return '$b\_$a';
    } else {
      return '$a\_$b';
    }
  }

  void sendMessage(String userName) {
    List<String> users = [AppConfig.currentUserName, userName];
    String chatRoomId = getChatRoomId(AppConfig.currentUserName, userName);
    Map<String, dynamic> chatRoom = {
      'users': users,
      'chatRoomId': chatRoomId,
      'lastMessageTime': 0,
      'lastMessageDuration': 0,
    };

    _coreDatabaseService.addChatRoom(chatRoom, chatRoomId);

    Get.toNamed(ChatView.id, arguments: <String, String>{
      'userName': userName,
      'chatRoomId': chatRoomId
    });
  }
}
