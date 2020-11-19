import 'src/collection_group.dart';
import 'src/collection_reference.dart';
import 'src/credentials/credentials.dart';
import 'src/document_reference.dart';
import 'src/internal/instance_resources.dart';
import 'src/internal/path_string_validation.dart';

export 'src/collection_group.dart';
export 'src/collection_reference.dart';
export 'src/credentials/credentials.dart';
export 'src/document_reference.dart';
export 'src/document_snapshot.dart';
export 'src/query_document_snapshot.dart';
export 'src/query_partition.dart';
export 'src/query_snapshot.dart';
export 'src/write_result.dart';

class Firestore {
  final InstanceResources _instanceResources;

  /// The projectId for this Firestore Instance.
  /// This is the same Id used for your Firebase/GCP project.
  String get projectId => _instanceResources.projectId;

  /// Returns the root path of your database.
  /// Is usually "projects/[YOUR-PROJECT-ID]/databases/(default)"
  String get formattedName => _instanceResources.databasePath;

  static Future<Firestore> newInstance(
      {ServiceAccountCredentials credentials}) async {
    /// Haven't tested [ServiceAccountCredentials.applicationDefault] yet.
    final _credentials =
        credentials ?? ServiceAccountCredentials.applicationDefault();

    return Firestore._(await createInstanceResources(_credentials));
  }

  Firestore._(this._instanceResources);

  /// Gets a [CollectionReference] instance that refers to the collection at the
  /// specified path.
  ///
  /// [collectionPath] is a slash-separated path to a collection.
  ///
  /// ```dart
  /// final collectionRef = firestore.collection('collection');
  ///
  /// // Add a document with an auto-generated ID.
  /// final documentRef = await collectionRef.add({'foo': 'bar'});
  /// print('Added document at ${documentRef.path}');
  /// ```
  CollectionReference collection(String collectionPath) {
    assert(collectionPath != null, "a collection path cannot be null");
    assert(collectionPath.isNotEmpty,
        "a collectionPath path must be a non-empty string");
    assert(!collectionPath.contains("//"),
        "a collection path must not contain '//'");
    assert(isValidCollectionPath(collectionPath),
        "a collection path must point to a valid collection.");
    return CollectionReference(
      _instanceResources,
      path: collectionPath,
    );
  }

  /// Gets a [DocumentReference] instance that refers to the document at the
  /// specified path.
  ///
  /// [documentPath] is a slash-separated path to a document.
  ///
  /// ```dart
  /// final documentRef = firestore.doc('collection/document');
  /// print('Path of document is ${documentRef.path}');
  /// ```
  DocumentReference doc(String documentPath) {
    assert(documentPath != null, "a document path cannot be null");
    assert(
        documentPath.isNotEmpty, "a document path must be a non-empty string");
    assert(
        !documentPath.contains("//"), "a document path must not contain '//'");
    assert(
        documentPath != '/', "a document path must point to a valid document");
    return DocumentReference(_instanceResources, path: documentPath);
  }

  /// Creates and returns a new Query that includes all documents in the
  /// database that are contained in a collection or subcollection with the
  /// given collectionId.
  ///
  /// [collectionId] Identifies the collections to query over.
  /// Every collection or subcollection with this ID as the last segment of its
  /// path will be included. Cannot contain a slash.
  ///
  /// dart```
  /// final docA = firestore.doc('mygroup/docA').set({'foo': 'bar'});
  /// final docB = firestore.doc('abc/def/mygroup/docB').set({'foo': 'bar'});
  ///
  /// await Future.wait([docA, docB]).then((_) {
  ///   final query = firestore
  ///       .collectionGroup('mygroup')
  ///       .where('foo', isEqualTo: 'bar')
  ///       .get()
  ///       .then((snapshot) => print('Found ${snapshot.size} documents.'));
  /// });
  /// ```
  @Deprecated('Unimplemented')
  CollectionGroup collectionGroup(String collectionId) {
    throw UnimplementedError();
  }
}
