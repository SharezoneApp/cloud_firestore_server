// ignore: import_of_legacy_library_into_null_safe
import 'package:googleapis/firestore/v1.dart' as api;
import 'internal/internal.dart';
import 'query_document_snapshot.dart';
import 'query_snapshot.dart';

class Query {
  final InstanceResources instanceResources;

  final String path;
  final List<Condition> conditions;
  final int? limitOfDocs;

  Query(
    this.instanceResources, {
    required this.path,
    this.conditions = const [],
    this.limitOfDocs,
  });

  Future<QuerySnapshot> get() async {
    if (conditions.isEmpty) {
      throw UnimplementedError();
    }
    if (conditions.length == 1) {
      final where = conditions.single;
      final docs = await runQuery(
        fieldPath: where.fieldPath,
        operation: where.operation,
        value: where.value,
        collectionId: Pointer(path).components.last,
        parentPath: Pointer(path).parentPathOrNull(),
        api: instanceResources.firestoreApi,
        client: instanceResources.client,
      );
      return _docsToQuerySnapshot(docs);
    }
    final docs = await runMultiConditionQuery(
      conditions: conditions,
      collectionId: Pointer(path).components.last,
      parentPath: Pointer(path).parentPathOrNull(),
      api: instanceResources.firestoreApi,
      client: instanceResources.client,
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

  Query where(
    // TODO: Find out why this is not a string - because of FieldValues?
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
        conditions: List.from(conditions)
          ..add(Condition(
            fieldPath: field as String,
            operation: arrayContains != null ? 'ARRAY_CONTAINS' : 'EQUAL',
            value: arrayContains ?? isEqualTo,
          )));
  }

  Query limit(int limit) {
    return _copyWith(limit: limit);
  }

  Query _copyWith({
    List<Condition>? conditions,
    int? limit,
  }) {
    return Query(
      instanceResources,
      path: path,
      conditions: conditions ?? this.conditions,
      limitOfDocs: limit ?? limitOfDocs,
    );
  }
}
