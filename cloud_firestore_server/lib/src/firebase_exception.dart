import 'package:meta/meta.dart';

class FirebaseException {
  final String? message;
  final String? code;

  /// The constructor should only be used internally by the package as the API
  /// is subject to change.
  @internal
  FirebaseException({this.code, this.message});

  @override
  String toString() {
    return 'FirebaseException(code: $code, message: $message)';
  }
}
