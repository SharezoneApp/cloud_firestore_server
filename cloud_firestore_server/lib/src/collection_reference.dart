import 'package:cloud_firestore_server/cloud_firestore_server.dart';
import 'package:cloud_firestore_server/src/internal/instance_resources.dart';
import 'package:cloud_firestore_server/src/internal/pointer.dart';
import 'package:quiver/core.dart';

/// A CollectionReference object can be used for adding documents, getting
/// document references, and querying for documents (using the methods
/// inherited from [Query]).
class CollectionReference extends Query {
  final String _path;
  final InstanceResources _instanceResources;

  CollectionReference(
    InstanceResources instanceResources, {
    required String path,
  })   : _path = path,
        _instanceResources = instanceResources,
        super(
          instanceResources,
          path: path,
        );

  /// The last path element of the referenced document.
  ///
  /// ```dart
  /// assert(firestore.doc('col/my-doc').id == 'my-doc');
  /// ```
  String get id {
    return Pointer(path).id;
  }

  /// A reference to the containing Document if this is a subcollection, else
  /// null.
  ///
  /// ```dart
  /// final collectionReference = firestore.doc('col/doc/my-collection');
  /// assert(collectionReference.parent == firestore.doc('col/doc'));
  ///
  /// final collectionReference = firestore.doc('col');
  /// assert(collectionReference.parent == null);
  /// ```
  @Deprecated('Unimplemented')
  CollectionReference? get parent {
    throw UnimplementedError();
  }

  /// A string representing the path of the referenced collection (relative
  /// to the root of the database).
  String get path {
    return _path;
  }

  /// Gets a [DocumentReference] instance that refers to the document at the
  /// specified path.
  /// If no path is specified, an automatically-generated unique ID will be used
  /// for the returned DocumentReference. (CURRENTLY NOT IMPLEMENTED)
  ///
  /// ```dart
  /// final collectionRef = firestore.collection('col');
  /// final documentRefWithName = collectionRef.doc('doc');
  /// final documentRefWithAutoId = collectionRef.doc();
  /// print('Reference with name: ${documentRefWithName.path}');
  /// print('Reference with auto-id: ${documentRefWithAutoId.path}');
  /// ```
  DocumentReference doc(String? documentPath) {
    if (documentPath == null) {
      throw UnimplementedError('Automatic ID generation not implemented');
    }
    final documentPath0 = Pointer(path).documentPath(documentPath);
    return DocumentReference(_instanceResources, path: documentPath0);
  }

  /// Retrieves the list of documents in this collection.
  ///
  /// The document references returned may include references to "missing
  /// documents", i.e. document locations that have no document present but
  /// which contain subcollections with documents. Attempting to read such a
  /// document reference (e.g. via `.get()` or `.onSnapshot()`) will return a
  /// [DocumentSnapshot] whose `.exists` property is false.
  ///
  /// ```dart
  /// final collectionRef = firestore.collection('col');
  ///
  /// final documentRefs = await collectionRef.listDocuments();
  /// final documentSnapshots = await firestore.getAll(documentRefs);
  ///
  /// for (final documentSnapshot in documentSnapshots) {
  ///    if (documentSnapshot.exists) {
  ///      print('Found document with data: ${documentSnapshot.id}');
  ///    } else {
  ///      print('Found missing document: ${documentSnapshot.id}');
  ///    }
  /// }
  ///
  /// ```
  @Deprecated('Unimplemented')
  Future<List<DocumentReference>> listDocuments() {
    throw UnimplementedError();
  }

  /// Add a new document to this collection with the specified data, assigning
  /// it a document ID automatically.
  ///
  /// Returns a [DocumentReference] pointing to the newly created document.
  ///
  /// ```dart
  /// final collectionRef = firestore.collection('col');
  /// final documentReference = await collectionRef.add({foo: 'bar'});
  /// print('Added document with name: ${documentReference.id}');
  /// ```
  @Deprecated('Unimplemented')
  Future<DocumentReference> add(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        other is CollectionReference &&
            other.path == path &&
            other._instanceResources.databasePath ==
                _instanceResources.databasePath;
  }

  @override
  int get hashCode =>
      hash2(path.hashCode, _instanceResources.databasePath.hashCode);

  @override
  String toString() {
    return 'CollectionReference(path: $path)';
  }
}
