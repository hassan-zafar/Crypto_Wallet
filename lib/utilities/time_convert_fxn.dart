import 'package:timeago/timeago.dart' as timeago;

abstract class BaseTimeConvert {
  convertToTimeAgo(int date, {String locale});
}

class TimeConvert implements BaseTimeConvert {
  @override
  String convertToTimeAgo(int date, {String? locale}) {
    DateTime newDate = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    return timeago.format(newDate, locale: locale);
  }
}
