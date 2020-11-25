import 'package:meta/meta.dart';

class FirebaseException {
  final String? message;
  final String? code;

  /// Only for internal use!
  @internal
  FirebaseException({this.code, this.message});

  @override
  String toString() {
    return 'FirebaseException(code: $code, message: $message)';
  }
}
