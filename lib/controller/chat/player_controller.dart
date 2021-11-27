import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:vchat/service/abstracts/audio_player_service.dart';
import 'package:vchat/service/concretes/audio_player_adapter.dart';
import '../../service/abstracts/storage_service.dart';
import '../../service/concretes/storage_adapter.dart';

class PlayerController extends GetxController {
  late final StorageService _storageService;
  late final AudioPlayerService _audioPlayerService;
  final _isRecordPlaying = false.obs;
  final _currentPosition = <int, int>{}.obs;
  Iterable<Reference>? _reference;
  String _loadedChatRoomId = '';
  String _loadedSendBy = '';
  int _loadedTime = -1;
  int _currentId = -1;
  int _currentDuration = -1;
  int _currentSecond = -1;

  bool get isRecordPlaying => _isRecordPlaying.value;
  int get currentId => _currentId;
  Map<int, int> get currentPosition => _currentPosition;

  @override
  void onInit() {
    _storageService = StorageAdapter();
    _audioPlayerService = AudioPlayerAdapter();
    _audioPlayerService.getAudioPlayer.onPlayerCompletion.listen((event) async {
      await _audioPlayerService.getAudioPlayer.seek(Duration.zero);
      _isRecordPlaying.value = false;
    });
    _audioPlayerService.getAudioPlayer.onAudioPositionChanged
        .listen((Duration duration) {
      if (_currentSecond != duration.inSeconds) {
        _currentSecond = duration.inSeconds;
        _currentPosition[currentId] = _currentSecond;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _audioPlayerService.dispose();
    super.onClose();
  }

  void updateCurrentPosition(int id, int duration) {
    _currentPosition[id] = duration;
  }

  void onPressedPlayButton(
      int id, String chatRoomId, int duration, String sendBy, int time) async {
    if (_loadedChatRoomId != chatRoomId ||
        _loadedSendBy != sendBy ||
        _loadedTime != time) {
      _reference = null;
      await _pauseRecord();
      await _audioPlayerService.release();
      if (currentId != -1) _currentPosition[_currentId] = _currentDuration;
    }

    _currentId = id;
    _currentDuration = duration;
    _currentSecond = -1;

    if (isRecordPlaying) {
      await _pauseRecord();
    } else {
      if (_reference == null) {
        await _loadRecord(chatRoomId, sendBy, time);
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
      if (element.name == (_time.toString() + '.wav')) return true;
      return false;
    });
    _loadedChatRoomId = _chatRoomId;
    _loadedSendBy = _sendBy;
    _loadedTime = _time;
    await _playRecord();
  }

  Future<void> _playRecord() async {
    _isRecordPlaying.value = true;
    await _audioPlayerService
        .play(await _reference!.elementAt(0).getDownloadURL());
  }

  Future<void> _resumeRecord() async {
    _isRecordPlaying.value = true;
    await _audioPlayerService.resume();
  }

  Future<void> _pauseRecord() async {
    _isRecordPlaying.value = false;
    await _audioPlayerService.pause();
  }
}
