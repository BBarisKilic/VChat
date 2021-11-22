import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageService {
  Future<List<Reference>> getUserRecords(String chatRoomId, String sendBy);
}
