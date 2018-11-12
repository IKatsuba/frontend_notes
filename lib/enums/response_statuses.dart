import './enum.dart';

class ResponseStatuses extends Enum<String> {
  static const OK = const ResponseStatuses('ok');
  static const ERROR = const ResponseStatuses('error');

  const ResponseStatuses(String value) : super(value);
}
