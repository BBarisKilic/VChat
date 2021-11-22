import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  Future<List<Reference>> getUserRecords(
      String _chatRoomId, String _sendBy) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    ListResult listResult = await firebaseStorage
        .ref()
        .child('records')
        .child(_chatRoomId)
        .child(_sendBy)
        .list();

    return listResult.items;
  }
}
