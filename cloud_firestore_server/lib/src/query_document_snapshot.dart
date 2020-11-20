import 'document_snapshot.dart';

class QueryDocumentSnapshot extends DocumentSnapshot {
  QueryDocumentSnapshot(String id, Map<String, dynamic> data, {bool/*!*/ exists})
      : super(id, data, exists: exists);

  @override
  bool get exists => true;
}
