import 'package:cloud_firestore_server/src/document_reference.dart';
import 'package:cloud_firestore_server/src/precondition.dart';

/// A Firestore [WriteBatch] that can be used to atomically commit multiple
/// write operations at once.
@Deprecated('Unimplemented')
class WriteBatch {
  /// Checks if this write batch has any pending operations.
  @Deprecated('Unimplemented')
  bool get isEmpty {
    throw UnimplementedError();
  }

  /// Create a document with the provided object values. This will fail the
  /// batch if a document exists at its location.
  ///
  /// Returns this [WriteBatch] instance. Used for chaining method calls.
  ///
  /// ```dart
  /// final writeBatch = firestore.batch();
  /// final documentRef = firestore.collection('col').doc();
  ///
  /// writeBatch.create(documentRef, {'foo': 'bar'});
  ///
  /// await writeBatch.commit();
  /// print('Successfully executed batch.');
  /// ```
  @Deprecated('Unimplemented')
  WriteBatch create(DocumentReference documentRef, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  /// Deletes a document from the database.
  ///
  /// [precondition] is an optional [Precondition] to enforce for this delete.
  /// If [precondition.lastUpdateTime] is set, Firestore will enforce that the
  /// document was last updated at lastUpdateTime. Fails the batch if the
  /// document doesn't exist or was last updated at a different time.
  ///
  /// Returns this [WriteBatch] instance. Used for chaining method calls.
  ///
  /// ```dart
  /// final writeBatch = firestore.batch();
  /// final documentRef = firestore.doc('col/doc');
  ///
  /// writeBatch.delete(documentRef);
  ///
  /// await writeBatch.commit();
  /// print('Successfully executed batch.');
  /// ```
  @Deprecated('Unimplemented')
  WriteBatch delete(DocumentReference documentRef,
      {Precondition? precondition,}) {
    throw UnimplementedError();
  }

  /// Write to the document referred to by the provided [DocumentReference].
  ///
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
  /// Returns this [WriteBatch] instance. Used for chaining method calls.
  ///
  /// ```dart
  /// final writeBatch = firestore.batch();
  /// final documentRef = firestore.doc('col/doc');
  ///
  /// writeBatch.set(documentRef, {'foo': 'bar'});
  ///
  /// await writeBatch.commit();
  /// print('Successfully executed batch.');
  /// ```
  @Deprecated('Unimplemented')
  WriteBatch set(
    DocumentReference documentRef,
    Map<String, dynamic> data, {
    bool? merge,
    bool? mergeFields,
  }) {
    throw UnimplementedError();
  }

  /// Update fields of the document referred to by the provided
  /// [DocumentReference]. If the document doesn't yet exist, the update fails
  /// and the entire batch will be rejected.
  ///
  /// Returns this [WriteBatch] instance. Used for chaining method calls.
  ///
  /// ```dart
  /// final writeBatch = firestore.batch();
  /// final documentRef = firestore.doc('col/doc');
  ///
  /// writeBatch.update(documentRef, {'foo': 'bar'});
  ///
  /// await writeBatch.commit();
  /// print('Successfully executed batch.');
  /// ```
  @Deprecated('Unimplemented')
  WriteBatch update(DocumentReference documentRef, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  /// Atomically commits all pending operations to the database and verifies all
  /// preconditions. Fails the entire write if any precondition is not met.
  @Deprecated('Unimplemented')
  Future<void> commit() {
    throw UnimplementedError();
  }
}
