import 'package:firebase_storage/firebase_storage.dart';
import '../abstracts/storage_service.dart';

class StorageAdapter implements StorageService {
  @override
  Future<List<Reference>> getUserRecords(
      String chatRoomId, String sendBy) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    ListResult listResult = await firebaseStorage
        .ref()
        .child('records')
        .child(chatRoomId)
        .child(sendBy)
        .list();

    return listResult.items;
  }
}
