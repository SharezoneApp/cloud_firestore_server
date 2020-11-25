import 'timestamp.dart';

class Precondition {
  final bool? exists;
  final Timestamp? lastUpdateTime;

  Precondition({this.exists, this.lastUpdateTime});
}
