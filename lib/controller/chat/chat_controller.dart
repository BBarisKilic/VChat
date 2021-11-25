import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../service/abstracts/database_service.dart';
import '../../data/effect_data.dart';
import '../../model/effect.dart';
import '../../model/message.dart';
import '../../service/concretes/database_adapter.dart';
import '../../utility/app_config.dart';
import 'package:path/path.dart' as p;

enum soundEffect {
  none,
  robot,
  tremolo,
  phaser,
  reverse,
  whisper,
  metal,
  mountains,
  indoor,
  chrous,
  crusher
}

class ChatController extends GetxController {
  late final FlutterFFmpeg _flutterFFmpeg;
  late final DatabaseService _databaseService;
  final _effects = <Effect>[].obs;
  final _pageOffset = 0.0.obs;
  final _effectLabel = 'Normal'.obs;
  final _showForwardButton = true.obs;
  final _showBackButton = false.obs;
  final _isRecording = false.obs;
  final _isUploading = false.obs;
  final _currentState = 'Sending record...'.obs;
  String? _userName;
  String? _chatRoomId;
  Stream<QuerySnapshot>? _chats;
  FlutterAudioRecorder2? _audioRecorder;
  bool _isSuccessful = true;
  soundEffect _soundEffect = soundEffect.none;
  late String _filePath;
  late String _recordTime;
  late String? _effectCommand;
  late PageController _pageController;

  List<Effect> get effects => _effects;
  double get pageOffset => _pageOffset.value;
  String get effectLabel => _effectLabel.value;
  bool get showForwardButton => _showForwardButton.value;
  bool get showBackButton => _showBackButton.value;
  bool get isRecording => _isRecording.value;
  bool get isUploading => _isUploading.value;
  String get currentState => _currentState.value;
  String? get userName => _userName;
  String? get chatRoomId => _chatRoomId;
  Stream<QuerySnapshot>? get chats => _chats;
  PageController get pageController => _pageController;

