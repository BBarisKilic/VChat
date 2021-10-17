abstract class CoreDatabaseService {
  Future<void> addNewUser(Map<String, dynamic> _userData);
  Future<dynamic> getUserDetails(String _email);
  Future<dynamic> searchByName(String _search);
  Future<void> addChatRoom(Map<String, dynamic> _chatRoom, String _chatRoomId);
  Future<dynamic> getPreviousChatDetails(String? _chatRoomId);
  Future<void> addMessage(String _chatRoomId, _chatMessageData);
  Future<void> updateLastMessageInfo(
      Map<String, dynamic> _lastMessageInfo, String _chatRoomId);
  Future<dynamic> getUserChats(String _currentUser);
}
