import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../core/service/core_database_service.dart';

class DatabaseService extends CoreDatabaseService {
  @override
  Future<void> addNewUser(Map<String, dynamic> _userData) async {
    FirebaseFirestore.instance
        .collection('users')
        .add(_userData)
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  Future<dynamic> getUserDetails(String _email) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('userEmail', isEqualTo: _email)
        .get()
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  Future<dynamic> searchByName(String _search) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('userName', isEqualTo: _search)
        .get();
  }

  @override
  Future<void> addChatRoom(
      Map<String, dynamic> _chatRoom, String _chatRoomId) async {
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(_chatRoomId)
        .set(_chatRoom)
        .catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Future<dynamic> getPreviousChatDetails(String? _chatRoomId) async {
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(_chatRoomId)
        .collection('chats')
        .orderBy('time')
        .snapshots();
  }

  @override
  Future<void> addMessage(String _chatRoomId, _chatMessageData) async {
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(_chatRoomId)
        .collection('chats')
        .add(_chatMessageData.toMap())
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  Future<void> updateLastMessageInfo(
      Map<String, dynamic> _lastMessageInfo, String _chatRoomId) async {
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(_chatRoomId)
        .update(_lastMessageInfo)
        .catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Future<dynamic> getUserChats(String _currentUser) async {
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .where('users', arrayContains: _currentUser)
        .snapshots();
  }
}
