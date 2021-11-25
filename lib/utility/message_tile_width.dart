import 'package:sizer/sizer.dart';

class MessageTileWidth {
  static double calculate(Duration _soundDuration) {
    if (_soundDuration.inSeconds > 60) {
      return 70.w;
    } else if (_soundDuration.inSeconds > 50) {
      return 65.w;
    } else if (_soundDuration.inSeconds > 40) {
      return 60.w;
    } else if (_soundDuration.inSeconds > 30) {
      return 55.w;
    } else if (_soundDuration.inSeconds > 20) {
      return 50.w;
    } else if (_soundDuration.inSeconds > 10) {
      return 45.w;
    } else {
      return 40.w;
    }
  }
}
