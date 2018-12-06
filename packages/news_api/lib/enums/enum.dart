abstract class Enum<T> {
  final T value;
  final String title;

  const Enum(this.value, [this.title]);

  @override
  String toString() {
    return this.title ?? this.value;
  }
}
