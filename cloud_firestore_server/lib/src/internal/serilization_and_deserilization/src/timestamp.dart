import 'package:cloud_firestore_server/cloud_firestore_server.dart';

import 'package:cloud_firestore_server/src/internal/serilization_and_deserilization/src/datetime.dart';

extension StringToTimestamp on String {
  Timestamp toTimestampOrThrow() => _toTimestamp(this);
}

Timestamp _toTimestamp(String dateTimeString) {
  return Timestamp.fromDate(dateTimeString.toDateTimeOrThrow());
}

extension TimestampToUtcIsoString on Timestamp {
  String toUtcIsoString() {
    return toDate().toUtc().toIso8601String();
  }
}
