import 'package:frontend_notes/enums/enum.dart';

class Categories extends Enum<String> {
  static const BUSINESS = const Categories('business');
  static const ENTERTAIMENT = const Categories('entertainment');
  static const GENERAL = const Categories('general');
  static const HEALTH = const Categories('health');
  static const SCIENCE = const Categories('science');
  static const SPORTS = const Categories('sports');
  static const TECHNOLOGY = const Categories('technology');

  const Categories(String value) : super(value);
}
