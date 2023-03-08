import 'package:cloud_firestore_server/cloud_firestore_server.dart';
import 'package:cloud_firestore_server/src/internal/internal.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:googleapis/firestore/v1.dart' as api;
import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

/// A DocumentReference refers to a document location in a Firestore database
/// and can be used to write, read, or listen to the location.
///
/// The document at the referenced location may or may not exist.
///
/// A DocumentReference can also be used to create a [CollectionReference] to a
/// subcollection.
class DocumentReference {
  final String _path;
  final InstanceResources _instanceResources;
  String get _documentName =>
      '${_instanceResources.databasePath}/documents/$path';

  DocumentReference(this._instanceResources, {required String path})
      : _path = path;

  /// The [Firestore] Instance for this Firestore Database.
  @Deprecated('Unimplemented')
  Firestore get firestore {
    throw UnimplementedError();
  }

  /// The last path element of the referenced document.
  ///
  /// ```dart
  /// assert(firestore.doc('col/my-doc').id == 'my-doc');
  /// ```
  String get id {
    return Pointer(_path).id;
  }

  /// A reference to the collection to which this DocumentReference belongs.
  ///
  /// ```dart
  /// final documentRef = firestore.doc('col/doc');
  /// assert(documentRef.parent == firestore.collection('col'));
  /// ```
  @Deprecated('Unimplemented')
  CollectionReference get parent {
    throw UnimplementedError();
  }

  /// A string representing the path of the referenced document (relative
  /// to the root of the database).
  ///
  /// ```dart
  /// final path = firestore
  ///     .collection('letters')
  ///     .doc('my-letter-123')
  ///     .collection('revisions')
  ///     .doc('my-revision-3')
  ///     .path;
  ///
  /// // Prints "letters/my-letter-123/revisions/my-revision-3"
  /// print(path);
  /// ```
  String get path => _path;

  /// Returns a [CollectionReference] instance that refers to the collection at
  /// the specified path.
  ///
  /// ```dart
  /// final documentRef = firestore.doc('col/doc');
  /// final subcollection = documentRef.collection('subcollection');
  ///
  /// // Prints "col/doc/subcollection"
  /// print(subcollection.path);
  /// ```
  CollectionReference collection(String collectionPath) {
    assert(
      collectionPath.isNotEmpty,
      "a collectionPath path must be a non-empty string",
    );
    assert(
      !collectionPath.contains("//"),
      "a collection path must not contain '//'",
    );
    assert(
      isValidCollectionPath(collectionPath),
      "a collection path must point to a valid collection.",
    );
    return CollectionReference(
      _instanceResources,
      path: Pointer(_path).collectionPath(collectionPath),
    );
  }

  /// Notifies of document updates at this location.
  ///
  /// An initial event is immediately sent, and further events will be
  /// sent whenever the document is modified.
  @Deprecated('Unimplemented')
  Stream<DocumentSnapshot> snapshots() {
    throw UnimplementedError();
  }

  /// Fetches the subcollections that are direct children of this document.
  ///
  /// If for example there are the following collections:
  /// * 'countries/france/restaurants'
  /// * 'countries/france/shops'
  /// * 'countries/france/bars'
  /// * 'countries/germany/bars'
  ///
  /// ```dart
  /// final collections = await firestore.doc('countries/france').listCollections();
  /// ```
  /// would return the collections:
  /// * 'countries/france/restaurants'
  /// * 'countries/france/shops'
  /// * 'countries/france/bars'
  ///
  /// ```dart
  /// final documentRef = firestore.doc('col/doc');
  ///
  /// final collections = await documentRef.listCollections()
  /// for (final collection in collections) {
  ///   print('Found subcollection with id: ${collection.id}');
  /// }
  /// ```
  @Deprecated('Unimplemented')
  Future<List<CollectionReference>> listCollections() {
    throw UnimplementedError();
  }

