import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../abstracts/database_service.dart';

class DatabaseAdapter extends DatabaseService {
  @override
  Future<void> addNewUser(Map<String, dynamic> userData) async {
    FirebaseFirestore.instance
        .collection('users')
        .add(userData)
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  Future<dynamic> getUserDetails(String email) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('userEmail', isEqualTo: email)
        .get()
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  Future<dynamic> searchByName(String search) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('userName', isEqualTo: search)
        .get();
  }

  @override
  Future<void> addChatRoom(
      Map<String, dynamic> chatRoom, String chatRoomId) async {
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Future<dynamic> getPreviousChatDetails(String? chatRoomId) async {
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time')
        .snapshots();
  }

  @override
  Future<void> addMessage(String chatRoomId, chatMessageData) async {
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(chatMessageData.toMap())
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  Future<void> updateLastMessageInfo(
      Map<String, dynamic> lastMessageInfo, String chatRoomId) async {
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .update(lastMessageInfo)
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  Future<dynamic> getUserChats(String currentUser) async {
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .where('users', arrayContains: currentUser)
        .snapshots();
  }
}
