import 'package:googleapis/firestore/v1.dart' as api;
import 'package:meta/meta.dart';

import 'collection_reference.dart';
import 'document_snapshot.dart';
import 'firestore_api/document_id_extension.dart';
import 'internal/internal.dart';

class DocumentReference {
  final String path;
  final InstanceResources _instanceResources;

  DocumentReference(this._instanceResources, {@required this.path});

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

  /// Writes to the document referred to by this `DocumentReference`. If the
  /// document does not yet exist, it will be created.
  Future<void> set(Map<String, dynamic> data) async {
    final document = api.Document();
    document.fields = data.toFirestoreMap();

    /// Hat das wirklich die selbe Semantik wie doc.set() bei fstore admin?
    await _instanceResources.firestoreApi
        .patch(document, '${_instanceResources.databasePath}/documents/$path');
  }

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
}
