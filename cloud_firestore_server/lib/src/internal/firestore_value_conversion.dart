import 'package:googleapis/firestore/v1.dart';

extension MapToFirestoreMap on Map<String, dynamic> {
  Map<String, Value> toFirestoreMap() {
    return map((key, value) {
      return MapEntry(key, _toFirestoreValue(value));
    });
  }
}

/// Scheinbar funktioniert [ToFirestoreValue] nicht für eine Liste??
/// z.B. "Class 'List<String>' has no instance method 'toFirestoreValue'."
extension ToFirestoreValueList<T> on Iterable<T> {
  Value toFirestoreValue() {
    final arrVal = ArrayValue()
      ..values = map<Value/*!*/>((e) => (e as dynamic).toFirestoreValue() as Value/*!*/)
          .toList();
    return Value()..arrayValue = arrVal;
  }
}

Value _toFirestoreValue(dynamic val) {
  if (val is String) {
    return Value()..stringValue = val;
  }
  if (val is int) {
    return Value()..integerValue = val.toString();
  }
  if (val is bool) {
    return Value()..booleanValue = val;
  }
  if (val is DateTime) {
    return Value()..timestampValue = val.toUtcIso8601String();
  }
  if (val is double) {
    return Value()..doubleValue = val;
  }
  if (val is List) {
    final arrVal = ArrayValue()
      ..values = val.map<Value>(_toFirestoreValue).toList();
    return Value()..arrayValue = arrVal;
  }
  if (val is Map<String, dynamic>) {
    final mapVals = val.toFirestoreMap();
    final mapVal = MapValue()..fields = mapVals;
    return Value()..mapValue = mapVal;
  }
  if (val is Set) {
    return Value()..arrayValue = _toFirestoreValue(val.toList()).arrayValue;
  }
  throw ArgumentError(
    'Cant convert ${val.runtimeType} to a Firestore Value.',
  );
}

extension ToFirestoreValue on Object {
  Value toFirestoreValue() => _toFirestoreValue(this);
}

extension FirestoreMapToMap on Map<String, Value> {
  Map<String, dynamic> toPrimitives() {
    return map((key, value) => MapEntry(key, value.toPrimitive()));
  }
}

extension ValueToPrimitive on Value {
  dynamic toPrimitive() {
    if (arrayValue != null) {
      return [
        for (final val in arrayValue.values) val.toPrimitive(),
      ];
    }
    if (booleanValue != null) {
      return booleanValue;
    }
    if (bytesValue != null) {
      return bytesValueAsBytes;
    }
    if (doubleValue != null) {
      return doubleValue;
    }
    if (geoPointValue != null) {
      return geoPointValue;
    }
    if (integerValue != null) {
      return int.parse(integerValue);
    }
    if (mapValue != null) {
      return mapValue.fields
          .map((key, value) => MapEntry(key, value.toPrimitive()));
    }
    if (nullValue != null) {
      return null;
    }
    if (referenceValue != null) {
      return referenceValue;
    }
    if (stringValue != null) {
      return stringValue;
    }
    if (timestampValue != null) {
      return DateTime.parse(timestampValue);
    }
    throw UnimplementedError('Cant convert to primtive ${toJson()}');
  }
}

extension DateTimeToUtcIso8601StringExtension on DateTime {
  String toUtcIso8601String() {
    if (!isUtc) {
      return toUtc().toIso8601String();
    }
    return toIso8601String();
  }
}
