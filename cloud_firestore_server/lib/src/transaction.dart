import 'package:cloud_firestore_server/src/document_reference.dart';
import 'package:cloud_firestore_server/src/document_snapshot.dart';
import 'package:cloud_firestore_server/src/precondition.dart';
import 'package:cloud_firestore_server/src/query.dart';
import 'package:cloud_firestore_server/src/query_snapshot.dart';

/// A reference to a transaction.
///
/// The Transaction object passed to a transaction's updateFunction provides
/// the methods to read and write data within the transaction context. See
/// [runTransaction()].
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
  /// [fieldMask] is a list of field paths.
  /// It specifies the set of fields to return and reduces the amount
  /// of data transmitted by the backend.
  /// Adding a field mask does not filter results. Documents do not need to
  /// contain values for all the fields in the mask to be part of the result
  /// set.
  ///
  /// ```dart
  /// final firstDoc = firestore.doc('col/doc1');
  /// final secondDoc = firestore.doc('col/doc2');
  /// final resultDoc = firestore.doc('col/doc3');
  ///
  /// firestore.runTransaction((transaction) async {
  ///   final docs = await transaction.getAll([firstDoc, secondDoc]);
  ///   final sum = (docs[0].get('count') as int) + (docs[1].get('count') as int);
  ///   transaction.set(resultDoc, {'sum': sum});
  /// });
  /// ```
  @Deprecated('Unimplemented')
  Future<List<DocumentSnapshot>> getAll(
    List<DocumentReference> documentReferences, {
    List<Object>? fieldMask,
  }) {
    throw UnimplementedError();
  }

  /// Create the document referred to by the provided [DocumentReference].
  /// The operation wil fail the transaction if a document exists at the
  /// specified location.
  ///
  /// @example
  /// ```dart
  /// firestore.runTransaction((transaction) async {
  ///   final documentRef = firestore.doc('col/doc');
  ///   final doc = await transaction.get(documentRef);
  ///   if (!doc.exists) {
  ///     transaction.create(documentRef, { 'foo': 'bar' });
  ///   }
  /// });
  /// ```
  @Deprecated('Unimplemented')
  Transaction create(
      DocumentReference documentReference, Map<String, dynamic> data,) {
    throw UnimplementedError();
  }

  /// Writes to the document referred to by the provided [DocumentReference].
  /// If the document does not exist yet, it will be created.
  /// If you pass [merge] or [mergeFields], the provided data can be merged into
  /// the existing document.
  ///
  /// If [merge] is true, set() merges the values
  /// specified in its data argument. Fields omitted from this set() call
  /// remain untouched.
  /// If [mergeFields] is provided, set() only replaces the specified
  /// field paths. Any field path that is not specified is ignored and remains
  /// untouched.
  ///
  /// ```dart
  /// firestore.runTransaction((transaction) {
  ///   final documentRef = firestore.doc('col/doc');
  ///   transaction.set(documentRef, { 'foo': 'bar' });
  /// });
  /// ```
  @Deprecated('Unimplemented')
  Transaction set(
    DocumentReference documentReference,
    Map<String, dynamic> data, {
    bool? merge,
    bool? mergeFields,
  }) {
    throw UnimplementedError();
  }

  /// Updates fields in the document referred to by the provided
  /// [DocumentReference].
  /// The update will fail if applied to a document that does not exist.
  ///
  /// ```dart
  /// firestore.runTransaction((transaction) async {
  ///   final documentRef = firestore.doc('col/doc');
  ///   final doc = await transaction.get(documentRef);
  ///   if (doc.exists) {
  ///     final newCount = (doc.get('count') as int) + 1;
  ///     transaction.update(documentRef, {'count': newCount});
  ///   } else {
  ///     transaction.create(documentRef, {'count': 1});
  ///   }
  /// });
  /// ```
  @Deprecated('Unimplemented')
  Transaction update(
      DocumentReference documentReference, Map<String, dynamic> data,) {
    throw UnimplementedError();
  }

  /// Deletes the document referred to by the provided [DocumentReference].
  ///
  /// @param {DocumentReference} documentRef A reference to the document to be
  /// deleted.
  /// With [precondition] an optional [Precondition] can be enforced for this
  /// deletetion.
  /// If [Precondition.lastUpdateTime] is set, enforces that the document was
  /// last updated at lastUpdateTime. Fails the transaction if the document
  /// doesn't exist or was last updated at a different time.
  ///
  /// dart```
  /// firestore.runTransaction((transaction) {
  ///   final documentRef = firestore.doc('col/doc');
  ///   transaction.delete(documentRef);
  /// });
  /// ```
  @Deprecated('Unimplemented')
  Transaction delete(DocumentReference documentReference,
      {Precondition? precondition,}) {
    throw UnimplementedError();
  }
}
