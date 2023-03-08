import 'package:cloud_firestore_server/src/internal/internal.dart';
import 'package:collection/collection.dart';
import 'package:quiver/core.dart';

String _reserved = "Paths must not contain '~', '*', '/', '[', or ']'.";

/// A [FieldPath] refers to a field in a document.
///
/// Usage of a [FieldPath] allows querying of Firestore paths whose document ID
/// contains a '.'.
class FieldPath {
  /// The [List] of components which make up this [FieldPath].
  final List<String> components;

  /// Creates a new [FieldPath].
  FieldPath(this.components)
      : assert(components.isNotEmpty),
        assert(components.where((component) => component.isEmpty).isEmpty,
            "Expected all FieldPath components to be non-null or non-empty strings.",);

  /// Returns a special sentinel `FieldPath` to refer to the ID of a document.
  ///
  /// It can be used in queries to sort or filter by the document ID.
  static FieldPathType get documentId {
    return FieldPathType.documentId;
  }

  /// Creates a new [FieldPath] from a string path.
  ///
  /// The [FieldPath] will created by splitting the given path by the
  /// '.' character. If you are trying to match a Firestore field whose
  /// field contains a '.', construct a new [FieldPath] instance and provide
  /// the field as a [List] element.
  FieldPath.fromString(String path)
      : components = path.split('.'),
        assert(path.isNotEmpty),
        assert(!path.startsWith('.')),
        assert(!path.endsWith('.')),
        assert(!path.contains('..')),
        assert(!path.contains('~'), _reserved),
        assert(!path.contains('*'), _reserved),
        assert(!path.contains('/'), _reserved),
        assert(!path.contains('['), _reserved),
        assert(!path.contains(']'), _reserved);

  @override
  bool operator ==(dynamic o) =>
      o is FieldPath && const ListEquality().equals(o.components, components);

  @override
  int get hashCode => hashObjects(components);

  @override
  String toString() => 'FieldPath($components)';
}