  @override
  void onInit() {
    _flutterFFmpeg = FlutterFFmpeg();
    _databaseService = DatabaseAdapter();
    _userName = Get.arguments['userName'];
    _chatRoomId = Get.arguments['chatRoomId'];
    _pageController = PageController(viewportFraction: 0.7);

    _pageController.addListener(() {
      _pageOffset.value = _pageController.page as double;
    });
    _databaseService.getPreviousChatDetails(_chatRoomId).then((val) {
      _chats = val;
      update();
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _createEffectList();
  }

  @override
  void dispose() {
    _pageController.removeListener(() {
      _pageOffset.value = _pageController.page as double;
    });
    _pageController.dispose();
    super.dispose();
  }

  void _createEffectList() {
    for (int i = 0; i < EffectData.data.length; i++) {
      _effects.add(Effect(
          imagePath: EffectData.data[i]['image'],
          name: EffectData.data[i]['name']));
    }
  }

  Future<void> recordSound() async {
    final bool? hasRecordingPermission =
        await FlutterAudioRecorder2.hasPermissions;

    if (hasRecordingPermission ?? false) {
      _isRecording.value = true;
      Directory directory = await getApplicationDocumentsDirectory();

      _recordTime = DateTime.now().millisecondsSinceEpoch.toString();
      String filepath = directory.path + '/' + _recordTime + '.wav';
      _audioRecorder =
          FlutterAudioRecorder2(filepath, audioFormat: AudioFormat.WAV);
      if (_audioRecorder != null) {
        await _audioRecorder!.initialized;
        _audioRecorder!.start();
      }
      _filePath = filepath;
    } else {
      Get.snackbar('Could not record!', 'Please enable recording permission.');
    }
  }

  void uploadSound() async {
    if (_audioRecorder == null) return;

    //stop recording
    await _audioRecorder!.stop();

    _setEffect();

    if (_effectCommand != null) {
      _currentState.value = 'Adding effect...';
      _filePath = await _addEffectToRecord(_effectCommand!);
    }

    _currentState.value = 'Sending record...';

    //get details
    final audioDetails = await _audioRecorder!.current();

    //update screen
    _isRecording.value = false;
    _isUploading.value = true;

    //upload record to firebase
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    try {
      _isSuccessful = true;
      await firebaseStorage
          .ref('records')
          .child(_chatRoomId!)
          .child(AppConfig.currentUserName)
          .child(
              _filePath.substring(_filePath.lastIndexOf('/'), _filePath.length))
          .putFile(File(_filePath));
    } catch (e) {
      _isSuccessful = false;
      Get.snackbar('Could not send!',
          'Error occured while sending message, please check your connection.');
    } finally {
      if (_isSuccessful) {
        Map<String, dynamic> _lastMessageInfo = {
          'lastMessageTime': int.parse(_recordTime),
          'lastMessageDuration': audioDetails!.duration!.inSeconds,
        };

        await _databaseService.updateLastMessageInfo(
            _lastMessageInfo, chatRoomId!);

        await _databaseService.addMessage(
          _chatRoomId!,
          Message(
            duration: audioDetails.duration!.inSeconds,
            sendBy: AppConfig.currentUserName,
            time: int.parse(_recordTime),
          ),
        );
      }
      _soundEffect = soundEffect.none;
      _showBackButton.value = false;
      _showForwardButton.value = true;
      _effectLabel.value = effects[0].name as String;
      _isUploading.value = false;
    }
  }

  void _setEffect() {
    switch (_soundEffect) {
      case soundEffect.none:
        _effectCommand = null;
        break;
      case soundEffect.robot:
        _effectCommand =
            '-filter_complex "afftfilt=real=\'hypot(re,im)*sin(0)\':imag=\'hypot(re,im)*cos(0)\':win_size=512:overlap=0.75"';
        break;
      case soundEffect.tremolo:
        _effectCommand =
            '-filter_complex "apulsator=mode=sine:hz=3:width=0.1:offset_r=0"';
        break;
      case soundEffect.phaser:
        _effectCommand = '-filter_complex "aphaser=type=t:speed=2:decay=0.6"';
        break;
      case soundEffect.reverse:
        _effectCommand = '-filter_complex "areverse"';
        break;
      case soundEffect.whisper:
        _effectCommand =
            '-filter_complex "afftfilt=real=\'hypot(re,im)*cos((random(0)*2-1)*2*3.14)\':imag=\'hypot(re,im)*sin((random(1)*2-1)*2*3.14)\':win_size=128:overlap=0.8"';
        break;
      case soundEffect.metal:
        _effectCommand = '-filter_complex "aecho=0.8:0.88:8:0.8"';
        break;
      case soundEffect.mountains:
        _effectCommand = '-filter_complex "aecho=0.8:0.9:500|1000:0.2|0.1"';
        break;
      case soundEffect.indoor:
        _effectCommand = '-filter_complex "aecho=0.8:0.9:40|50|70:0.4|0.3|0.2"';
        break;
      case soundEffect.chrous:
        _effectCommand =
            '-filter_complex "chorus=0.5:0.9:50|60|70:0.3|0.22|0.3:0.25|0.4|0.3:2|2.3|1.3"';
        break;
      case soundEffect.crusher:
        _effectCommand =
            '-filter_complex "acrusher=level_in=8:level_out=18:bits=8:mode=log:aa=1"';
        break;
      default:
        _effectCommand = null;
        break;
    }
  }

  Future<String> _addEffectToRecord(String effectCommand) async {
    Directory directory = await getApplicationDocumentsDirectory();

    final String safeOriginalRecordPath = '"' + _filePath + '"';
    _recordTime = DateTime.now().millisecondsSinceEpoch.toString();
    final finalRecordPath = p.join(directory.path, '$_recordTime.wav');
    final safeFinalRecordPath = '"' + finalRecordPath + '"';

    try {
      await _flutterFFmpeg.execute(
          '-i $safeOriginalRecordPath $effectCommand $safeFinalRecordPath');
    } on Exception catch (exception) {
      debugPrint('Try Catch for FFMPEG Execution $exception');
    } catch (error) {
      debugPrint('Try Catch for FFMPEG Execution $error');
    }

    return finalRecordPath;
  }

  void _updateEffectLabel(String label) {
    _effectLabel.value = label;
  }

  void backButtonPressed() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void forwardButtonPressed() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void onPageChanged(int i) {
    _updateEffectLabel(effects[i].name as String);

    switch (i) {
      case 0:
        _soundEffect = soundEffect.none;
        _showBackButton.value = false;
        _showForwardButton.value = true;
        break;
      case 1:
        _soundEffect = soundEffect.robot;
        _showBackButton.value = true;
        _showForwardButton.value = true;
        break;
      case 2:
        _soundEffect = soundEffect.tremolo;
        _showBackButton.value = true;
        _showForwardButton.value = true;
        break;
      case 3:
        _soundEffect = soundEffect.phaser;
        _showBackButton.value = true;
        _showForwardButton.value = true;
        break;
      case 4:
        _soundEffect = soundEffect.reverse;
        _showBackButton.value = true;
        _showForwardButton.value = true;
        break;
      case 5:
        _soundEffect = soundEffect.whisper;
        _showBackButton.value = true;
        _showForwardButton.value = true;
        break;
      case 6:
        _soundEffect = soundEffect.metal;
        _showBackButton.value = true;
        _showForwardButton.value = true;
        break;
      case 7:
        _soundEffect = soundEffect.mountains;
        _showBackButton.value = true;
        _showForwardButton.value = true;
        break;
      case 8:
        _soundEffect = soundEffect.indoor;
        _showBackButton.value = true;
        _showForwardButton.value = true;
        break;
      case 9:
        _soundEffect = soundEffect.chrous;
        _showBackButton.value = true;
        _showForwardButton.value = true;
        break;
      case 10:
        _soundEffect = soundEffect.crusher;
        _showForwardButton.value = false;
        _showBackButton.value = true;
        break;
      default:
        break;
    }
  }
}
