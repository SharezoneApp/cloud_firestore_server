import 'src/collection_reference.dart';
import 'src/credentials/credentials.dart';
import 'src/document_reference.dart';
import 'src/internal/instance_resources.dart';
import 'src/internal/path_string_validation.dart';

export 'src/collection_reference.dart';
export 'src/document_reference.dart';
export 'src/document_snapshot.dart';
export 'src/query_document_snapshot.dart';
export 'src/query_snapshot.dart';
export 'src/write_result.dart';

class Firestore {
  final InstanceResources _instanceResources;

  static Future<Firestore> newInstance(
      {ServiceAccountCredentials credentials}) async {
    /// Haven't tested [ServiceAccountCredentials.applicationDefault] yet.
    final _credentials =
        credentials ?? ServiceAccountCredentials.applicationDefault();

    return Firestore(await createInstanceResources(_credentials));
  }

  Firestore(this._instanceResources);

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
}
