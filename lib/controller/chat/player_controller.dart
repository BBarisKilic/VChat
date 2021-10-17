import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:vchat/service/storage_service.dart';

class PlayerController extends GetxController {
  final StorageService _storageService = StorageService();
  final _isRecordPlaying = false.obs;
  final _currentPosition = <int, int>{}.obs;
  late AudioPlayer _audioPlayer;
  Iterable<Reference>? _reference;
  String _loadedChatRoomId = "";
  String _loadedSendBy = "";
  int _loadedTime = -1;
  int _currentId = -1;
  int _currentDuration = -1;
  int _currentSecond = -1;

  bool get isRecordPlaying => _isRecordPlaying.value;
  int get currentId => _currentId;
  Map<int, int> get currentPosition => _currentPosition;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerCompletion.listen((event) async {
      await _audioPlayer.seek(Duration.zero);
      _isRecordPlaying.value = false;
    });
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      if (_currentSecond != duration.inSeconds) {
        _currentSecond = duration.inSeconds;
        _currentPosition[currentId] = _currentSecond;
      }
    });
  }

  @override
  void onClose() async {
    await _audioPlayer.dispose();
    super.onClose();
  }

  void updateCurrentPosition(int _id, int _duration) {
    _currentPosition[_id] = _duration;
  }

  void onPressedPlayButton(int _id, String _chatRoomId, int _duration,
      String _sendBy, int _time) async {
    if (_loadedChatRoomId != _chatRoomId ||
        _loadedSendBy != _sendBy ||
        _loadedTime != _time) {
      _reference = null;
      await _pauseRecord();
      await _audioPlayer.release();
      if (currentId != -1) _currentPosition[_currentId] = _currentDuration;
    }

    _currentId = _id;
    _currentDuration = _duration;
    _currentSecond = -1;

    if (isRecordPlaying) {
      await _pauseRecord();
    } else {
      if (_reference == null) {
        await _loadRecord(_chatRoomId, _sendBy, _time);
      } else {
        await _resumeRecord();
      }
    }
  }

  Future<void> _loadRecord(
      String _chatRoomId, String _sendBy, int _time) async {
    final List<Reference> _references =
        await _storageService.getUserRecords(_chatRoomId, _sendBy);
    _reference = _references.where((element) {
      if (element.name == (_time.toString() + ".wav")) return true;
      return false;
    });
    _loadedChatRoomId = _chatRoomId;
    _loadedSendBy = _sendBy;
    _loadedTime = _time;
    await _playRecord();
  }

  Future<void> _playRecord() async {
    _isRecordPlaying.value = true;
    _audioPlayer.play(await _reference!.elementAt(0).getDownloadURL(),
        isLocal: false);
  }

  Future<void> _resumeRecord() async {
    _isRecordPlaying.value = true;
    await _audioPlayer.resume();
  }

  Future<void> _pauseRecord() async {
    _isRecordPlaying.value = false;
    await _audioPlayer.pause();
  }
}
