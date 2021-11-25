import 'package:intl/intl.dart';

class TimeFormat {
  static format({required Duration duration}) {
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(1, '0');
    String hours = duration.inHours.remainder(60).toString().padLeft(2, '0');
    return hours != '00' ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }

  static formatHHmmss({required Duration duration}) {
    String time = duration.toString().split('.').first.padLeft(8, '0');
    return time;
  }

  static fromMilliSecondsToFormattedDate(int milliSecondsSinceEpoch) {
    final DateTime date =
        DateTime.fromMillisecondsSinceEpoch(milliSecondsSinceEpoch);
    final format = DateFormat('yMd');
    final dateString = format.format(date);
    return dateString;
  }
}
