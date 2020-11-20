import 'document_reference.dart';
import 'snapshot_metadata.dart';
import 'timestamp.dart';

class DocumentSnapshot {
  DocumentSnapshot(this.id, this._data, {this.exists});

  /// This document's given ID for this snapshot.
  final String id;

  /// Returns `true` if the [DocumentSnapshot] exists.
  ///
  /// ```dart
  /// final documentSnapshot = await firestore.doc('col/doc').get();
  /// if(documentSnapshot.exists) {
  ///   print('Data: ${documentSnapshot.data()}');
  /// }
  /// ```
  final bool exists;

  /// Returns the [DocumentReference] of this snapshot.
  @Deprecated('Unimplemented')
  DocumentReference get reference {
    throw UnimplementedError();
  }

  /// Metadata about this [DocumentSnapshot] concerning its source and if it has local
  /// modifications.
  @Deprecated('Unimplemented')
  SnapshotMetadata get metadata {
    throw UnimplementedError();
  }

  ///  The time the document was created. Null for documents that don't
  ///  exist.
  @Deprecated('Unimplemented')
  Timestamp get createdTime {
    throw UnimplementedError();
  }

  final Map<String, dynamic> _data;

  /// Contains all the data of this [DocumentSnapshot].
  Map<String, dynamic> data() =>
      _data == null ? null : Map<String, dynamic>.from(_data);

  /// Gets a nested field by [String] or [FieldPath] from this [DocumentSnapshot].
  ///
  /// Data can be accessed by providing a dot-notated path or [FieldPath]
  /// which recursively finds the specified data. If no data could be found
  /// at the specified path, a [StateError] will be thrown.
  dynamic get(dynamic field) => _data[field];

  /// Gets a nested field by [String] or [FieldPath] from this [DocumentSnapshot].
  ///
  /// Data can be accessed by providing a dot-notated path or [FieldPath]
  /// which recursively finds the specified data. If no data could be found
  /// at the specified path, a [StateError] will be thrown.
  dynamic operator [](dynamic field) => get(field);
}
