import 'package:frontend_notes/enums/enum.dart';

class SortBy extends Enum<String> {
  static const RELEVANCY = const SortBy('relevancy');
  static const POPULARITY = const SortBy('popularity');
  static const PUBLISHEDAT = const SortBy('publishedAt');

  const SortBy(String value) : super(value);
}
