import 'package:cloud_firestore_server/src/timestamp.dart';

class Precondition {
  final bool? exists;
  final Timestamp? lastUpdateTime;

  Precondition({this.exists, this.lastUpdateTime});
}
