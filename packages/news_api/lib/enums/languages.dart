import './enum.dart';

class Languages extends Enum<String> {
  static const AR = const Languages('ar');
  static const DE = const Languages('de');
  static const EN = const Languages('en');
  static const ES = const Languages('es');
  static const FR = const Languages('fr');
  static const HE = const Languages('he');
  static const IT = const Languages('it');
  static const NL = const Languages('nl');
  static const NO = const Languages('no');
  static const PT = const Languages('pt');
  static const RU = const Languages('ru');
  static const SE = const Languages('se');
  static const UD = const Languages('ud');
  static const ZH = const Languages('zh');

  const Languages(String value) : super(value);
}
