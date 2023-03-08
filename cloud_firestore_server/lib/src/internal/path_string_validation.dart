import 'package:cloud_firestore_server/src/internal/pointer.dart';

/// Helper method exposed to determine whether a given [collectionPath] points to
/// a valid Firestore collection.
///
/// This is exposed to keep the [Pointer] internal to this library.
bool isValidCollectionPath(String collectionPath) {
  return Pointer(collectionPath).isCollection();
}

/// Helper method exposed to determine whether a given [documentPath] points to
/// a valid Firestore document.
///
/// This is exposed to keep the [Pointer] internal to this library.
bool isValidDocumentPath(String documentPath) {
  return Pointer(documentPath).isDocument();
}