  /// Create a document with the provided object values. This will fail the
  /// write if a document exists at its location.
  ///
  /// ```dart
  /// final documentRef = firestore.collection('col').doc();
  ///
  /// try {
  ///  final res = await documentRef.create({'foo': 'bar'});
  ///  print('Document created at ${res.updateTime}');
  /// } catch (e) {
  ///  print('Failed to create document: $e');
  /// }
  /// ```
  @Deprecated('Unimplemented')
  Future<WriteResult> create(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  /// Reads the document referred to by this DocumentReference.
  ///
  /// Completes with a DocumentSnapshot for the retrieved document on success.
  /// For missing documents, [DocumentSnapshot.exists] will be false.
  ///
  /// If [get()] fails for other reasons, the Future will be fail and an
  /// Exception will be thrown.
  ///
  /// ```dart
  /// final documentRef = firestore.doc('col/doc');
  ///
  /// final res = await documentRef.update({'foo': 'bar'});
  /// print('Document written at ${res.updateTime}');
  /// ```
  Future<DocumentSnapshot> get() async {
    api.Document doc;
    try {
      doc = await _instanceResources.firestoreApi.get(_documentName);
    } on api.DetailedApiRequestError catch (e) {
      if (e.status == 404) {
        return DocumentSnapshot.nonExisting(path.split('/').last);
      }
      rethrow;
    }
    return DocumentSnapshot.existing(
      doc.id,
      doc.fields.toPrimitives(),
      readTime: Timestamp.now(),
      updateTime: doc.updateTime.toTimestampOrThrow(),
    );
  }

  /// Writes to the document referred to by this DocumentReference. If the
  /// document does not yet exist, it will be created.
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
  /// Returns a [WriteResult] with the write time of this set.
  ///
  /// ```dart
  /// final documentRef = firestore.doc('col/doc');
  ///
  /// final res = await documentRef.set({'foo': 'bar'});
  /// print('Document written at ${res.updateTime}');
  /// ```
  Future<void> set(
    Map<String, dynamic> data, {
    @Deprecated('Unimplemented') bool? merge,
    @Deprecated('Unimplemented') bool? mergeFields,
  }) async {
    final document = api.Document();
    document.fields = data.toFirestoreMap();

    /// Hat das wirklich die selbe Semantik wie doc.set() bei fstore admin?
    await _instanceResources.firestoreApi.patch(document, _documentName);
  }

  /// Updates fields in the document referred to by this DocumentReference.
  /// If the document doesn't yet exist, the update fails and the Future fails
  /// (an [Exception] will be thrown).
  ///
  /// A Precondition restricting this update can be specified.
  ///
  /// ```dart
  /// final documentRef = firestore.doc('col/doc');
  ///
  /// documentRef.update({foo: 'bar'}).then(res => {
  ///   console.log(`Document updated at ${res.updateTime}`);
  /// });
  /// ```
  @Deprecated('Unimplemented')
  Future<WriteResult> update() {
    throw UnimplementedError();
  }

  /// Deletes the document referred to by this [DocumentReference].
  ///
  /// A delete for a non-existing document is treated as a success (unless
  /// a Precondition with lastUptimeTime is provided).
  ///
  /// --- [Precondition.lastUpdateTime] DOES NOT WORK YET. ---
  /// If [Precondition.lastUpdateTime] is set, Firestore enforces that the
  /// document was last updated at lastUpdateTime. Fails the delete if the
  /// document was last updated at a different time.
  /// --- [Precondition.lastUpdateTime] DOES NOT WORK YET. ---
  ///
  /// If [Precondition.exists] is true the call will fail if the document does
  /// not exist. Else it will succeed even if there was no document existing
  /// before calling [delete].
  ///
  /// Returns a [WriteResult] that resolves with the delete time.
  /// NOTE: Does not work as the [api.FirestoreApi] does not give back the write
  /// time here.
  ///
  /// ```dart
  /// final documentRef = firestore.doc('col/doc');
  ///
  /// await documentRef.delete()
  /// print('Document successfully deleted.');
  /// ```
  Future<WriteResult> delete({@experimental Precondition? precondition}) async {
    if (precondition?.lastUpdateTime != null) {
      throw UnimplementedError();
    }
    try {
      await _instanceResources.firestoreApi.delete(
        _documentName,
        currentDocument_updateTime:
            precondition?.lastUpdateTime?.toUtcIsoString(),
        currentDocument_exists: precondition?.exists,
      );
    } on api.DetailedApiRequestError catch (e) {
      // We are in the same package why does the linter complain?!
      // ignore: invalid_use_of_internal_member
      throw FirebaseException(
        code: (e.jsonResponse?['error'] as Map<String, dynamic>?)?['status']
            as String?,
        message: e.message,
      );
    }
    // We do not seem to get the Write-Time back here?
    // ignore: avoid_redundant_argument_values
    return WriteResult(writeTime: null);
  }

  @override
  bool operator ==(dynamic o) =>
      o is DocumentReference &&
      o._instanceResources.projectId == o._instanceResources.projectId &&
      o.path == path;

  @override
  int get hashCode => hash2(_instanceResources.projectId, path);

  @override
  String toString() => '$DocumentReference($path)';
}
