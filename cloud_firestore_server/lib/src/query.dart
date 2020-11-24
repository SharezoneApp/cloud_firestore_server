// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore_server/cloud_firestore_server.dart';
import 'package:googleapis/firestore/v1.dart' as api;
import 'internal/internal.dart';
import 'query_document_snapshot.dart';
import 'query_snapshot.dart';

enum Direction {
  ascending,
  descending,
}

class Query {
  final InstanceResources _instanceResources;

  final String _path;
  final List<Condition> _conditions;
  final int? _limitOfDocs;

  Query(
    InstanceResources instanceResources, {
    required String path,
    List<Condition> conditions = const [],
    int? limitOfDocs,
  })  : _instanceResources = instanceResources,
        _path = path,
        _conditions = conditions,
        _limitOfDocs = limitOfDocs;

  /// The [Firestore] Instance for this Firestore Database.
  @Deprecated('Unimplemented')
  Firestore get firestore {
    throw UnimplementedError();
  }

  /// Creates and returns a new [Query] with the additional filter that
  /// documents must contain the specified field and that its value should
  /// satisfy the relation constraint provided.
  ///
  /// Returns a new Query that constrains the value of a Document property.
  ///
  /// This function returns a new (immutable) instance of the Query (rather than
  /// modify the existing instance) to impose the filter.
  ///
  /// ```dart
  /// final collectionRef = firestore.collection('col');
  ///
  /// final querySnapshot = await collectionRef.where('foo', isEqualTo: 'bar').get();
  /// for (final documentSnapshot in querySnapshot.docs) {
  ///   print('Found document at ${documentSnapshot.ref.path}');
  /// }
  /// ```
  Query where(
    Object field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object>? arrayContainsAny,
    List<Object>? whereIn,
    List<Object>? whereNotIn,
    bool? isNull,
  }) {
    return _copyWith(
        conditions: List.from(_conditions)
          ..add(Condition(
            fieldPath: field as String,
            operation: arrayContains != null ? 'ARRAY_CONTAINS' : 'EQUAL',
            value: arrayContains ?? isEqualTo,
          )));
  }

  /// Creates and returns a new [Query] that applies a field mask to the result
  /// and returns only the specified subset of fields.
  ///
  /// You can specify a list of field paths to return, or use an empty list to
  /// only return the references of matching documents. That means no data is
  /// included but the Document-ID can be read.
  ///
  /// Queries that contain field masks cannot be listened to via `snapshots()`
  /// listeners.
  ///
  /// This function returns a new (immutable) instance of the Query (rather than
  /// modify the existing instance) to impose the field mask.
  ///
  /// ```dart
  /// final collectionRef = firestore.collection('col');
  /// final documentRef = collectionRef.doc('doc');
  ///
  /// await documentRef.set({'x':10, 'y':5});
  /// final res = await collectionRef.where('x', '>', 5).select('y').get();
  /// final doc = res.docs.first;
  /// assert(doc.get('y') == 5);
  /// assert(doc.get('x') == null);
  /// ```
  @Deprecated('Unimplemented')
  Query select(List<Object> fieldPaths) {
    throw UnimplementedError();
  }

  /// Creates and returns a new [Query] that's additionally sorted by the
  /// specified field, optionally in descending order instead of ascending.
  ///
  /// This function returns a new (immutable) instance of the [Query] (rather
  /// than modify the existing instance) to impose the field mask.
  ///
  /// If [direction] is not specified, it will be [Direction.ascending].
  ///
  /// ```dart
  /// final query = firestore.collection('col').where('foo', isGreaterThan: 42);
  ///
  /// final querySnapshot = await query.orderBy('foo', Direction.descending).get();
  /// for (final documentSnapshot in querySnapshot.docs) {
  ///   print('Found document at ${documentSnapshot.ref.path}');
  /// }
  /// ```
  @Deprecated('Unimplemented')
  Query orderBy(dynamic fieldPath,
      {Direction direction = Direction.ascending}) {
    throw UnimplementedError();
  }

  /// Creates and returns a new [Query] that only returns the first matching
  /// documents.
  ///
  /// This function returns a new (immutable) instance of the [Query] (rather than
  /// modify the existing instance) to impose the limit.
  ///
  /// ```dart
  /// await firestore.collection('Col').add({'foo': 55});
  /// await firestore.collection('Col').add({'foo': 66});
  ///
  /// final querySnapshot = await firestore
  ///     .collection('col')
  ///     .where('foo', isGreaterThan: 42)
  ///     .limit(1)
  ///     .get();
  ///
  /// assert(querySnapshot.docs.length == 1);
  /// ```
  Query limit(int limit) {
    return _copyWith(limit: limit);
  }

  /// Creates and returns a new [Query] that only returns the last matching
  /// documents.
  ///
  /// You must specify at least one [orderBy] clause for limitToLast queries,
  /// otherwise an exception will be thrown during execution.
  ///
  /// Results for [limitToLast] queries cannot be streamed via the `snapshots()`
  /// API.
  ///
  /// ```dart
  /// await firestore.collection('Col').add({'foo': 55});
  /// await firestore.collection('Col').add({'foo': 66});
  /// await firestore.collection('Col').add({'foo': 77});
  /// await firestore.collection('Col').add({'foo': 120});
  ///
  /// final querySnapshot = await firestore
  ///     .collection('col')
  ///     .where('foo', isGreaterThan: 42)
  ///     .orderBy('foo', direction: Direction.ascending)
  ///     .limitToLast(2)
  ///     .get();
  ///
  /// assert(querySnapshot.docs[0].get('foo') == 77);
  /// assert(querySnapshot.docs[1].get('foo') == 120);
  /// ```
  @Deprecated('Unimplemented')
  Query limitToLast(int limit) {
    throw UnimplementedError();
  }

  Future<QuerySnapshot> get() async {
    if (_conditions.isEmpty) {
      throw UnimplementedError();
    }
    if (_conditions.length == 1) {
      final where = _conditions.single;
      final docs = await runQuery(
        fieldPath: where.fieldPath,
        operation: where.operation,
        value: where.value,
        collectionId: Pointer(_path).components.last,
        parentPath: Pointer(_path).parentPathOrNull(),
        api: _instanceResources.firestoreApi,
        client: _instanceResources.client,
      );
      return _docsToQuerySnapshot(docs);
    }
    final docs = await runMultiConditionQuery(
      conditions: _conditions,
      collectionId: Pointer(_path).components.last,
      parentPath: Pointer(_path).parentPathOrNull(),
      api: _instanceResources.firestoreApi,
      client: _instanceResources.client,
    );
    return _docsToQuerySnapshot(docs);
  }

  QuerySnapshot _docsToQuerySnapshot(List<api.Document> docs) {
    final queryDocs = docs
        .map((doc) => QueryDocumentSnapshot(doc.id, doc.fields.toPrimitives(),
            exists: true))
        .toList();
    return QuerySnapshot(queryDocs);
  }

  Query _copyWith({
    List<Condition>? conditions,
    int? limit,
  }) {
    return Query(
      _instanceResources,
      path: _path,
      conditions: conditions ?? _conditions,
      limitOfDocs: limit ?? _limitOfDocs,
    );
  }
}
