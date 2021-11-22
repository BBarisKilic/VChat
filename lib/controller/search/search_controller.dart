import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:vchat/utility/app_config.dart';
import 'package:vchat/service/database_service.dart';
import 'package:vchat/view/chat/chat_view.dart';

class SearchController extends GetxController {
  final DatabaseService _databaseMethods = DatabaseService();
  final TextEditingController _searchEditingController =
      TextEditingController();
  final _haveUserSearched = false.obs;
  QuerySnapshot? _searchResultSnapshot;

  DatabaseService get databaseMethods => _databaseMethods;
  TextEditingController get searchEditingController => _searchEditingController;

  bool get haveUserSearched => _haveUserSearched.value;
  QuerySnapshot? get searchResultSnapshot => _searchResultSnapshot;

  Future<void> initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      EasyLoading.show();
      await Future.delayed(const Duration(milliseconds: 1500));
      _databaseMethods
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

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Get.toNamed(ChatView.id, arguments: <String, String>{
      'userName': userName,
      'chatRoomId': chatRoomId
    });
  }
}
