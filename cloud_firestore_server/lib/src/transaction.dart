import 'document_reference.dart';
import 'document_snapshot.dart';
import 'query.dart';
import 'query_snapshot.dart';

class Transaction {
  /// Retrieves a query result.
  /// Holds a pessimistic lock on all returned documents.
  @Deprecated('Unimplemented')
  Future<QuerySnapshot> getQuery(Query query) {
    throw UnimplementedError();
  }

  /// Reads the document referenced by the provided `DocumentReference.`
  /// Holds a pessimistic lock on the returned document.
  ///
  /// ```dart
  /// await firestore.runTransaction((transaction) async {
  ///   final documentRef = firestore.doc('col/doc');
  ///   final doc = await transaction.getDoc(documentRef);
  ///   if (doc.exists) {
  ///     final count = doc.get('count') as int;
  ///     transaction.update(documentRef, { 'count': count + 1 });
  ///   } else {
  ///     transaction.create(documentRef, { 'count': 1 });
  ///   }
  /// });
  /// ```s
  @Deprecated('Unimplemented')
  Future<DocumentSnapshot> getDoc(DocumentReference documentReference) {
    throw UnimplementedError();
  }

  /// Retrieves multiple documents from Firestore. Holds a pessimistic lock on
  /// all returned documents.
  ///
  @Deprecated('Unimplemented')
  Future<List<DocumentSnapshot>> getMultipleDocs(
    List<DocumentReference> documentReferences,
    /** TODO: Insert ReadOptions */
  ) {
    throw UnimplementedError();
  }
}
