import 'package:cloud_firestore_server/src/document_snapshot.dart';
import 'package:cloud_firestore_server/src/timestamp.dart';

class QueryDocumentSnapshot extends DocumentSnapshot {
  QueryDocumentSnapshot(
    String id,
    Map<String, dynamic> data, {
    required Timestamp readTime,
    required Timestamp updateTime,
  }) : super.existing(
          id,
          data,
          readTime: readTime,
          updateTime: updateTime,
        );

  @override
  bool get exists => true;
}
