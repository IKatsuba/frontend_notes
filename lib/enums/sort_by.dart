import 'package:frontend_notes/enums/enum.dart';

class SortBy extends Enum<String> {
  static const RELEVANCY = const SortBy('relevancy', 'Relevancy');
  static const POPULARITY = const SortBy('popularity', 'Popularity');
  static const PUBLISHEDAT = const SortBy('publishedAt', 'Published at');

  const SortBy(String value, [String title]) : super(value, title);
}
