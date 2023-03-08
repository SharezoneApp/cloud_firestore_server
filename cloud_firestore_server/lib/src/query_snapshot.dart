import 'package:cloud_firestore_server/src/query_document_snapshot.dart';

class QuerySnapshot {
  final List<QueryDocumentSnapshot> docs;

  QuerySnapshot(this.docs);
}
