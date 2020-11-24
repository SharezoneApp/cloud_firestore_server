// ignore: import_of_legacy_library_into_null_safe
import 'package:googleapis/firestore/v1.dart' as api;
import 'package:cloud_firestore_server/cloud_firestore_server.dart';
import 'package:quiver/core.dart';

import 'collection_reference.dart';
import 'document_snapshot.dart';
import 'internal/internal.dart';

class DocumentReference {
  final String _path;
  final InstanceResources _instanceResources;

  DocumentReference(this._instanceResources, {required String path})
      : _path = path;

  /// The [Firestore] Instance for this Firestore Database.
  @Deprecated('Unimplemented')
  Firestore get firestore {
    throw UnimplementedError();
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
    assert(collectionPath.isNotEmpty,
        "a collectionPath path must be a non-empty string");
    assert(!collectionPath.contains("//"),
        "a collection path must not contain '//'");
    assert(isValidCollectionPath(collectionPath),
        "a collection path must point to a valid collection.");
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
      doc = await _instanceResources.firestoreApi
          .get('${_instanceResources.databasePath}/documents/$path');
    } on api.DetailedApiRequestError catch (e) {
      if (e.status == 404) {
        return DocumentSnapshot(path.split('/').last, null, exists: false);
      }
      rethrow;
    }
    return DocumentSnapshot(doc.id, doc.fields.toPrimitives(), exists: true);
  }

  /// Writes to the document referred to by this DocumentReference. If the
  /// document does not yet exist, it will be created.
  /// If [SetOptions] are passed, the provided data can be merged into an
  /// existing document.
  ///
  /// If [SetOptions.merge] is true, [set()] merges the values specified in its
  /// [data] argument. Fields omitted from this [set()] call remain untouched.
  /// If [SetOptions.mergeFields] is provided, [set()] only replaces the
  /// specified field paths.
  /// Any field path that is not specified is ignored and remains untouched.
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
    @Deprecated('Unimplemented') SetOptions? options,
  }) async {
    final document = api.Document();
    document.fields = data.toFirestoreMap();

    /// Hat das wirklich die selbe Semantik wie doc.set() bei fstore admin?
    await _instanceResources.firestoreApi
        .patch(document, '${_instanceResources.databasePath}/documents/$path');
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
  /// If [Precondition.lastUpdateTime] is set, Firestore enforces that the
  /// document was last updated at lastUpdateTime. Fails the delete if the
  /// document was last updated at a different time.
  ///
  /// Returns a [WriteResult] that resolves with the delete time.
  ///
  /// ```dart
  /// final documentRef = firestore.doc('col/doc');
  ///
  /// await documentRef.delete()
  /// print('Document successfully deleted.');
  /// ```
  @Deprecated('Unimplemented')
  Future<WriteResult> delete({Precondition? precondition}) {
    throw UnimplementedError();
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
