abstract class CoreDatabaseService {
  Future<void> addNewUser(Map<String, dynamic> userData);
  Future<dynamic> getUserDetails(String email);
  Future<dynamic> searchByName(String search);
  Future<void> addChatRoom(Map<String, dynamic> chatRoom, String chatRoomId);
  Future<dynamic> getPreviousChatDetails(String? chatRoomId);
  Future<void> addMessage(String chatRoomId, chatMessageData);
  Future<void> updateLastMessageInfo(
      Map<String, dynamic> lastMessageInfo, String chatRoomId);
  Future<dynamic> getUserChats(String currentUser);
}
