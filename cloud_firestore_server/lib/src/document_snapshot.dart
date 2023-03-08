import 'package:cloud_firestore_server/src/document_reference.dart';
import 'package:cloud_firestore_server/src/timestamp.dart';

class DocumentSnapshot {
  DocumentSnapshot.existing(
    this.id,
    this._data, {
    required this.readTime,
    required Timestamp updateTime,
  })   : exists = true,
        // With this.updateTime one could pass null which is not allowed for
        // existing documents.
        // ignore: prefer_initializing_formals
        updateTime = updateTime;

  DocumentSnapshot.nonExisting(this.id)
      : exists = false,
        _data = const {},
        readTime = Timestamp.now(),
        updateTime = null;

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
  DocumentReference get ref {
    throw UnimplementedError();
  }

  ///  The time the document was created. Null for documents that don't
  ///  exist.
  @Deprecated('Unimplemented')
  Timestamp? get createTime {
    throw UnimplementedError();
  }

  /// The time the document was last updated (at the time the snapshot was
  /// generated). Null for documents that don't exist.
  final Timestamp? updateTime;

  /// The time this snapshot was read.
  final Timestamp readTime;

  final Map<String, dynamic>? _data;

  /// Contains all the data of this [DocumentSnapshot].
  Map<String, dynamic> data() =>
      _data == null ? const {} : Map<String, dynamic>.from(_data!);

  /// Gets a nested field by [String] or [FieldPath] from this [DocumentSnapshot].
  ///
  /// Data can be accessed by providing a dot-notated path or [FieldPath]
  /// which recursively finds the specified data. If no data could be found
  /// at the specified path, a [StateError] will be thrown.
  Object? get(Object field) => _data != null ? _data![field as String] : null;

  /// Gets a nested field by [String] or [FieldPath] from this [DocumentSnapshot].
  ///
  /// Data can be accessed by providing a dot-notated path or [FieldPath]
  /// which recursively finds the specified data. If no data could be found
  /// at the specified path, a [StateError] will be thrown.
  Object? operator [](Object field) => get(field);

  @override
  String toString() {
    return 'DocumentSnapshot(id: $id, data: $_data)';
  }
}
