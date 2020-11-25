extension StringToDateTimeOrNullExtension on String {
  /// Ruft DateTime.parse für diesen String auf. Gibt null zurück, falls
  /// [this] null ist.
  DateTime toDateTimeOrThrow() => DateTime.parse(this);
}

extension DateTimeToUtcIso8601StringExtension on DateTime {
  String toUtcIso8601String() {
    if (!isUtc) {
      return toUtc().toIso8601String();
    }
    return toIso8601String();
  }
}
